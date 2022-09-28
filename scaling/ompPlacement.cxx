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

static std::string formatMask(cpu_set_t const & mask) {
  std::stringstream res;
  
  // Compress runs
  int base = -1;
  int pos;
  for (pos=0; pos<CPU_SETSIZE; pos++) {
    if (CPU_ISSET(pos, &mask)) {
      if (base == -1) {
        base = pos;
      }
    } else {
      if (base != -1) {
        // End of a run, but how long is it?
        // ("That's rather a personal question, Sir" https://montycasinos.com/montypython/scripts/lifeboat.php.html)
        if (pos == (base+1)) {
          // A single element
          res << "," << base;
        } else {
          res << "," << base << "-" << pos-1;
        }
	base = -1;
      }
    }
  }
  if (base != -1) {
    // Finished, but there's a run to print.
    if (pos == (base+1)) {
      // A single element
      res << "," << base;
    } else {
      res << "," << base << "-" << pos-1;
    }
  }
  // Slice off the leading "," 
  return res.str().substr(1);
}

static void showAffinity() {
  int me = omp_get_thread_num();
  cpu_set_t myAffinity;
  if (sched_getaffinity (0, sizeof(cpu_set_t), &myAffinity) != 0) {
    std::cerr << "*** sched_getaffinity failed in thread ***"<< me;
  }

  std::cout << me << ": omp_get_place_num() = " <<
    omp_get_place_num() << ", {" << formatMask(myAffinity) << "}\n" ;
  omp_display_affinity(NULL);
  std::cout << "\n";
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

  std::cout << "OMP_PROC_BIND=\"" << pb << "\", omp_proc_bind() = " << name << "\n";
}

static void outputPlaces() {
  char const * places = getenv("OMP_PLACES");
  places = places ? places : "UNDEFINED";
  std::cout << "OMP_PLACES=\"" << places << "\", omp_get_num_places() = " << omp_get_num_places() << "\n";
}

int main (int, char **) {

  // Force OpenMP initialisation.
#pragma omp parallel
  {
  }

  std::cout << "omp_get_max_threads() = " << omp_get_max_threads() << "\n";
  // This shows how threads are placed. The placement itself is achieved
  // through the OpenMP envirables. (OMP_PLACES, OMP_PROC_BIND).
  outputPlaces();
  outputProcBind();

#pragma omp parallel
  {
    int me = omp_get_thread_num();
    int nthreads = omp_get_num_threads();
    #pragma omp single
    std::cout << "omp_get_num_threads() = " << omp_get_num_threads() << "\n";
    // Ensure no races during output and that the results
    // are in thread order.
    for (int i=0; i<nthreads; i++) {
      if (i == me) {
        showAffinity();
      }
#pragma omp barrier      
    }
  }
  return 0;
}

