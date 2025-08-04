program demo_old

   ! Use 'forunittest' module to access the unit_test type
   use forunittest, only : unit_test, rk

   implicit none

   ! Declare an object of type 'unit_test'
   type(unit_test) :: ut


   ! call ut%check(res, expected, tol, msg)
   ! Variables 'res' and 'expected' can be of types: real(rk), integer(ik), logical, or complex(rk)
   ! Their ranks can be 0, 1, or 2
   ! 'tol' is an optional real(rk) parameter, default value is 'tiny(0.0_rk)'
   ! 'msg' is an optional character parameter, default value is 'forunittest'
   ! Note: 'res' and 'expected' must have the same type and shape
   call ut%check(res=1.0_rk, expected=1.0_rk, tol=1e-5_rk, msg="demo_old test 1")
   call ut%check(res=2.0_rk, expected=1.0_rk, tol=1e-5_rk, msg="demo_old test 2")

end program demo_old
