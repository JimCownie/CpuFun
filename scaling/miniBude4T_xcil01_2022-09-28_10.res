#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=128 KMP_HW_SUBSET=4T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664353821, formatted: "Wed Sep 28 08:30:21 2022 GMT" }
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
    raw_iterations:      [2630.72,2630.84,2631.53,2630.31,2632.01,2631.33,2629.54,2629.5,2631.19,2630.17]
    context_ms:          18.387536
    sum_ms:              21045.562
    avg_ms:              2630.695
    min_ms:              2629.499
    max_ms:              2632.005
    stddev_ms:           0.884
    giga_interactions/s: 0.608
    gflop/s:             24.316
    gfinst/s:            15.189
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 2629.50, max_ms: 2632.01, sum_ms: 21045.56, avg_ms: 2630.70, ppwi: 1, wgsize: 1 }