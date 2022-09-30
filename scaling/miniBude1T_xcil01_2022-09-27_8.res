#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=24  KMP_HW_SUBSET=1T KMP_AFFINITY='compact,granularity=fine' ./omp-bude
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
time: { epoch_s:1664279706, formatted: "Tue Sep 27 11:55:06 2022 GMT" }
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
    raw_iterations:      [6475.43,6477.08,6476.5,6477.01,6477.13,6476.36,6475.79,6475.75,6476.14,6475.83]
    context_ms:          10.983139
    sum_ms:              51810.496
    avg_ms:              6476.312
    min_ms:              6475.749
    max_ms:              6477.126
    stddev_ms:           0.504
    giga_interactions/s: 0.247
    gflop/s:             9.877
    gfinst/s:            6.170
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 6475.75, max_ms: 6477.13, sum_ms: 51810.50, avg_ms: 6476.31, ppwi: 1, wgsize: 1 }
