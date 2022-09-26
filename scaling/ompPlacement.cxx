/*
 * A simple code to check my understanding of OpenMP placement rules.
 * Requires Linux!
 *
 * Jim Cownie 26 September  2022
 * License: Apache License with LLVM exceptions.
 */

#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
#include <string>
#include <iostream>
#include <sstream>

#define _GNU_SOURCE 1
#include <sched.h>

static std::string formatMask(cpu_set_t & mask) {
  std::stringstream res;
  
  // Compress runs
  int base = -1;
  int pos;
  for (pos=0; i<CPU_SETSIZE;i++) {
    if (CPU_ISSET(pos, mask)) {
      if (base == -1) {
        base = pos;
      }
    } else {
      if (base != -1) {
        // End of a run, but how long is it?
        // ("That's rather a personal question, Sir" https://montycasinos.com/montypython/scripts/lifeboat.php.html)
        if (pos == (base+1)) {
          // A single element
          res << ", " << base;
          base = -1;
        } else {
          res << ", [" << base << ":" << pos-1 << "]";
        }
      }
    }
  }
  if (base != -1) {
    // End of a run, but how long is it?
    // ("That's rather a personal question, Sir" https://montycasinos.com/montypython/scripts/lifeboat.php.html)
    if (pos == (base+1)) {
      // A single element
      res << ", " << base;
      base = -1;
    } else {
      res << ", [" << base << ":" << pos-1 << "]";
    }
  }
  return res.str().substr(2);
}

static void showAffinity() {
  int me = omp_get_thread_num();
  cpu_set_t myAffinity;
  if (sched_getaffinity (0, sizeof(cpu_set_t), &myAffinity) != 0) {
    std::cerr << "*** sched_getaffinity failed in thread ***"<< me;
  }

  std::cout << me << ": omp_get_place_num() = " << omp_get_place_num() << ", " << formatMask(&myAffinity) ;
}

static char const * bindName(omp_proc_bind_t binding) {
  switch (binding) {
  case omp_proc_bind_false: return "false";
  case omp_proc_bind_true: return "true";
  case omp_proc_bind_master: return "master";
  case omp_proc_bind_close: return "close";
  case omp_proc_bind_spread: return "spread";
  default: return "UNKNOWN";
  }
}

static void outputProcBind() {
  char const * pb = getenv("OMP_PROC_BIND");
  pb = pb ? pb : "UNDEFINED";
  char const * name = bindName(omp_get_proc_bind());

  std::cout << "OMP_PROC_BIND=\"" << pb << "\, omp_proc_bind() = " << name;
}

static void outputPlaces() {
  char const * places = getenv("OMP_PLACES");
  places = places ? places : "UNDEFINED";
  std::cout << "OMP_PLACES=\"" << places << "\", omp_get_num_places() = " << omp_get_num_places();
  omp_diaply_affinity();
}

int main (int, char **) {

  // Force OpenMP initialisation.
#pragma omp parallel
  {
  }
  
  // This shows how threads are placed. The placement itself is achieved
  // through the OpenMP envirables. (OMP_PLACES, OMP_PROC_BIND).
  std::cout << "OMP_PLACES = " << getenv("OMP_PLACES");

#pragma omp parallel
  {
    int me = omp_get_thread_num();
    int nthreads = omp_get_num_threads();
    // Ensure no races during output and that the results
    // are in thread order.
#pragma omp for schedule(static,1)
    for (int i=0; i<nthreads; i++) {
      if (i == me) {
        showAffinity();
      }
    }
  }
  return 0;
}

