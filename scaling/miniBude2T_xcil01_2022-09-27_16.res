#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=112 KMP_HW_SUBSET=2T KMP_AFFINITY='compact,granularity=fine' ./omp-bude  
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
time: { epoch_s:1664315736, formatted: "Tue Sep 27 21:55:36 2022 GMT" }
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
    raw_iterations:      [1962.02,1961.52,1965.07,1961.19,1962.38,1961.58,1962.14,1960.97,1961.69,1962.75]
    context_ms:          17.197423
    sum_ms:              15697.776
    avg_ms:              1962.222
    min_ms:              1960.970
    max_ms:              1965.075
    stddev_ms:           1.214
    giga_interactions/s: 0.815
    gflop/s:             32.600
    gfinst/s:            20.363
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 1960.97, max_ms: 1965.07, sum_ms: 15697.78, avg_ms: 1962.22, ppwi: 1, wgsize: 1 }
