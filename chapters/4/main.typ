#import "@preview/lovelace:0.3.0": *
= Adaptation from shared memory to distributed memory <algorithm>

This chapter presents my proposed adaptation of Brook's barrier algorithm within the context of distributed memory models.

@brook_algo presents Brook's barrier algorithm within the context of the shared memory model.

@impl provides a straightforward implementation of Brook's two-process barrier
algorithm in a distributed memory programming model using MPI's Remote Memory Access (RMA) operations.

#pagebreak()
== Brook Algorithm <brook_algo>
Brook @butterfly-barrier bases the n-process barrier on a two-process barrier
using two shared variables. The algorithm is as follows:
#pseudocode-list(
  booktabs: true,
  title: smallcaps[Brook-Barrier-Algorithm],
)[
  + *procedure* Brook's-Barrier(SetByMyProcess, SetByTargetProcess)
    + *while* SetByMyProcess *is* true *do* wait

    + SetByMyProcess ← true

    + *while* SetByTargetProcess *is* false *do* wait

    + SetByTargetProcess ← false

  + *end procedure*
]
#set rect(fill: rgb(white), width: 100%)

We can visualize the algorithm as follows:
#grid(
  columns: (
    0.2fr,
    1fr,
    1fr,
  ), // Auto width for step numbers, equal width for processes
  gutter: 2pt, // Space between columns
  rows: auto, // Rows sized automatically to fit the content
  // Step numbers column
  rect[
    #set align(center)
    #strong([Step])

    *1*

    *2*

    *3*

    *4*
  ],
  // Process 1 column
  rect[
    #set align(left)
    #strong([Process 1])

    while SetByProcess1 do wait;

    SetByProcess1 := true;

    while not SetByProcess2 do wait;

    SetByProcess2 := false;
  ],
  // Process 2 column
  rect[
    #set align(left)
    #strong([Process 2])

    while SetByProcess2 do wait;

    SetByProcess2 := true;

    while not SetByProcess1 do wait;

    SetByProcess1 := false;
  ],
)
== My proposed implementation of Brook's algorithm <impl>
We can extend the concept of Brooks’ two-process barrier, where two processes
share memory through shared variables, to the one-sided communication model.

In this model, one process can directly access the variables of another process.
Instead of storing the shared variables in a common memory segment, each process
maintains its own copy, allowing the other process to read and modify it using
one-sided communication primitives.

This is my simple adaptation of Brook's two-process barrier algorithm to a distributed memory model using MPI RMA operations:

#figure(
  [
    ```
    MPI_BROOK_BARRIER(exposed_flag, win, target_rank)

    INPUTS:
    exposed_flag: BOOL
    win: MPI_WIN
    target_rank: INT

    OUTPUTS:
    None
    ```
  ],
  caption: [Barrier signature],
  kind: raw,
)

#pseudocode-list(
  booktabs: true,
  title: smallcaps[Distributed-Mem-Brook-Barrier],
)[
  + *procedure* Brook's-Barrier(exposed_flag, win, target_rank)

    + *while* exposed_flag *is* true *do* wait

    + exposed_flag ← true

    + *while* target_flag *is* false *do* wait
      + MPI_WIN_LOCK(win)
      + MPI_GET_ACCUMULATE(&target_flag, 0, BOOL, &target_flag, 1, BOOL, target_rank, 0, 1, BOOL, MPI_NO_OP, win);
      + MPI_WIN_FLUSH(win)
      + MPI_WIN_UNLOCK(win)
    + *end while*

    + false_value ← false
    + MPI_WIN_LOCK(win)
    + MPI_ACCUMULATE(&false_value, 1, BOOL, target_rank, 0, 1, BOOL, MPI_REPLACE, win);
    + MPI_WIN_FLUSH(win)
    + MPI_WIN_UNLOCK(win)

  + *end procedure*
]
#figure(
  [],
  caption: [My adaptation of Brook's two-process barrier using MPI primitives],
  kind: raw,
)


=== Notes on the adapted algorithm
The implementation uses `MPI_GET_ACCUMULATE` and `MPI_ACCUMULATE` instead of `MPI_GET` and `MPI_PUT` for
atomicity guarantees. The `MPI_WIN_LOCK` and `MPI_WIN_UNLOCK` functions are used to ensure atomicity of the operations.

