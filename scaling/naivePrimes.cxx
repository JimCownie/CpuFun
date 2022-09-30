/*
 * A trivial prime sieve intended as a very stupid benchmark.
 * To avoid merely timing I/O, by default it simply outpus the number of primes less than the given argument.
 */

#include <iostream>
#include <stdint.h>
#include <stdlib.h>
#include <vector>
#include <cmath>

void showCompiler() {
// Expand a macro and convert the result into a string
#define STRINGIFY1(...) #__VA_ARGS__
#define STRINGIFY(...) STRINGIFY1(__VA_ARGS__)
  
  #if defined(__cray__)
#define COMPILER_NAME "Cray: " __VERSION__
#elif defined(__INTEL_COMPILER)
#define COMPILER_NAME                                                          \
  "Intel: " STRINGIFY(__INTEL_COMPILER) "v" STRINGIFY(                         \
      __INTEL_COMPILER_BUILD_DATE)
#elif defined(__clang__)
#define COMPILER_NAME                                                          \
  "LLVM: " STRINGIFY(__clang_major__) ":" STRINGIFY(                           \
      __clang_minor__) ":" STRINGIFY(__clang_patchlevel__)
#define UNROLL_LOOP _Pragma("unroll")
#ifndef FALLTHROUGH
#define FALLTHROUGH [[clang::fallthrough]]
#endif
#elif defined(__GNUC__)
#define COMPILER_NAME "GCC: " __VERSION__
#define UNROLL_LOOP _Pragma("GCC unroll")
#ifndef FALLTHROUGH
#define FALLTHROUGH [[gnu::fallthrough]]
#endif
#else
#define COMPILER_NAME "Unknown compiler"
#endif
  std::cout << "Compiler: " COMPILER_NAME << "\n";
}

int main (int argc, char  const ** argv) {
  showCompiler();
  
  uint32_t maxCandidate = argc > 1 ? atoi(argv[1]) : 10000000;
  std::vector<uint32_t> primes;
  primes.push_back(2);
  
  for (uint32_t candidate = 3; candidate < maxCandidate; candidate += 2) {
    uint32_t maxDivisor = sqrt(candidate);
    
    for (const auto divisor : primes) {
      // Reached the end? We have anothe prime.
      if (divisor > maxDivisor) {
        primes.push_back(candidate);
        break;
      }
      // Does this divide? If so  the candidate is not a prime.
      if (candidate % divisor == 0) {
        break;
      }
    }
  }

  
  /* for(const auto& prime: primes) */
  /*       std::cout << prime << ' '; */
  std::cout << "There are " << primes.size() << " primes less than or equal to " << maxCandidate << "\n";
  
  return 0;
}
