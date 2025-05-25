module forunittest

   use iso_fortran_env, only: real64, int32

   implicit none

   private

   public unit_test, rk, ik

   integer, parameter :: rk = real64
   integer, parameter :: ik = int32

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   type unit_test
      character(len=38) :: msg
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
   end type unit_test
   !===============================================================================

contains

   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine print_msg(this, condition)
      use face
      class(unit_test), intent(inout) :: this
      logical, intent(in) :: condition
      integer  :: lm
      character(len=20) :: fmt

      lm = 39-len_trim(this%msg)
      write(fmt,'(a,g0,a)') '(a,',lm,'x,a)'

      if (condition) then
         print(fmt), trim(this%msg), colorize('passed.', color_fg='green')
      else
         print(fmt), trim(this%msg), colorize('failed.', color_fg='red')
      end if
   end subroutine print_msg
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_r0(this, res, expected, tol, msg)
      class(unit_test), intent(inout) :: this
      real(rk), intent(in) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      logical :: condition
      real(rk) :: rel_err

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      if (abs(expected)<tiny(0.0_rk)) then
         rel_err = abs(res-expected)
      else
         rel_err = abs(res-expected)/abs(expected)
      end if

      if (present(tol)) then
         condition = rel_err < tol
      else
         condition = rel_err == 0.0_rk
      end if

      call this%print_msg(condition)
   end subroutine unit_test_r0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_r1(this, res, expected, tol, msg)
      class(unit_test), intent(inout) :: this
      real(rk), intent(in), dimension(:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      logical :: condition
      real(rk) :: rel_err

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      if (norm2(expected)<tiny(0.0_rk)) then
         rel_err = norm2(res-expected)
      else
         rel_err = norm2(res-expected)/norm2(expected)
      end if

      if (present(tol)) then
         condition = rel_err < tol
      else
         condition = rel_err == 0.0_rk
      end if

      call this%print_msg(condition)
   end subroutine unit_test_r1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_r2(this, res, expected, tol, msg)
      class(unit_test), intent(inout) :: this
      real(rk), intent(in), dimension(:,:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      logical :: condition
      real(rk) :: rel_err

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      if (norm2(expected)<tiny(0.0_rk)) then
         rel_err = norm2(res-expected)
      else
         rel_err = norm2(res-expected)/norm2(expected)
      end if

      if (present(tol)) then
         condition = rel_err < tol
      else
         condition = rel_err == 0.0_rk
      end if

      call this%print_msg(condition)
   end subroutine unit_test_r2
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_i0(this, res, expected, msg)
      class(unit_test), intent(inout) :: this
      integer, intent(in) :: res, expected
      character(*), intent(in), optional :: msg
      logical :: condition

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      condition = res == expected

      call this%print_msg(condition)
   end subroutine unit_test_i0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_i1(this, res, expected, msg)
      class(unit_test), intent(inout) :: this
      integer, intent(in), dimension(:) :: res, expected
      character(*), intent(in), optional :: msg
      logical :: condition

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      condition = all(res == expected)

      call this%print_msg(condition)
   end subroutine unit_test_i1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_i2(this, res, expected, msg)
      class(unit_test), intent(inout) :: this
      integer, intent(in), dimension(:,:) :: res, expected
      character(*), intent(in), optional :: msg
      logical :: condition

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      condition = all(res == expected)

      call this%print_msg(condition)
   end subroutine unit_test_i2
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_l0(this, res, expected, msg)
      class(unit_test), intent(inout) :: this
      logical, intent(in) :: res, expected
      character(*), intent(in), optional :: msg
      logical :: condition

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      condition = res .eqv. expected

      call this%print_msg(condition)
   end subroutine unit_test_l0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_l1(this, res, expected, msg)
      class(unit_test), intent(inout) :: this
      logical, intent(in), dimension(:) :: res, expected
      character(*), intent(in), optional :: msg
      logical :: condition

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      condition = all(res .eqv. expected)

      call this%print_msg(condition)
   end subroutine unit_test_l1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_l2(this, res, expected, msg)
      class(unit_test), intent(inout) :: this
      logical, intent(in), dimension(:,:) :: res, expected
      character(*), intent(in), optional :: msg
      logical :: condition

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      condition = all(res .eqv. expected)

      call this%print_msg(condition)
   end subroutine unit_test_l2
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_cx0(this, res, expected, tol, msg)
      class(unit_test), intent(inout) :: this
      complex(rk), intent(in) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      logical :: condition
      real(rk) :: rel_err

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      if (abs(expected)<tiny(0.0_rk)) then
         rel_err = abs(res-expected)
      else
         rel_err = abs(res-expected)/abs(expected)
      end if

      if (present(tol)) then
         condition = rel_err < tol
      else
         condition = rel_err == 0.0_rk
      end if

      call this%print_msg(condition)
   end subroutine unit_test_cx0
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_cx1(this, res, expected, tol, msg)
      class(unit_test), intent(inout) :: this
      complex(rk), intent(in), dimension(:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      logical :: condition
      real(rk) :: rel_err_re, rel_err_im

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      if (norm2(real(expected,rk))<tiny(0.0_rk)) then
         rel_err_re = norm2(real(res,rk)-real(expected,rk))
      else
         rel_err_re = norm2(real(res,rk)-real(expected,rk))/norm2(real(expected,rk))
      end if

      if (norm2(aimag(expected))<tiny(0.0_rk)) then
         rel_err_im = norm2(aimag(res)-aimag(expected))
      else
         rel_err_im = norm2(aimag(res)-aimag(expected))/norm2(aimag(expected))
      end if

      if (present(tol)) then
         condition = (rel_err_re < tol) .and. (rel_err_im < tol)
      else
         condition = (rel_err_re <= tiny(0.0_rk)) .and. (rel_err_im <= tiny(0.0_rk))
      end if

      call this%print_msg(condition)
   end subroutine unit_test_cx1
   !===============================================================================


   !===============================================================================
   !> author: Seyed Ali Ghasemi
   subroutine unit_test_cx2(this, res, expected, tol, msg)
      class(unit_test), intent(inout) :: this
      complex(rk), intent(in), dimension(:,:) :: res, expected
      real(rk), intent(in), optional :: tol
      character(*), intent(in), optional :: msg
      logical :: condition
      real(rk) :: rel_err_re, rel_err_im

      if (present(msg)) then
         this%msg = msg
      else
         this%msg = 'forunittest'
      end if

      if (norm2(real(expected,rk))<tiny(0.0_rk)) then
         rel_err_re = norm2(real(res,rk)-real(expected,rk))
      else
         rel_err_re = norm2(real(res,rk)-real(expected,rk))/norm2(real(expected,rk))
      end if

      if (norm2(aimag(expected))<tiny(0.0_rk)) then
         rel_err_im = norm2(aimag(res)-aimag(expected))
      else
         rel_err_im = norm2(aimag(res)-aimag(expected))/norm2(aimag(expected))
      end if

      if (present(tol)) then
         condition = (rel_err_re < tol) .and. (rel_err_im < tol)
      else
         condition = (rel_err_re <= tiny(0.0_rk)) .and. (rel_err_im <= tiny(0.0_rk))
      end if

      call this%print_msg(condition)
   end subroutine unit_test_cx2
   !===============================================================================

end module forunittest
