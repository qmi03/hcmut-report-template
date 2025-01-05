= C++11 Multithreading <cpp11>

C++11 (ISO/IEC 14882:2011) introduced native support for multithreading directly
in the Standard Template Library (STL) @williams2019c. This eliminated the
previous reliance on platform-specific threading libraries like POSIX thread
(pthread) and the Microsoft Windows API, offering a more portable and
standardized approach to parallel computing. The introduction of these features
marked a significant advancement in C++ development, providing developers with
powerful, standardized tools for concurrent and parallel programming.

== Core Components
The STL threading components include:

- Thread management (`<thead>`)
- Mutual exclusion (`<mutex>`)
- Condition variables (`<condition_variable>`)
- Atomic operations (`<atomic>`)
- Futures and promises (`<future>`)

== Thread Management
The `<thread>` header has now become the pivot of C++11's multithreading
support. It provides a lightweight, platform-independent mechanism for creating
and managing threads

=== Creating Threads
#figure(
  [
    ```cpp
    #include <thread>
    #include <iostream>

    void worker_function() {
        std::cout << "Thread is running" << std::endl;
    }

    int main() {
        std::thread t(worker_function);  // Create a thread
        t.join();  // Wait for the thread to complete
        return 0;
    }
    ```
  ],
  caption: [Basic thread creation in C++11],
)

Important characteristics of `std::thread`:

- Non-copyable but movable
- Must be either joined or detached before destruction, or else `std::terminate()`
  will be called, resulting in immediate termination of the entire application.
  This is a safety feature to prevent accidental thread abandonment.
- Supports various callable objects (functions, lambdas, function objects)

=== Safe Thread Joining
When exceptions occur in the parent thread, proper thread management becomes
crucial. To prevent unexpected program termination, we can use RAII patterns or
C++20's `std::jthread`.
#figure(
  [
    ```cpp
    #include <thread>
    #include <stdexcept>

    class thread_guard {
        std::thread& t;
    public:
        explicit thread_guard(std::thread& t_) : t(t_) {}
        ~thread_guard() {
            if(t.joinable()) {
                t.join();
            }
        }
        thread_guard(const thread_guard&) = delete;
        thread_guard& operator=(const thread_guard&) = delete;
    };

    void may_throw() {
        throw std::runtime_error("Exception occurred");
    }

    void worker_function() {
        // Thread work here
    }

    int main() {
        std::thread t(worker_function);
        thread_guard g(t);  // RAII wrapper ensures join
        try {
            may_throw();
        }
        catch (...) {
            // Thread will be automatically joined
            throw;
        }
        return 0;
    }
    ```
  ],
  caption: [RAII-based safe thread joining @cpp11],
)

== Synchronization
C++11 provides several RAII-compliant mechanisms to handle mutual exclusion and
prevent race conditions.

=== Basic Mutex Operations
Mutexes (mutual exclusion objects) provide the most fundamental way to protect
shared data. While direct lock/unlock operations are available, they should be
used with caution as they don't provide automatic cleanup in case of exceptions.
#figure(
  [
    ```cpp
    std::mutex mtx;
    mtx.lock();    // Acquire lock
    // Critical section
    mtx.unlock();  // Release lock
    ```
  ],
  caption: [Basic Mutex in C++11],
)

=== RAII Lock Guards
RAII (Resource Acquisition Is Initialization) lock guards provide a safer
alternative to manual mutex locking and unlocking. They automatically release
the mutex when going out of scope, preventing resource leaks and deadlocks.
#figure(
  [
    ```cpp
    #include <mutex>

    class shared_resource {
        std::mutex mtx;
        int data;
    public:
        void safe_operation() {
            std::lock_guard<std::mutex> lock(mtx);
            // Protected operations here
        } // Automatically unlocked
    };
    ```
  ],
  caption: [RAII-based mutex locking],
)
=== Deadlock Prevention
Deadlocks occur when multiple threads are waiting for each other to release
resources. C++11 provides `std::lock` to acquire multiple mutexes simultaneously
using a deadlock avoidance algorithm. Later, C++17 introduced `std::scoped_lock`
which combines this functionality with RAII principles, making it safer and more
convenient to acquire multiple mutexes simultaneously while preventing
deadlocks.
#figure(
  [
    ```cpp
    #include <mutex>

    class complex_resource {
        std::mutex mtx1, mtx2;
    public:
        void safe_operation() {
            std::scoped_lock lock(mtx1, mtx2); // Deadlock-free
            // Protected operations here
        }
    };
    ```
  ],
  caption: [Deadlock prevention using scoped_lock],
)

=== Condition Variables
Condition variables enable threads to coordinate based on actual values or
conditions rather than simply taking turns.

#figure(
  [
    ```cpp
    #include <condition_variable>
    #include <mutex>
    #include <queue>

    std::queue<int> data_queue;
    std::mutex mtx;
    std::condition_variable cv;

    void producer() {
        std::lock_guard<std::mutex> lock(mtx);
        data_queue.push(42);
        cv.notify_one();
    }

    void consumer() {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, []{ return !data_queue.empty(); });
        int data = data_queue.front();
        data_queue.pop();
    }
    ```
  ],
  caption: [Producer-consumer pattern using condition variables],
)

== Atomic Operations
Atomic operations provide lock-free programming capabilities, ensuring that
certain operations are performed as a single, uninterruptible unit.
#figure(
  [
    ```cpp
    #include <atomic>

    struct atomic_counter {
        std::atomic<int> value{0};

        void increment() {
            value.fetch_add(1, std::memory_order_relaxed);
        }

        bool compare_exchange(int expected, int desired) {
            return value.compare_exchange_strong(expected, desired,
                                              std::memory_order_acq_rel);
        }

        int load() const {
            return value.load(std::memory_order_acquire);
        }
    };
    ```
  ],
  caption: [Atomic operations with memory ordering],
)

== Future and Promise
C++11 provides powerful mechanisms for asynchronous programming:
#figure(
  [
    ```cpp
    #include <future>
    #include <stdexcept>

    std::promise<int> compute_promise;

    void compute() {
        try {
            int result = /* complex computation */42;
            compute_promise.set_value(result);
        } catch (...) {
            compute_promise.set_exception(std::current_exception());
        }
    }

    int main() {
        std::future<int> result = compute_promise.get_future();
        std::thread t(compute);

        try {
            int value = result.get(); // Will throw if computation failed
            std::cout << "Result: " << value << std::endl;
        } catch (const std::exception& e) {
            std::cerr << "Computation failed: " << e.what() << std::endl;
        }

        t.join();
        return 0;
    }
    ```
  ],
  caption: [Asynchronous computation with future and promise],
)

== Key Advantages
- Platform-independent threading
- Standard library support
- Type-safe synchronization
- Reduced dependency on platform-specific libraries
- Simplified concurrent programming model

The introduction of these features provided developers with powerful,
standardized API for concurrent and parallel programming without resorting to
platform-specific libraries like pthread.
