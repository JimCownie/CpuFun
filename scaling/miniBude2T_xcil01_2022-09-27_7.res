#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=40 KMP_HW_SUBSET=2T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
miniBUDE:  
compile_commands:
   - "/home/br-jcownie/software/clang-14.x/aarch64/bin/clang++  -DOMP -DUSE_PPWI=1,2,4,8,16,32,64,128 -I<SRC>/omp -I/home/br-jcownie/miniBude/buildAarch64/generated  -Wall -Wextra  -DNDEBUG   -fopenmp=libomp -std=c++17 -o <OUT>/src/main.cpp.o -c <SRC>/main.cpp"
vcs:
  commit:  ecd62a69f5101e98c0748e352118b7138aecb392*
  author:  "Tom Lin (tom91136@gmail.com)"
  date:    "2022-07-30 08:26:33 +0100"
  subject: "Hoist include(FetchContent) to top level"
host_cpu:
  ~
time: { epoch_s:1664315434, formatted: "Tue Sep 27 21:50:34 2022 GMT" }
deck:
  path:         "../data/bm1"
  poses:        65536
  proteins:     938
  ligands:      26
  forcefields:  34
config:
  iterations:   8
  poses:        65536
  ppwi:
    available:  [1,2,4,8,16,32,64,128]
    selected:   [1]
  wgsize:       [1]
device: { index: 0,  name: "OMP CPU" }
# (ppwi=1,wgsize=1,valid=1)
results:
  - outcome:             { valid: true, max_diff_%: 0.002 }
    param:               { ppwi: 1, wgsize: 1 }
    raw_iterations:      [5495.3,5495.05,5495.53,5496.2,5495.07,5494,5493.69,5495.26,5495.32,5495.2]
    context_ms:          12.186892
    sum_ms:              43960.278
    avg_ms:              5495.035
    min_ms:              5493.689
    max_ms:              5496.196
    stddev_ms:           0.761
    giga_interactions/s: 0.291
    gflop/s:             11.641
    gfinst/s:            7.272
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 5493.69, max_ms: 5496.20, sum_ms: 43960.28, avg_ms: 5495.03, ppwi: 1, wgsize: 1 }
