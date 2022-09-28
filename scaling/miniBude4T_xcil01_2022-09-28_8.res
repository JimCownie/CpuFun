#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=96 KMP_HW_SUBSET=4T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664353756, formatted: "Wed Sep 28 08:29:16 2022 GMT" }
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
    raw_iterations:      [3508.65,3509.27,3508.79,3510.64,3509.85,3510.32,3509.7,3511.06,3510.16,3510.42]
    context_ms:          18.249428
    sum_ms:              28080.952
    avg_ms:              3510.119
    min_ms:              3508.794
    max_ms:              3511.060
    stddev_ms:           0.641
    giga_interactions/s: 0.455
    gflop/s:             18.224
    gfinst/s:            11.383
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 3508.79, max_ms: 3511.06, sum_ms: 28080.95, avg_ms: 3510.12, ppwi: 1, wgsize: 1 }
