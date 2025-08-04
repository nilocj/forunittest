program test2

   use forunittest, only : unit_tests, rk, ik

   implicit none

   type(unit_tests) :: tests

   call tests%initialize(50)

   !> Real Scalar Tests
   call tests%test(1)%check(&
      name     = "real_scalar_pass_1",&
      res      = 1.0_rk,&
      expected = 1.0_rk,&
      tol      = 1e-5_rk,&
      msg      = "Real scalar match",&
      group    = "real_scalar")

   call tests%test(2)%check(&
      name     = "real_scalar_fail_1",&
      res      = 2.0_rk,&
      expected = 1.0_rk,&
      tol      = 1e-5_rk,&
      msg      = "Real scalar mismatch",&
      group    = "real_scalar")

   call tests%test(3)%check(&
      name     = "real_scalar_pass_2",&
      res      = 1.0_rk,&
      expected = 1.0_rk,&
      msg      = "Real scalar match (no tol)",&
      group    = "real_scalar")

   call tests%test(4)%check(&
      name     = "real_scalar_fail_2",&
      res      = 2.0_rk,&
      expected = 1.0_rk,&
      msg      = "Real scalar mismatch (no tol)",&
      group    = "real_scalar")

   !> Real Vector Tests
   call tests%test(5)%check(&
      name     = "real_vector_pass_1",&
      res      = [1.0_rk,2.0_rk],&
      expected = [1.0_rk,2.0_rk],&
      tol      = 1e-5_rk,&
      msg      = "Real vector match",&
      group    = "real_vector")

   call tests%test(6)%check(&
      name     = "real_vector_fail_1",&
      res      = [1.0_rk,1.0_rk],&
      expected = [1.0_rk,2.0_rk],&
      tol      = 1e-5_rk,&
      msg      = "Real vector value error",&
      group    = "real_vector")

   call tests%test(7)%check(&
      name     = "real_vector_fail_2",&
      res      = [2.0_rk,1.0_rk],&
      expected = [1.0_rk,2.0_rk],&
      tol      = 1e-5_rk,&
      msg      = "Real vector order error",&
      group    = "real_vector")

   call tests%test(8)%check(&
      name     = "real_vector_pass_2",&
      res      = [1.0_rk,2.0_rk],&
      expected = [1.0_rk,2.0_rk],&
      msg      = "Real vector match (no tol)",&
      group    = "real_vector")

   call tests%test(9)%check(&
      name     = "real_vector_fail_3",&
      res      = [1.0_rk,1.0_rk],&
      expected = [1.0_rk,2.0_rk],&
      msg      = "Real vector value error (no tol)",&
      group    = "real_vector")

   call tests%test(10)%check(&
      name     = "real_vector_fail_4",&
      res      = [2.0_rk,1.0_rk],&
      expected = [1.0_rk,2.0_rk],&
      msg      = "Real vector order error (no tol)",&
      group    = "real_vector")

   !> Real Matrix Tests
   call tests%test(11)%check(&
      name     = "real_matrix_pass_1",&
      res      = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      expected = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      tol      = 1e-5_rk,&
      msg      = "Real matrix match",&
      group    = "real_matrix")

   call tests%test(12)%check(&
      name     = "real_matrix_fail_1",&
      res      = reshape([1.0_rk,2.0_rk,3.0_rk,5.0_rk],[2,2]),&
      expected = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      tol      = 1e-5_rk,&
      msg      = "Real matrix value error",&
      group    = "real_matrix")

   call tests%test(13)%check(&
      name     = "real_matrix_fail_2",&
      res      = reshape([1.0_rk,2.0_rk,4.0_rk,3.0_rk],[2,2]),&
      expected = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      tol      = 1e-5_rk,&
      msg      = "Real matrix order error",&
      group    = "real_matrix")

   call tests%test(14)%check(&
      name     = "real_matrix_pass_2",&
      res      = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      expected = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      msg      = "Real matrix match (no tol)",&
      group    = "real_matrix")

   call tests%test(15)%check(&
      name     = "real_matrix_fail_3",&
      res      = reshape([1.0_rk,2.0_rk,3.0_rk,5.0_rk],[2,2]),&
      expected = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      msg      = "Real matrix value error (no tol)",&
      group    = "real_matrix")

   call tests%test(16)%check(&
      name     = "real_matrix_fail_4",&
      res      = reshape([1.0_rk,2.0_rk,4.0_rk,3.0_rk],[2,2]),&
      expected = reshape([1.0_rk,2.0_rk,3.0_rk,4.0_rk],[2,2]),&
      msg      = "Real matrix order error (no tol)",&
      group    = "real_matrix")

   !> Integer Scalar Tests
   call tests%test(17)%check(&
      name     = "int_scalar_pass_1",&
      res      = 1_ik,&
      expected = 1_ik,&
      msg      = "Integer scalar match",&
      group    = "int_scalar")

   call tests%test(18)%check(&
      name     = "int_scalar_fail_1",&
      res      = 2_ik,&
      expected = 1_ik,&
      msg      = "Integer scalar mismatch",&
      group    = "int_scalar")

   !> Integer Vector Tests
   call tests%test(19)%check(&
      name     = "int_vector_pass_1",&
      res      = [1,2],&
      expected = [1,2],&
      msg      = "Integer vector match",&
      group    = "int_vector")

   call tests%test(20)%check(&
      name     = "int_vector_fail_1",&
      res      = [1,3],&
      expected = [1,2],&
      msg      = "Integer vector value error",&
      group    = "int_vector")

   call tests%test(21)%check(&
      name     = "int_vector_fail_2",&
      res      = [2,1],&
      expected = [1,2],&
      msg      = "Integer vector order error",&
      group    = "int_vector")

   !> Integer Matrix Tests
   call tests%test(22)%check(&
      name     = "int_matrix_pass_1",&
      res      = reshape([1,2,3,4],[2,2]),&
      expected = reshape([1,2,3,4],[2,2]),&
      msg      = "Integer matrix match",&
      group    = "int_matrix")

   call tests%test(23)%check(&
      name     = "int_matrix_fail_1",&
      res      = reshape([1,2,3,5],[2,2]),&
      expected = reshape([1,2,3,4],[2,2]),&
      msg      = "Integer matrix value error",&
      group    = "int_matrix")

   call tests%test(24)%check(&
      name     = "int_matrix_fail_2",&
      res      = reshape([1,2,4,3],[2,2]),&
      expected = reshape([1,2,3,4],[2,2]),&
      msg      = "Integer matrix order error",&
      group    = "int_matrix")

   !> Logical Scalar Tests
   call tests%test(25)%check(&
      name     = "logical_scalar_pass_1",&
      res      = .true.,&
      expected = .true.,&
      msg      = "Logical scalar match",&
      group    = "logical_scalar")

   call tests%test(26)%check(&
      name     = "logical_scalar_fail_1",&
      res      = .false.,&
      expected = .true.,&
      msg      = "Logical scalar mismatch",&
      group    = "logical_scalar")

   !> Logical Vector Tests
   call tests%test(27)%check(&
      name     = "logical_vector_pass_1",&
      res      = [.true.,.false.],&
      expected = [.true.,.false.],&
      msg      = "Logical vector match",&
      group    = "logical_vector")

   call tests%test(28)%check(&
      name     = "logical_vector_fail_1",&
      res      = [.true.,.true.],&
      expected = [.true.,.false.],&
      msg      = "Logical vector value error",&
      group    = "logical_vector")

   call tests%test(29)%check(&
      name     = "logical_vector_fail_2",&
      res      = [.false.,.true.],&
      expected = [.true.,.false.],&
      msg      = "Logical vector order error",&
      group    = "logical_vector")

   !> Logical Matrix Tests
   call tests%test(30)%check(&
      name     = "logical_matrix_pass_1",&
      res      = reshape([.true.,.true.,.false.,.false.],[2,2]),&
      expected = reshape([.true.,.true.,.false.,.false.],[2,2]),&
      msg      = "Logical matrix match",&
      group    = "logical_matrix")

   call tests%test(31)%check(&
      name     = "logical_matrix_fail_1",&
      res      = reshape([.true.,.true.,.false.,.false.],[2,2]),&
      expected = reshape([.true.,.false.,.false.,.false.],[2,2]),&
      msg      = "Logical matrix value error",&
      group    = "logical_matrix")

   call tests%test(32)%check(&
      name     = "logical_matrix_fail_2",&
      res      = reshape([.true.,.true.,.false.,.false.],[2,2]),&
      expected = reshape([.true.,.false.,.true.,.false.],[2,2]),&
      msg      = "Logical matrix order error",&
      group    = "logical_matrix")

   !> Complex Scalar Tests
   call tests%test(33)%check(&
      name     = "complex_scalar_pass_1",&
      res      = (1.0_rk,1.0_rk),&
      expected = (1.0_rk,1.0_rk),&
      tol      = 1e-5_rk,&
      msg      = "Complex scalar match",&
      group    = "complex_scalar")

   call tests%test(34)%check(&
      name     = "complex_scalar_fail_1",&
      res      = (2.0_rk,1.0_rk),&
      expected = (1.0_rk,1.0_rk),&
      tol      = 1e-5_rk,&
      msg      = "Complex scalar real part error",&
      group    = "complex_scalar")

   call tests%test(35)%check(&
      name     = "complex_scalar_fail_2",&
      res      = (1.0_rk,2.0_rk),&
      expected = (1.0_rk,1.0_rk),&
      tol      = 1e-5_rk,&
      msg      = "Complex scalar imag part error",&
      group    = "complex_scalar")

   call tests%test(36)%check(&
      name     = "complex_scalar_pass_2",&
      res      = (1.0_rk,1.0_rk),&
      expected = (1.0_rk,1.0_rk),&
      msg      = "Complex scalar match (no tol)",&
      group    = "complex_scalar")

   call tests%test(37)%check(&
      name     = "complex_scalar_fail_3",&
      res      = (2.0_rk,1.0_rk),&
      expected = (1.0_rk,1.0_rk),&
      msg      = "Complex scalar real part error (no tol)",&
      group    = "complex_scalar")

   call tests%test(38)%check(&
      name     = "complex_scalar_fail_4",&
      res      = (1.0_rk,2.0_rk),&
      expected = (1.0_rk,1.0_rk),&
      msg      = "Complex scalar imag part error (no tol)",&
      group    = "complex_scalar")

   !> Complex Vector Tests
   call tests%test(39)%check(&
      name     = "complex_vector_pass_1",&
      res      = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      expected = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      tol      = 1e-5_rk,&
      msg      = "Complex vector match",&
      group    = "complex_vector")

   call tests%test(40)%check(&
      name     = "complex_vector_fail_1",&
      res      = [cmplx(2,1,rk),cmplx(2,2,rk)],&
      expected = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      tol      = 1e-5_rk,&
      msg      = "Complex vector real error",&
      group    = "complex_vector")

   call tests%test(41)%check(&
      name     = "complex_vector_fail_2",&
      res      = [cmplx(2,2,rk),cmplx(1,1,rk)],&
      expected = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      tol      = 1e-5_rk,&
      msg      = "Complex vector order error",&
      group    = "complex_vector")

   call tests%test(42)%check(&
      name     = "complex_vector_pass_2",&
      res      = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      expected = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      msg      = "Complex vector match (no tol)",&
      group    = "complex_vector")

   call tests%test(43)%check(&
      name     = "complex_vector_fail_3",&
      res      = [cmplx(2,1,rk),cmplx(2,2,rk)],&
      expected = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      msg      = "Complex vector real error (no tol)",&
      group    = "complex_vector")

   call tests%test(44)%check(&
      name     = "complex_vector_fail_4",&
      res      = [cmplx(2,2,rk),cmplx(1,1,rk)],&
      expected = [cmplx(1,1,rk),cmplx(2,2,rk)],&
      msg      = "Complex vector order error (no tol)",&
      group    = "complex_vector")

   !> Complex Matrix Tests
   call tests%test(45)%check(&
      name     = "complex_matrix_pass_1",&
      res      = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]), &
      expected = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]),&
      tol      = 1e-5_rk, &
      msg      = "Complex matrix match",&
      group    = "complex_matrix")

   call tests%test(46)%check(&
      name     = "complex_matrix_fail_1",&
      res      = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,5,rk),cmplx(4,4,rk)],[2,2]), &
      expected = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]),&
      tol      = 1e-5_rk, &
      msg      = "Complex matrix imag value error",&
      group    = "complex_matrix")

   call tests%test(47)%check(&
      name     = "complex_matrix_fail_2",&
      res      = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(4,3,rk),cmplx(4,4,rk)],[2,2]), &
      expected = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]),&
      tol      = 1e-5_rk, &
      msg      = "Complex matrix real value error",&
      group    = "complex_matrix")

   call tests%test(48)%check(&
      name     = "complex_matrix_pass_2",&
      res      = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]), &
      expected = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]), &
      msg      = "Complex matrix match (no tol)",&
      group    = "complex_matrix")

   call tests%test(49)%check(&
      name     = "complex_matrix_fail_3",&
      res      = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,5,rk),cmplx(4,4,rk)],[2,2]), &
      expected = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]), &
      msg      = "Complex matrix imag value error (no tol)",&
      group    = "complex_matrix")

   call tests%test(50)%check(&
      name     = "complex_matrix_fail_4",&
      res      = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(4,3,rk),cmplx(4,4,rk)],[2,2]), &
      expected = reshape([cmplx(1,1,rk),cmplx(2,2,rk),cmplx(3,3,rk),cmplx(4,4,rk)],[2,2]), &
      msg      = "Complex matrix real value error (no tol)",&
      group    = "complex_matrix")

   !> Summary
   call tests%summary(required_score=36.0, verbose=3, stop_fail=.true.)

end program test2
