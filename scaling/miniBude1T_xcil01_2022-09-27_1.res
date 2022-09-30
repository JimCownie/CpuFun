#  TARGET_MACHINE='ThunderX2 99xx' OMP_NUM_THREADS=1  KMP_HW_SUBSET=1T KMP_AFFINITY='compact,granularity=fine' ./omp-bude
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
time: { epoch_s:1664276492, formatted: "Tue Sep 27 11:01:32 2022 GMT" }
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
    raw_iterations:      [155280,155281,155289,155282,155278,155312,155279,155287,155271,155278]
    context_ms:          28.140926
    sum_ms:              1242276.927
    avg_ms:              155284.616
    min_ms:              155271.240
    max_ms:              155311.748
    stddev_ms:           11.538
    giga_interactions/s: 0.010
    gflop/s:             0.412
    gfinst/s:            0.257
    energies:            
      - 865.52
      - 25.07
      - 368.43
      - 14.67
      - 574.99
      - 707.35
      - 33.95
      - 135.59
best: { min_ms: 155271.24, max_ms: 155311.75, sum_ms: 1242276.93, avg_ms: 155284.62, ppwi: 1, wgsize: 1 }
