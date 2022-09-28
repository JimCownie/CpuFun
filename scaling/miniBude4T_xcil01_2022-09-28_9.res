#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=112 KMP_HW_SUBSET=4T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664353791, formatted: "Wed Sep 28 08:29:51 2022 GMT" }
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
    raw_iterations:      [3004.08,3006.19,3005.9,3005.37,3004.11,3004.44,3005.1,3005.51,3007.37,3005.58]
    context_ms:          17.097059
    sum_ms:              24043.389
    avg_ms:              3005.424
    min_ms:              3004.109
    max_ms:              3007.373
    stddev_ms:           0.926
    giga_interactions/s: 0.532
    gflop/s:             21.284
    gfinst/s:            13.295
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 3004.11, max_ms: 3007.37, sum_ms: 24043.39, avg_ms: 3005.42, ppwi: 1, wgsize: 1 }
