#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=240 KMP_HW_SUBSET=4T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664353961, formatted: "Wed Sep 28 08:32:41 2022 GMT" }
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
    raw_iterations:      [1408.01,1405.96,1405.38,1405.51,1405.06,1405.7,1405.82,1406.18,1405.37,1405.44]
    context_ms:          26.829032
    sum_ms:              11244.459
    avg_ms:              1405.557
    min_ms:              1405.063
    max_ms:              1406.182
    stddev_ms:           0.318
    giga_interactions/s: 1.137
    gflop/s:             45.510
    gfinst/s:            28.428
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 1405.06, max_ms: 1406.18, sum_ms: 11244.46, avg_ms: 1405.56, ppwi: 1, wgsize: 1 }
