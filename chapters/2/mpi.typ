= Message Passing Interface (MPI) <mpi>
This section explores Message Passing Interface, its various paradigms
for message passing (@mpi-intro). The section will then shift its focus into MPI's One-Sided Communication
mechanics.

== Introduction <mpi-intro>
MPI @mpi41 is a message-passing library interface specification - essentially a
set of standard guidelines for both implementors and users of the parallel
programming model. In this programming paradigm, data traverses between the
address spaces of different processes through cooperative operations - what we
might call as "classical message-passing techniques".

Beyond the classical model, MPI extends its capabilities by offering:
- Collective operations
- Remote-memory access operations
- Dynamic process creation
- Parallel I/O

Within this thesis, I will specifically dive deep into remote-memory access
operations in MPI, which form the critical building block for MPI's One-Sided
Communication, a concept first introduced in MPI-2 @mpi2, and later refined in MPI-3 @mpi3.

== One-Sided Communications <one-sided-comm>
Unlike "classical" Point-to-Point communication - where
communication is a two-way collaborative effort between processes, with one
sending and another receiving - Remote Memory Access introduces a more flexible
communication mechanism called One-Sided communication.

In this approach, a single MPI process can now independently orchestrate the
entire communication task, by specifying communication parameters for both the
sending and receiving sides.

Regular send/receive communication requires matching operations by sender and
receiver. To issue the matching operations, the application needs to
distribute the transfer parameters. This may require all MPI processes to
participate in a global computation, or to explicitly poll for potential
communication requests to respond periodically.
This could potentially introduce plenty overhead.

The use of RMA communication operations avoids the need for global computation
or explicit polling @mpi41.

Message-passing in general achieves two effects: communication of data from
sender to receiver and synchronization of sender with receiver. RMA design
separates these two functions.

Within MPI standards, the primitive communication operations are as follows:
- Remote write operations: MPI_PUT, MPI_RPUT
- Remote read operations: MPI_GET, MPI_RGET
- Remote update operations: MPI_ACCUMULATE, MPI_RACCUMULATE
- Combined read and update operations: MPI_GET_ACCUMULATE, MPI_RGET_ACCUMULATE,
  and MPI_FETCH_AND_OP
- Remote atomic swap: MPI_COMPARE_AND_SWAP
The primitive synchronization operations are:
- Active Target Communication: MPI_WIN_FENCE, MPI_WIN_POST, MPI_WIN_START,
  MPI_WIN_COMPLETE, MPI_WIN_WAIT
- Passive Target Communication: MPI_WIN_LOCK, MPI_WIN_UNLOCK
Example @mpi41: Implementing a critical region between multiple MPI processes with compare and swap.
The call to MPI_WIN_SYNC is necessary on Process A after local initialization of A to guarantee the public copy has been updated with the initialization value found in the private copy.
It would also be valid to call MPI_ACCUMULATE with MPI_REPLACE to directly initialize the public copy.
A call to MPI_WIN_FLUSH would be necessary to assure A in the public copy of Process A had been updated before the barrier.
#grid(
  columns: (1fr, 1fr), // Auto width for step numbers, equal width for processes
  gutter: 10pt, // Space between columns
  rows: auto, // Rows sized automatically to fit the content
  align: left,
  // Step numbers column
  // Process 1 column
  [ *Process A*],
  [ *Process B*],
  [ MPI_Win_lock_all ],
  [ MPI_Win_lock_all ],
  [ atomic location A ],
  [],
  [ A=0 ],
  [],
  [MPI_Win_sync ],
  [],
  [MPI_Barrier ],
  [MPI_Barrier ],
  [stack variable r = 1 ],
  [stack variable r = 1 ],
  [while(r != 0) do ],
  [while(r != 0) do ],
  [ r = MPI_Compare_and_swap(A, 0, 1) ],
  [ r = MPI_Compare_and_swap(A, 0, 1) ],
  [MPI_Win_flush(A) ],
  [MPI_Win_flush(A) ],
  [done ],
  [done ],
  [\// critical region ],
  [\// critical region ],
  [r = MPI_Compare_and_swap(A, 1, 0) ],
  [r = MPI_Compare_and_swap(A, 1, 0) ],
  [MPI_Win_unlock_all ],
  [MPI_Win_unlock_all],
)
== Memory Model
MPI supports two distinct memory models:

1. Separate Memory Model:
  - No inherent memory consistency assumptions
  - Similar to weakly coherent memory systems
  - Requires explicit synchronization for correct memory access ordering

2. Unified Memory Model:
  - Exploits cache-coherent hardware
  - Supports hardware-accelerated one-sided operations
  - Typically found in high-performance computing environments

The MPI design's flexibility allows implementors to leverage platform-specific
communication mechanisms, including:
- Coherent and non-coherent shared memory
- Direct Memory Access (DMA) engines
- Hardware-supported put/get operations
- Communication coprocessors
