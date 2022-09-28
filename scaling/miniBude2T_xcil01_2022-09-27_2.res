#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=4 KMP_HW_SUBSET=2T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664314314, formatted: "Tue Sep 27 21:31:54 2022 GMT" }
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
    raw_iterations:      [54886.1,54859.6,54873.8,54900.1,54810.2,54813.9,54809.2,54808.8,54817.4,54822.1]
    context_ms:          27.225985
    sum_ms:              438655.448
    avg_ms:              54831.931
    min_ms:              54808.782
    max_ms:              54900.094
    stddev_ms:           32.703
    giga_interactions/s: 0.029
    gflop/s:             1.167
    gfinst/s:            0.729
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 54808.78, max_ms: 54900.09, sum_ms: 438655.45, avg_ms: 54831.93, ppwi: 1, wgsize: 1 }
