= Preliminary Results <results>
This chapter showcases the preliminary test result of the Brook's two-process
barrier algorithm using MPI's RMA operations.
#pagebreak()

== Test Environment
- Hardware: Apple M1 chip
- Compiler: MPICH's mpic++ compiler
- MPI Implementation: MPICH
- Compilation flags: -std=c++11
- Operating System: macOS

== Test Implementation
The test program was designed to verify the basic functionality of the barrier
synchronization:

#figure(
  [
    ```cpp
    int main(int argc, char **argv) {
      // init the mpi world
      MPI_Init(&argc, &argv);
      MPI_Comm comm = MPI_COMM_WORLD;

      // get number of ranks
      int n_ranks;
      MPI_Comm_size(comm, &n_ranks);
      // get current rank
      int rank;
      MPI_Comm_rank(comm, &rank);

      if (n_ranks != 2) {
        if (rank == 0) {
          fprintf(stderr, "This program requires exactly 2 processes.\n");
        }
        MPI_Abort(comm, 1);
      }

      // set the target
      int target_rank = 1 - rank;

      // create a window
      bool exposed_bool{false};
      MPI_Win win_buffer_handler;
      MPI_Win_create(&exposed_bool, sizeof(bool), sizeof(bool), MPI_INFO_NULL, comm,
                     &win_buffer_handler);

      barrier_brook(exposed_bool, win_buffer_handler, target_rank);
      barrier_brook(exposed_bool, win_buffer_handler, target_rank);
      barrier_brook(exposed_bool, win_buffer_handler, target_rank);
      barrier_brook(exposed_bool, win_buffer_handler, target_rank);

      printf("Process %d: reached destination\n", rank);

      return MPI_Finalize();
    }
    ```
  ],
  caption: [Ran the barrier four times to prove the algorithm is reusable.],
)

== Compilation and Execution
The program was compiled using the following command:
```bash
mpic++ -std=c++11 src/brook.cpp -o brook
```

Execution was performed using MPICH's mpirun with two processes:
```bash
mpirun -np 2 ./brook
```

== Results
The test results demonstrated successful barrier synchronization between two
processes:

#figure(image("/static/images/res.png"), caption: [Test results on Apple M1])
