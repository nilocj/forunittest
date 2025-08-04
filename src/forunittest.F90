module forunittest

   use iso_fortran_env, only: int32

   implicit none

   private

   public unit_tests, unit_test, rk, ik

#ifdef REAL32
   integer, parameter :: rk = selected_real_kind(6)
#elif REAL64
   integer, parameter :: rk = selected_real_kind(15)
#elif REALXDP
   integer, parameter :: rk = selected_real_kind(18)
#elif REAL128
   integer, parameter :: rk = selected_real_kind(33)
#else
   integer, parameter :: rk = selected_real_kind(15)
#endif

   integer, parameter :: ik = int32

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type unit_test
      character(len=64), private :: msg
      character(len=64), private :: name
      character(len=64), private :: group
      logical, private :: result = .false.
      logical, private :: silent = .false.
   contains
      procedure, private :: print_msg

      procedure, private :: unit_test_r0
      procedure, private :: unit_test_r1
      procedure, private :: unit_test_r2

      procedure, private :: unit_test_i0
      procedure, private :: unit_test_i1
      procedure, private :: unit_test_i2

      procedure, private :: unit_test_l0
      procedure, private :: unit_test_l1
      procedure, private :: unit_test_l2

      procedure, private :: unit_test_cx0
      procedure, private :: unit_test_cx1
      procedure, private :: unit_test_cx2

      generic :: check => unit_test_r0, unit_test_r1, unit_test_r2, &
         unit_test_i0, unit_test_i1, unit_test_i2, &
         unit_test_l0, unit_test_l1, unit_test_l2, &
         unit_test_cx0, unit_test_cx1, unit_test_cx2

      procedure, private :: set_silent
   end type unit_test
   !===============================================================================


   !===============================================================================
   type unit_tests
      type(unit_test), allocatable :: test(:)
      integer, private :: n = 0
   contains
      procedure :: initialize
      procedure :: summary
   end type unit_tests
   !===============================================================================

contains

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine initialize(this, n)
      class(unit_tests), intent(inout) :: this
      integer, intent(in) :: n
      this%n = n
      allocate(this%test(this%n))
      call this%test(:)%set_silent()
   end subroutine initialize
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine summary(this, required_score, verbose, stop_fail)
      use face, only: colorize
      use iso_fortran_env, only: compiler_version, compiler_options

      class(unit_tests), intent(inout) :: this
      real,             intent(in)    :: required_score
      integer, optional, intent(in)   :: verbose
      logical, optional, intent(in)   :: stop_fail

      integer :: i, j
      integer :: n_passed, n_failed, n_groups, found_idx, bars
      integer :: name_w, group_w, msg_w, passed_w, total_w, bar_col, status_w, id_w
      logical :: do_test, do_group, do_stop
      real    :: score, rate
      character(len=:), allocatable :: test_name, test_msg, comp_version, comp_options
      character(len=64), allocatable :: groups(:)
      character(len=64) :: grp
      character(len=8)  :: date_str
      character(len=10) :: time_str
      character(len=5)  :: zone_str
      character(len=6)  :: status_color
      character(len=100) :: fmt_string, hdr_line
      character(len=5)   :: success_label
      character(len=9)   :: bar_label
      integer, allocatable :: grp_total(:), grp_pass(:)
      character(len=*), parameter :: full_block = '█', light_block = '░'

      ! Determine verbosity
      do_test  = .false.
      do_group = .true.
      if (present(verbose)) then
         select case (verbose)
          case (0); do_test = .false.; do_group = .false.
          case (1); do_test = .false.; do_group = .true.
          case (2); do_test = .true.;  do_group = .false.
          case (3); do_test = .true.;  do_group = .true.
         end select
      end if

      do_stop = .false.; if (present(stop_fail)) do_stop = stop_fail

      n_passed = count(this%test(:)%result)
      n_failed = this%n - n_passed
      score = merge(100.0 * real(n_passed) / real(max(1, this%n)), 0.0, this%n > 0)

      call date_and_time(date=date_str, time=time_str, zone=zone_str)
      comp_version = compiler_version()
      comp_options = compiler_options()

      ! per-test summary
      if (do_test) then
         print '(A)', colorize("Per-test result summary:", color_fg='cyan')
         id_w    = 3
         name_w  = 4; group_w = 5; msg_w = 7; status_w = 6
         do i = 1, this%n
            name_w  = max(name_w,  len_trim(this%test(i)%name))
            group_w = max(group_w, len_trim(this%test(i)%group))
            msg_w   = max(msg_w,   len_trim(this%test(i)%msg))
         end do

         ! Print header
         print '(A)', 'ID' // repeat(' ', id_w - 2 + 2) // &
            'NAME'  // repeat(' ', name_w - 4 + 2) // &
            'GROUP' // repeat(' ', group_w - 5 + 2) // &
            'MESSAGE' // repeat(' ', msg_w - 7 + 2) // 'STATUS'

         ! Print separator line
         print '(A)', repeat('-', id_w + name_w + group_w + msg_w + status_w + 8)

         ! Print each test line
         do i = 1, this%n
            write(fmt_string, '(A,A,I0,A,I0,A,I0,A,I0,A,I0,A)') '(', 'I', id_w, ',2X,A', name_w, ',2X,A', group_w, ',2X,A', msg_w, ',2X,A)'
            grp = trim(this%test(i)%group); if (grp == '') grp = 'none'
            test_name = adjustl(this%test(i)%name)
            test_msg  = adjustl(this%test(i)%msg)
            status_color = merge('green', 'red  ', this%test(i)%result)
            print fmt_string, i, test_name, adjustl(grp), test_msg, &
               colorize(merge('passed', 'failed', this%test(i)%result), color_fg=status_color)
         end do
      end if

      ! per-group summary
      if (do_group) then
         print '(A)', ''
         print '(A)', colorize("Per-group test results:", color_fg='cyan')

         allocate(groups(this%n), grp_total(this%n), grp_pass(this%n))
         groups = ''; grp_total = 0; grp_pass = 0; n_groups = 0

         do i = 1, this%n
            grp = trim(this%test(i)%group); if (grp == '') grp = 'none'
            found_idx = 0
            do j = 1, n_groups
               if (trim(grp) == trim(groups(j))) then
                  found_idx = j; exit
               end if
            end do
            if (found_idx == 0) then
               n_groups = n_groups + 1
               groups(n_groups) = grp
               grp_total(n_groups) = 1
               if (this%test(i)%result) grp_pass(n_groups) = 1
            else
               grp_total(found_idx) = grp_total(found_idx) + 1
               if (this%test(i)%result) grp_pass(found_idx) = grp_pass(found_idx) + 1
            end if
         end do

         group_w = 5; passed_w = 6; total_w = 5
         do i = 1, n_groups
            group_w  = max(group_w, len_trim(groups(i)))
            passed_w = max(passed_w, len_trim(adjustl(itoa(grp_pass(i)))))
            total_w  = max(total_w,  len_trim(adjustl(itoa(grp_total(i)))))
         end do

         write(fmt_string, '(A,I0,A,I0,A,I0,A)') &
            '(A', group_w, ',2X,I', passed_w, ',2X,I', total_w, ',2X,F6.1," %   ",A)'

         success_label = 'SCORE'
         bar_label     = 'SCORE BAR'

         hdr_line = 'GROUP' // repeat(' ', group_w - 5 + 2) // &
            'PASSED' // repeat(' ', passed_w - 6 + 2) // &
            'TOTAL'  // repeat(' ', total_w - 5 + 3) // &
            success_label

         bar_col = group_w + 2 + passed_w + 2 + total_w + 2 + 11
         hdr_line = trim(hdr_line) // repeat(' ', max(1, bar_col - len_trim(hdr_line))) // bar_label

         print '(A)', hdr_line
         print '(A)', repeat('-', len_trim(hdr_line)+1)

         do i = 1, n_groups
            rate = merge(100.0 * real(grp_pass(i)) / grp_total(i), 0.0, grp_total(i) > 0)
            bars = min(10, int(rate / 10.0))
            print fmt_string, adjustl(groups(i)), grp_pass(i), grp_total(i), rate, &
               repeat(full_block, bars) // repeat(light_block, 10 - bars)
         end do

         deallocate(groups, grp_total, grp_pass)
      end if


      ! Final summary
      print '(A)', ''
      print '(A)', colorize("================== Tests Summary ==================", color_fg='cyan')
      print '(A,A)',      'Date:           ', date_str
      print '(A,A)',      'Time:           ', time_str(1:2)//':'//time_str(3:4)//':'//time_str(5:6)
      print '(A,A)',      'Compiler:       ', trim(comp_version)
      print '(A)', ''
      print '(A,I5)',     'Total tests:    ', this%n
      print '(A,I5)',     'Passed tests:   ', n_passed
      print '(A,I5)',     'Failed tests:   ', n_failed
      print '(A)', ''
      print '(A,F6.1,A)', 'Score:          ', score, ' %'
      print '(A,F6.1,A)', 'Required score: ', required_score,  ' %'

      bars = min(10, int(score / 10.0))
      print '(A,A)', 'Score bar:      ', repeat(full_block, bars) // repeat(light_block, 10 - bars)

      if (score < required_score) then
         print '(A)', colorize("FAILED: Required score not met.", color_fg='red')
         print '(A)', ''
         print '(A)', colorize("ForUnitTest - https://github.com/gha3mi/forunittest", color_fg='cyan')
         print '(A)', colorize("===================================================", color_fg='cyan ')
         if (do_stop) stop 1
      else
         print '(A)', colorize("PASSED: Required score met.", color_fg='green')
         print '(A)', colorize("ForUnitTest - https://github.com/gha3mi/forunittest", color_fg='cyan')
         print '(A)', colorize("===================================================", color_fg='cyan ')
      end if

   contains
      pure function itoa(ii) result(str)
         integer, intent(in) :: ii
         character(len=32) :: str
         write(str, '(I0)') ii
         str = adjustl(str)
      end function itoa

   end subroutine summary
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine print_msg(this, result)
      use face, only: colorize
      class(unit_test), intent(inout) :: this
      logical, intent(in) :: result
      integer  :: lm
      character(len=20) :: fmt

      if (this%silent) return

      lm = 39-len_trim(this%msg)
      write(fmt,'(a,g0,a)') '(a,',lm,'x,a)'

      if (result) then
         print(fmt), trim(this%msg), colorize('passed.', color_fg='green')
      else
         print(fmt), trim(this%msg), colorize('failed.', color_fg='red')
      end if
   end subroutine print_msg
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   elemental subroutine set_silent(this)
      class(unit_test), intent(inout) :: this
      this%silent = .true.
   end subroutine set_silent
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_r0(this, res, expected, tol, msg, name, group)
      class(unit_test), intent(inout) :: this
      real(rk), intent(in) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group
      real(rk) :: rel_err

      if (present(name)) then
         this%name = name
      else
         this%name = ''
      end if

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      if (abs(expected)<=tiny(0.0_rk)) then
         rel_err = abs(res-expected)
      else
         rel_err = abs(res-expected)/abs(expected)
      end if

      if (present(tol)) then
         this%result = rel_err <= tol
      else
         ! this%result = rel_err == 0.0_rk
         this%result = abs(rel_err) <= 2.0_rk*epsilon(0.0_rk)
      end if

      call this%print_msg(this%result)
   end subroutine unit_test_r0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_r1(this, res, expected, tol, msg, name, group)
      class(unit_test), intent(inout) :: this
      real(rk), intent(in), dimension(:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group
      real(rk) :: rel_err

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      if (norm2(expected)<=tiny(0.0_rk)) then
         rel_err = norm2(res-expected)
      else
         rel_err = norm2(res-expected)/norm2(expected)
      end if

      if (present(tol)) then
         this%result = rel_err <= tol
      else
         ! this%result = rel_err == 0.0_rk
         this%result = abs(rel_err) <= 2.0_rk*epsilon(0.0_rk)
      end if

      call this%print_msg(this%result)
   end subroutine unit_test_r1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_r2(this, res, expected, tol, msg, name, group)
      class(unit_test), intent(inout) :: this
      real(rk), intent(in), dimension(:,:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group
      real(rk) :: rel_err

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      if (norm2(expected)<=tiny(0.0_rk)) then
         rel_err = norm2(res-expected)
      else
         rel_err = norm2(res-expected)/norm2(expected)
      end if

      if (present(tol)) then
         this%result = rel_err <= tol
      else
         ! this%result = rel_err == 0.0_rk
         this%result = abs(rel_err) <= 2.0_rk*epsilon(0.0_rk)
      end if

      call this%print_msg(this%result)
   end subroutine unit_test_r2
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_i0(this, res, expected, msg, name, group)
      class(unit_test), intent(inout) :: this
      integer, intent(in) :: res, expected
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      this%result = res == expected

      call this%print_msg(this%result)
   end subroutine unit_test_i0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_i1(this, res, expected, msg, name, group)
      class(unit_test), intent(inout) :: this
      integer, intent(in), dimension(:) :: res, expected
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      this%result = all(res == expected)

      call this%print_msg(this%result)
   end subroutine unit_test_i1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_i2(this, res, expected, msg, name, group)
      class(unit_test), intent(inout) :: this
      integer, intent(in), dimension(:,:) :: res, expected
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      this%result = all(res == expected)

      call this%print_msg(this%result)
   end subroutine unit_test_i2
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_l0(this, res, expected, msg, name, group)
      class(unit_test), intent(inout) :: this
      logical, intent(in) :: res, expected
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      this%result = res .eqv. expected

      call this%print_msg(this%result)
   end subroutine unit_test_l0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_l1(this, res, expected, msg, name, group)
      class(unit_test), intent(inout) :: this
      logical, intent(in), dimension(:) :: res, expected
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      this%result = all(res .eqv. expected)

      call this%print_msg(this%result)
   end subroutine unit_test_l1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_l2(this, res, expected, msg, name, group)
      class(unit_test), intent(inout) :: this
      logical, intent(in), dimension(:,:) :: res, expected
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      this%result = all(res .eqv. expected)

      call this%print_msg(this%result)
   end subroutine unit_test_l2
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_cx0(this, res, expected, tol, msg, name, group)
      class(unit_test), intent(inout) :: this
      complex(rk), intent(in) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group
      real(rk) :: rel_err

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      if (abs(expected)<=tiny(0.0_rk)) then
         rel_err = abs(res-expected)
      else
         rel_err = abs(res-expected)/abs(expected)
      end if

      if (present(tol)) then
         this%result = rel_err <= tol
      else
         ! this%result = rel_err == 0.0_rk
         this%result =abs(rel_err) <= 2.0_rk*epsilon(0.0_rk)
      end if

      call this%print_msg(this%result)
   end subroutine unit_test_cx0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_cx1(this, res, expected, tol, msg, name, group)
      class(unit_test), intent(inout) :: this
      complex(rk), intent(in), dimension(:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group
      real(rk) :: rel_err_re, rel_err_im

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if

      if (norm2(real(expected,rk))<=tiny(0.0_rk)) then
         rel_err_re = norm2(real(res,rk)-real(expected,rk))
      else
         rel_err_re = norm2(real(res,rk)-real(expected,rk))/norm2(real(expected,rk))
      end if

      if (norm2(aimag(expected))<=tiny(0.0_rk)) then
         rel_err_im = norm2(aimag(res)-aimag(expected))
      else
         rel_err_im = norm2(aimag(res)-aimag(expected))/norm2(aimag(expected))
      end if

      if (present(tol)) then
         this%result = (rel_err_re <= tol) .and. (rel_err_im <= tol)
      else
         this%result = (rel_err_re <= tiny(0.0_rk)) .and. (rel_err_im <= tiny(0.0_rk))
      end if

      call this%print_msg(this%result)
   end subroutine unit_test_cx1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_cx2(this, res, expected, tol, msg, name, group)
      class(unit_test), intent(inout) :: this
      complex(rk), intent(in), dimension(:,:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      character(len=*), optional, intent(in) :: name
      character(len=*), optional, intent(in) :: group
      real(rk) :: rel_err_re, rel_err_im

      if (present(name)) then
         this%name = name
      else
         this%name = 'none'
      end if

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'none'
      end if

      if (present(group)) then
         this%group = group
      else
         this%group = 'none'
      end if
      if (norm2(real(expected,rk))<=tiny(0.0_rk)) then
         rel_err_re = norm2(real(res,rk)-real(expected,rk))
      else
         rel_err_re = norm2(real(res,rk)-real(expected,rk))/norm2(real(expected,rk))
      end if

      if (norm2(aimag(expected))<=tiny(0.0_rk)) then
         rel_err_im = norm2(aimag(res)-aimag(expected))
      else
         rel_err_im = norm2(aimag(res)-aimag(expected))/norm2(aimag(expected))
      end if

      if (present(tol)) then
         this%result = (rel_err_re <= tol) .and. (rel_err_im <= tol)
      else
         this%result = (rel_err_re <= tiny(0.0_rk)) .and. (rel_err_im <= tiny(0.0_rk))
      end if

      call this%print_msg(this%result)
   end subroutine unit_test_cx2
   !===============================================================================

end module forunittest
