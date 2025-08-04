program test1

   use forunittest, only : unit_test, rk, ik

   implicit none

   type(unit_test) :: ut

   !! real(rk) rank 0
   call ut%check(res=1.0_rk, expected=1.0_rk, tol=1e-5_rk, msg="test 1 passed") ! tol is optional
   call ut%check(res=2.0_rk, expected=1.0_rk, tol=1e-5_rk, msg="test 1 failed") ! tol is optional

   !! real(rk) rank 0, without tol
   call ut%check(res=1.0_rk, expected=1.0_rk, msg="test 2 passed")
   call ut%check(res=2.0_rk, expected=1.0_rk, msg="test 2 failed")

   !! real(rk) rank 1
   call ut%check(res=[1.0_rk,2.0_rk], expected=[1.0_rk,2.0_rk], tol=1e-5_rk, msg="test 3 passed") ! tol is optional
   call ut%check(res=[1.0_rk,1.0_rk], expected=[1.0_rk,2.0_rk], tol=1e-5_rk, msg="test 3 failed") ! tol is optional
   call ut%check(res=[2.0_rk,1.0_rk], expected=[1.0_rk,2.0_rk], tol=1e-5_rk, msg="test 3 failed") ! tol is optional

   !! real(rk) rank 1, without tol
   call ut%check(res=[1.0_rk,2.0_rk], expected=[1.0_rk,2.0_rk], msg="test 4 passed")
   call ut%check(res=[1.0_rk,1.0_rk], expected=[1.0_rk,2.0_rk], msg="test 4 failed")
   call ut%check(res=[2.0_rk,1.0_rk], expected=[1.0_rk,2.0_rk], msg="test 4 failed")

   !! real(rk) rank 2
   call ut%check(res=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      expected=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      tol=1e-5_rk, msg="test 5 passed") ! tol is optional
   call ut%check(res=reshape([1.0_rk,2.0_rk,3.0_rk,5.0_rk], [2,2]),&
      expected=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      tol=1e-5_rk, msg="test 5 failed") ! tol is optional
   call ut%check(res=reshape([1.0_rk,2.0_rk,4.0_rk,3.0_rk], [2,2]),&
      expected=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      tol=1e-5_rk, msg="test 5 failed") ! tol is optional

   !! real(rk) rank 2, without tol
   call ut%check(res=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      expected=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      msg="test 6 passed") ! tol is optional
   call ut%check(res=reshape([1.0_rk,2.0_rk,3.0_rk,5.0_rk], [2,2]),&
      expected=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      msg="test 6 failed") ! tol is optional
   call ut%check(res=reshape([1.0_rk,2.0_rk,4.0_rk,3.0_rk], [2,2]),&
      expected=reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk], [2,2]),&
      msg="test 6 failed") ! tol is optional

   !! integer(ik) rank 0
   call ut%check(res=1_ik, expected=1_ik, msg="test 7 passed")
   call ut%check(res=2_ik, expected=1_ik, msg="test 7 failed")

   !! integer(ik) rank 1
   call ut%check(res=[1,2], expected=[1,2], msg="test 8 passed")
   call ut%check(res=[1,3], expected=[1,2], msg="test 8 failed")
   call ut%check(res=[2,1], expected=[1,2], msg="test 8 failed")

   !! integer(ik) rank 2
   call ut%check(res=reshape([1_ik,2_ik,3_ik,4_ik], [2,2]),&
      expected=reshape([1_ik,2_ik,3_ik,4_ik], [2,2]),&
      msg="test 9 passed")
   call ut%check(res=reshape([1_ik,2_ik,3_ik,5_ik], [2,2]),&
      expected=reshape([1_ik,2_ik,3_ik,4_ik], [2,2]),&
      msg="test 9 failed")
   call ut%check(res=reshape([1_ik,2_ik,4_ik,3_ik], [2,2]),&
      expected=reshape([1_ik,2_ik,3_ik,4_ik], [2,2]),&
      msg="test 9 failed")

   !! logical rank 0
   call ut%check(res=.true., expected=.true., msg="test 10 passed")
   call ut%check(res=.false., expected=.true., msg="test 10 failed")

   !! logical rank 1
   call ut%check(res=[.true.,.false.], expected=[.true.,.false.], msg="test 11 passed")
   call ut%check(res=[.true.,.true.], expected=[.true.,.false.], msg="test 11 failed")
   call ut%check(res=[.false.,.true.], expected=[.true.,.false.], msg="test 11 failed")

   !! logical rank 2
   call ut%check(res=reshape([.true.,.true.,.false.,.false.], [2,2]),&
      expected=reshape([.true.,.true.,.false.,.false.], [2,2]),&
      msg="test 12 passed")
   call ut%check(res=reshape([.true.,.true.,.false.,.false.], [2,2]),&
      expected=reshape([.true.,.false.,.false.,.false.], [2,2]),&
      msg="test 12 failed")
   call ut%check(res=reshape([.true.,.true.,.false.,.false.], [2,2]),&
      expected=reshape([.true.,.false.,.true.,.false.], [2,2]),&
      msg="test 12 failed")

   !! complex(rk) rank 0
   call ut%check(res=(1.0_rk,1.0_rk), expected=(1.0_rk,1.0_rk), tol=1e-5_rk, msg="test 13 passed") ! tol is optional
   call ut%check(res=(2.0_rk,1.0_rk), expected=(1.0_rk,1.0_rk), tol=1e-5_rk, msg="test 13 failed") ! tol is optional
   call ut%check(res=(1.0_rk,2.0_rk), expected=(1.0_rk,1.0_rk), tol=1e-5_rk, msg="test 13 failed") ! tol is optional

   !! complex(rk) rank 0, without tol
   call ut%check(res=(1.0_rk,1.0_rk), expected=(1.0_rk,1.0_rk), msg="test 14 passed")
   call ut%check(res=(2.0_rk,1.0_rk), expected=(1.0_rk,1.0_rk), msg="test 14 failed")
   call ut%check(res=(1.0_rk,2.0_rk), expected=(1.0_rk,1.0_rk), msg="test 14 failed")

   !! complex(rk) rank 1
   call ut%check(res=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)],&
      expected=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)], tol=1e-5_rk,&
      msg="test 15 passed") ! tol is optional
   call ut%check(res=[(2.0_rk,1.0_rk),(2.0_rk,2.0_rk)],&
      expected=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)], tol=1e-5_rk,&
      msg="test 15 failed") ! tol is optional
   call ut%check(res=[(2.0_rk,2.0_rk),(1.0_rk,1.0_rk)],&
      expected=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)], tol=1e-5_rk,&
      msg="test 15 failed") ! tol is optional

   !! complex(rk) rank 1, without tol
   call ut%check(res=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)], expected=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)], msg="test 16 passed")
   call ut%check(res=[(2.0_rk,1.0_rk),(2.0_rk,2.0_rk)], expected=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)], msg="test 16 failed")
   call ut%check(res=[(2.0_rk,2.0_rk),(1.0_rk,1.0_rk)], expected=[(1.0_rk,1.0_rk),(2.0_rk,2.0_rk)], msg="test 16 failed")

   !! complex(rk) rank 2
   call ut%check(res=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      expected=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      tol=1e-5_rk, msg="test 17 passed")

   call ut%check(res=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 5.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      expected=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      tol=1e-5_rk, msg="test 17 failed")

   call ut%check(res=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (4.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      expected=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      tol=1e-5_rk, msg="test 17 failed")


   !! complex(rk) rank 2, without tol
   call ut%check(res=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      expected=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      msg="test 18 passed")

   call ut%check(res=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 5.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      expected=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      msg="test 18 failed")

   call ut%check(res=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (4.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      expected=reshape([(1.0_rk, 1.0_rk), (2.0_rk, 2.0_rk), (3.0_rk, 3.0_rk), (4.0_rk, 4.0_rk)], [2,2]),&
      msg="test 18 failed")

end program test1
