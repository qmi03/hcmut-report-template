= Barrier Synchronization Algorithm Selection <barrier-algos>

MellorCrummey et al @sync-algos proposed nuanced recommendations for barrier
synchronization:

1. Broadcast-Based Cache-Coherent Multiprocessors:
  - For modest processor counts: Utilize a centralized counter-based barrier
  - For larger scales: Implement a 4-ary arrival tree with a central sense-reversing
    wakeup flag

2. Multiprocessors Without Coherent Caches or With Directory-Based Coherency:
  - Dissemination Barrier @dissemination:
    - Distributed data structures respecting locality
    - Critical path approximately one-third shorter than tree-based barriers
    - Total interconnect traffic complexity of O(P logP)

  - Tree-Based Barrier @sync-algos:
    - Alternative approach with different performance characteristics
    - Total interconnect traffic complexity of O(P)

The dissemination barrier demonstrates superior performance on architectures
like the Butterfly, which can execute parallel non-interfering network
transactions across multiple processors.
