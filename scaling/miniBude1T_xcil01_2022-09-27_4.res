#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=8  KMP_HW_SUBSET=1T KMP_AFFINITY='compact,granularity=fine' ./omp-bude
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
time: { epoch_s:1664279208, formatted: "Tue Sep 27 11:46:48 2022 GMT" }
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
    raw_iterations:      [19395.3,19393.9,19394.5,19393.4,19393.5,19392,19390.5,19392,19394.5,19393]
    context_ms:          11.119272
    sum_ms:              155143.339
    avg_ms:              19392.917
    min_ms:              19390.530
    max_ms:              19394.511
    stddev_ms:           1.278
    giga_interactions/s: 0.082
    gflop/s:             3.299
    gfinst/s:            2.060
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 19390.53, max_ms: 19394.51, sum_ms: 155143.34, avg_ms: 19392.92, ppwi: 1, wgsize: 1 }
