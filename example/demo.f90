!> Demonstration of the ForUnitTest framework.
!>
!> This example shows how to write and run a simple suite of unit tests using ForUnitTest.
!>
!> ## Supported Data Types
!>
!> The `check` method is overloaded to support:
!>
!> - **`real(rk)`** values: scalar, 1D array, or 2D array
!> - **`integer`** values: scalar, 1D array, or 2D array
!> - **`logical`** values: scalar, 1D array, or 2D array
!> - **`complex(rk)`** values: scalar, 1D array, or 2D array
!>
!> These are automatically dispatched to the correct internal test routine
!> based on rank and type, with optional relative tolerance for `real` and `complex`.
!>
!> ## How to Use
!>
!> ### 1. `initialize(n)`
!> - Allocates a test suite with `n` entries.
!> - Call this once before running any tests.
!>
!> ### 2. `check(res, expected, [tol], [msg], [name], [group])`
!>
!> Compares a computed result `res` to a reference `expected` value.
!>
!> - **`res`**: The actual result to test (scalar, vector, or matrix).
!> - **`expected`**: The correct or expected value to compare against.
!> - **`tol`** *(optional)*: Tolerance (used for `real` and `complex`). If omitted, defaults to a small epsilon-based value.
!> - **`msg`** *(optional)*: A short message describing the test intent. Shown in summaries.
!> - **`name`** *(optional)*: A unique name for the test (used in summary tables).
!> - **`group`** *(optional)*: A group tag (e.g., `"math"`, `"I/O"`, `"real"`). Used for per-group summaries.
!>
!> ### 3. `summary(required_score, [verbose], [stop_fail])`
!>
!> Prints a detailed report and checks if the test score meets your target.
!>
!> - **`required_score`**: Real value between 0–100. Minimum % of passed tests required to "pass".
!> - **`verbose`** *(optional)*:
!>     - `0`: No output
!>     - `1`: Group summary only
!>     - `2`: Per-test summary only
!>     - `3`: Both per-test and group summaries
!> - **`stop_fail`** *(optional)*:
!>     - If `.true.`, program stops with error code 1 if score < required_score
!>
!> @note
!> You can test a variety of data types (real, int, logical, complex) using a single generic `check(...)` interface.
!> @endnote

program demo_forunittest
   use forunittest, only: unit_tests, rk
   implicit none

   type(unit_tests) :: tests

   ! Initialize the test suite with 5 entries
   call tests%initialize(5)

   ! Test 1: Real comparison with tolerance
   call tests%test(1)%check(&
      res      = 3.14159_rk, &
      expected = 3.1416_rk, &
      tol      = 1e-4_rk, &
      name     = "Pi test", &
      msg      = "Compare pi", &
      group    = "real")

   ! Test 2: Integer equality
   call tests%test(2)%check(&
      res      = 2, &
      expected = 2, &
      name     = "Int equal", &
      msg      = "Integer equality", &
      group    = "int")

   ! Test 3: Logical vector check
   call tests%test(3)%check(&
      res      = [.true., .false.], &
      expected = [.true., .false.], &
      name     = "Bool vec", &
      msg      = "Logical vector", &
      group    = "logical")

   ! Test 4: Real zero comparison
   call tests%test(4)%check(&
      res      = 0.0_rk, &
      expected = 0.0_rk, &
      name     = "Zero test", &
      msg      = "Exact match", &
      group    = "real")

   ! Test 5: Intentional failure (should fail)
   call tests%test(5)%check(&
      res      = 42, &
      expected = 0, &
      name     = "Wrong int", &
      msg      = "Intentional fail", &
      group    = "int")

   ! Print a detailed summary and stop if score is too low
   call tests%summary( &
      required_score = 60.0, &
      verbose        = 3, &
      stop_fail      = .true.)

end program demo_forunittest
