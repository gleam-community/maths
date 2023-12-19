import gleam_community/maths/elementary
import gleam_community/maths/special
import gleam_community/maths/predicates
import gleeunit/should
import gleam/result

pub fn float_beta_function_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Valid input returns a result
  special.beta(-0.5, 0.5)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  special.beta(0.5, 0.5)
  |> predicates.is_close(3.1415926535897927, 0.0, tol)
  |> should.be_true()

  special.beta(0.5, -0.5)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  special.beta(5.0, 5.0)
  |> predicates.is_close(0.0015873015873015873, 0.0, tol)
  |> should.be_true()
}

pub fn float_error_function_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Valid input returns a result
  special.erf(-0.5)
  |> predicates.is_close(-0.5204998778130465, 0.0, tol)
  |> should.be_true()

  special.erf(0.5)
  |> predicates.is_close(0.5204998778130465, 0.0, tol)
  |> should.be_true()

  special.erf(1.0)
  |> predicates.is_close(0.8427007929497148, 0.0, tol)
  |> should.be_true()

  special.erf(2.0)
  |> predicates.is_close(0.9953222650189527, 0.0, tol)
  |> should.be_true()

  special.erf(10.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_gamma_function_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Valid input returns a result
  special.gamma(-0.5)
  |> predicates.is_close(-3.5449077018110318, 0.0, tol)
  |> should.be_true()

  special.gamma(0.5)
  |> predicates.is_close(1.7724538509055159, 0.0, tol)
  |> should.be_true()

  special.gamma(1.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  special.gamma(2.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  special.gamma(3.0)
  |> predicates.is_close(2.0, 0.0, tol)
  |> should.be_true()

  special.gamma(10.0)
  |> predicates.is_close(362_880.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_incomplete_gamma_function_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Invalid input gives an error
  // 1st arg is invalid
  special.incomplete_gamma(-1.0, 1.0)
  |> should.be_error()

  // 2nd arg is invalid
  special.incomplete_gamma(1.0, -1.0)
  |> should.be_error()

  // Valid input returns a result
  special.incomplete_gamma(1.0, 0.0)
  |> result.unwrap(-999.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  special.incomplete_gamma(1.0, 2.0)
  |> result.unwrap(-999.0)
  |> predicates.is_close(0.864664716763387308106, 0.0, tol)
  |> should.be_true()

  special.incomplete_gamma(2.0, 3.0)
  |> result.unwrap(-999.0)
  |> predicates.is_close(0.8008517265285442280826, 0.0, tol)
  |> should.be_true()

  special.incomplete_gamma(3.0, 4.0)
  |> result.unwrap(-999.0)
  |> predicates.is_close(1.523793388892911312363, 0.0, tol)
  |> should.be_true()
}
