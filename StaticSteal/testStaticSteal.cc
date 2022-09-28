#include <omp.h>
#include <cstdio>
#include <atomic>
/* Small test for the static steal code.                                                                                
 * This is not the real code, but its core extracted into a smaller test case so that                                   
 * it is self-contained, so easier to feed into Compiler Explorer.                                                      
 * It is also set up simply to be testing the racy case in whcih one
 * thread has all of the work, while others try to steal from it.
 * Since the conflict during the steal is the interesting part, here
 * we only steal a single iteration at a time.
 */

#include <cstdint>
#include <atomic>

// Wrong on Apple M1, but it's a performance issue, not a correctness one,
// and for now we're worrying about correctness.
#define CACHE_ALIGNED alignas(64)

// In the real code may use uint64_t and __uint128_t.
typedef uint32_t unsignedType;
typedef uint64_t pairType;

class contiguousWork {
  // The bounds here are based on a "less than" calculation, since the
  // empty (0,0) case can occur.
  union CACHE_ALIGNED {
    // For some reason GCC requires that we name the struct, while LLVM is happy                                        
    // for it to be anonymous, so we name it, and then have to type a little more                                       
    // in a few places.                                                                                                 
    struct {
      std::atomic<unsignedType> atomicBase;
      std::atomic<unsignedType> atomicEnd;
    } ab;
    pairType pair;
    std::atomic<pairType> atomicPair;
  };
  auto setBase(unsignedType nb, std::memory_order order) {
    return ab.atomicBase.store(nb, order);
  }
  void assign(unsignedType b, unsignedType e) {
    // No need for atomicity here; we're copying into a local value.                                                    
    ab.atomicBase.store(b, std::memory_order_relaxed);
    ab.atomicEnd.store (e, std::memory_order_relaxed);
  }

public:
  contiguousWork() {}
  contiguousWork(unsignedType b, unsignedType e) {
    assign(b,e);
  }
  auto getBase(std::memory_order order = std::memory_order_acquire) const {
    return ab.atomicBase.load(order);
  }
  auto getEnd(std::memory_order order = std::memory_order_acquire) const {
    return ab.atomicEnd.load(order);
  }
  contiguousWork(contiguousWork * other) {
    // N.B. NOT loaded atomically over both parts, but that's fine, since when we update                                
    // we'll use a wide CAS, so if it changed at all we'll see it.                                                      
    assign(other->getBase(), other->getEnd());
  }
  ~contiguousWork() {}

  auto getIterations() const {
    return getEnd() - getBase();
  }
  bool trySteal(unsignedType * basep, unsignedType * endp);
  bool incrementBase(unsignedType * oldp);
};

// This is only executed by the thread which owns this set of contiguousWork,                                           
// and that thread is the only one which ever changes the base value, so we                                             
// don't need to use an atomic add here.                                                                                
bool contiguousWork::incrementBase(unsignedType * basep) {
  auto oldBase = getBase();
  auto oldEnd  = getEnd();

   // Have we run out of iterations?                                                                                    
  if (oldBase >= oldEnd) {
    return false;
  }
  // Update the base value.                                                                                             
  // We need to ensure that the subsequent load does not float above this,                                              
  // so need sequential consistency to prevent that from happening.                                                     
  // Release consistency ensures earlier stores are complete, but does                                                  
  // not prevent the load from floating up...                                                                           
  // setBase(oldBase + 1, std::memory_order_seq_cst);
  setBase(oldBase + 1, std::memory_order_release);

  // Load the end again, so that we can see if it changed while we were                                                 
  // incrementing the base. This thread never moves the end, but other                                                  
  // threads do.                                                                                                        
  auto newEnd = getEnd();

  // Did someone steal the work we thought we were going to take?                                                       
  if (newEnd == oldBase) {
    // Someone stole our last iteration while we were trying to claim it.                                               
    return false;
  }
  else {
    // We got it. It doesn't matter if the end moved down while we were                                                 
    // incrementing the base, as long as it is still above the base we                                                  
    // claimed.  (Say we're claiming iteration zero, while some other thread                                            
    // steals iterations [100,200], that's fine. It doesn't impact on us                                                
    // claiming iteration zero.)                                                                                        
    *basep = oldBase;
    return true;
  }
}

// Try to steal from this chunk of work.                                                                                
bool contiguousWork::trySteal(unsignedType * basep,
                              unsignedType * endp) {

  // Load this once; after that the compare_exchange updates it.                                                        
  contiguousWork oldValues(this);
  for (;;) {
    // oldValues is local, so no-one else is looking at it and                                                          
    // we can use a relaxed memory order here.                                                                          
    auto oldBase = oldValues.getBase(std::memory_order_relaxed);
    auto oldEnd  = oldValues.getEnd(std::memory_order_relaxed);

    // We need this >= to handle the race resolution case mentioned above,                                              
    // which can lead to (1,0) (or equivalent) appearing...                                                             
    if (oldBase >= oldEnd) {
      return false;
    }
    // In this test only ever steal one iteration so that we're doing                                                   
    // as many steal operation as we can.                                                                               
    // In real code we'd steal half the available iterations,                                                           
    // or apply some other heuristic.                                                                                   
    auto newEnd = oldEnd - 1;
    contiguousWork newValues(oldBase, newEnd);
    // Did anything change while we were calculating our parameters?                                                    
    // This is slightly over-cautious. If we're stealing iterations                                                     
    // 1000:2000 it doesn't matter if the owner claims iteration zero, so                                               
    // we might be able to be smarter about this.                                                                       
    if (atomicPair.compare_exchange_weak(oldValues.pair,
                                         newValues.pair,
                                         std::memory_order_acq_rel)) {
      // Compare exchange succeeded, so nothing changed while we were thinking about this                               
      // and we have successfully stolen the value and updated the shared state.                                        
      *basep = newEnd;
      *endp = oldEnd;
      return true;
    }
    // Otherwise the compare_exchange failed, so someone else changed something.                                        
    // That updates oldValues, so we can go around and try again.                                                       
  }
}

#include <unordered_map>

// A threadsafe way to remember information about the loop iterations.                                                  
class lockedHash {
  std::unordered_map<unsignedType, int> theMap;
  omp_lock_t theLock;

public:
  lockedHash() {
    omp_init_lock(&theLock);
  }
  void insert(unsignedType key, int value) {
    omp_set_lock(&theLock); // Claim the lock                                                                           
    theMap.insert({key, value});
    omp_unset_lock(&theLock); // Release the lock                                                                       
  }
  auto lookup(unsignedType key) {
    omp_set_lock(&theLock); // Claim the lock                                                                           
    auto result = theMap.find(key);
    omp_unset_lock(&theLock); // Release the lock                                                                       
    return result == theMap.end() ? -1 : result->second;
  }
  std::unordered_map<unsignedType, int> & getMap() {
    return theMap;
  }
};

#if (0)
void doInsert(int me, lockedHash *theMap, unsignedType value) {
  auto prev = theMap->lookup(value);
  if (prev != -1) {
    printf("Iteration %lu executed by %d and %d\n", value, prev, me);
    return;
  }
  theMap->insert(value, me);
}
#else
#  define doInsert(a,b,c) (void)0
#endif

int main(int, char **) {
  enum {
    iterationsToExecute = 100000
  };
  contiguousWork theWork(0,iterationsToExecute);
  int totalIterations = 0;
  lockedHash iterationMap;
  auto numThreads = omp_get_max_threads();

#pragma omp parallel reduction(+:totalIterations)
  {
    auto me = omp_get_thread_num();

    if (me == 0) {
#if (1)
      unsignedType myIteration;
      while (theWork.incrementBase(&myIteration)) {
        doInsert(me, &iterationMap, myIteration);
        totalIterations++;
      }
#endif
    } else {
      unsignedType myBase, myEnd;
      while (theWork.trySteal(&myBase,&myEnd)) {
        doInsert(me, &iterationMap, myBase);
        totalIterations++;
      }
    }
  }
  printf("%d iterations of %d executed\n", totalIterations, iterationsToExecute);
  if (iterationsToExecute == totalIterations) {
    return 0;
  }
  return -1;
}
