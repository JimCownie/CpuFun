#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=32  KMP_HW_SUBSET=1T KMP_AFFINITY='compact,granularity=fine' ./omp-bude
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
time: { epoch_s:1664279827, formatted: "Tue Sep 27 11:57:07 2022 GMT" }
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
    raw_iterations:      [4849.16,4848.49,4848.61,4848.7,4849.12,4848.59,4848.29,4848.11,4848.23,4848.73]
    context_ms:          11.643528
    sum_ms:              38788.389
    avg_ms:              4848.549
    min_ms:              4848.114
    max_ms:              4849.120
    stddev_ms:           0.305
    giga_interactions/s: 0.330
    gflop/s:             13.193
    gfinst/s:            8.241
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 4848.11, max_ms: 4849.12, sum_ms: 38788.39, avg_ms: 4848.55, ppwi: 1, wgsize: 1 }
