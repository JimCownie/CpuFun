#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=80 KMP_HW_SUBSET=4T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664353714, formatted: "Wed Sep 28 08:28:34 2022 GMT" }
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
    raw_iterations:      [4226.67,4225.63,4227.36,4227.72,4228.41,4225.35,4226.12,4226.9,4227.62,4225.65]
    context_ms:          14.310681
    sum_ms:              33815.126
    avg_ms:              4226.891
    min_ms:              4225.353
    max_ms:              4228.408
    stddev_ms:           1.014
    giga_interactions/s: 0.378
    gflop/s:             15.133
    gfinst/s:            9.453
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 4225.35, max_ms: 4228.41, sum_ms: 33815.13, avg_ms: 4226.89, ppwi: 1, wgsize: 1 }
