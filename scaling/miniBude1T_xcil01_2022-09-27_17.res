#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=60  KMP_HW_SUBSET=1T KMP_AFFINITY='compact,granularity=fine' ./omp-bude
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
time: { epoch_s:1664280083, formatted: "Tue Sep 27 12:01:23 2022 GMT" }
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
    raw_iterations:      [2593.16,2591.58,2593.6,2590.76,2592.52,2590.86,2592.15,2591.74,2592.77,2591.47]
    context_ms:          14.143478
    sum_ms:              20735.871
    avg_ms:              2591.984
    min_ms:              2590.759
    max_ms:              2593.604
    stddev_ms:           0.912
    giga_interactions/s: 0.617
    gflop/s:             24.679
    gfinst/s:            15.416
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 2590.76, max_ms: 2593.60, sum_ms: 20735.87, avg_ms: 2591.98, ppwi: 1, wgsize: 1 }
