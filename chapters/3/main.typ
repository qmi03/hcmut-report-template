= Related Works <related-works>
This section examines two key areas relevant to my implementation: barrier
synchronization algorithms and hybrid parallelization approaches.

@barrier-algos
review MellorCrummey's foundational work on barrier algorithms, which provides
crucial insights into synchronization strategies for different multiprocessor
architectures.

@hybrid explore recent advances in hybrid parallelization, particularly Quaranta
and Maddegedara's novel approach combining MPI-3 shared memory windows with the
C++11 memory model.

#pagebreak()

#set heading(offset: 1)

#{ include "./barrier_algos.typ" }
#{ include "./hybrid.typ" }
