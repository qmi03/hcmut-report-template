= Project report structure <structure>
The rest of this report is organized as follows:

*@background[] Background*

This chapter establishes the theoretical and technical foundations of the research through three main sections:

@mpi Message Passing Interface (MPI-3)

- Evolution and significance in distributed computing
- Advanced communication mechanisms, focusing on One-Sided Communications
- Remote Memory Access (RMA) operations and memory models
- Collective operations and parallel I/O capabilities


@cpp11 Modern C++11 Multithreading

- Native threading support and platform independence
- Thread management and synchronization primitives
- Memory model and atomic operations
- Asynchronous programming features and their implications


@hpc-context High-Performance Computing Context

- Integration of shared and distributed memory paradigms
- Hybrid programming models in modern HPC

*@related-works[] Related Works*

Surveys existing research and approaches to barrier synchronization algorithms.

*@algorithm[] Adaptation from shared memory to distributed memory*

This chapter introduces an adaptation of Brook’s barrier algorithm,
originally designed for shared memory models, to distributed memory systems using MPI’s Remote Memory Access (RMA) operations.

This implementation leverages MPI RMA primitives for efficient communication in distributed memory systems, preserving the core synchronization logic of Brook’s original algorithm.

*@results[] Preliminary Results*

Presents the implementation outcomes, experimental results, and performance
analysis.

*@conclusions[] Conclusions and Future Works*

Summarizes accomplishments, outlines future research directions, and provides a
timeline for planned activities.
