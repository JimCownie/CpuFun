#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=56 KMP_HW_SUBSET=2T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664315535, formatted: "Tue Sep 27 21:52:15 2022 GMT" }
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
    raw_iterations:      [3919.45,3919.01,3919.17,3918.51,3918.68,3918.87,3918.39,3918.63,3918.19,3918.81]
    context_ms:          13.331351
    sum_ms:              31349.254
    avg_ms:              3918.657
    min_ms:              3918.186
    max_ms:              3919.168
    stddev_ms:           0.284
    giga_interactions/s: 0.408
    gflop/s:             16.324
    gfinst/s:            10.197
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 3918.19, max_ms: 3919.17, sum_ms: 31349.25, avg_ms: 3918.66, ppwi: 1, wgsize: 1 }
