import gleam/float
import gleam/result
import gleam_community/maths
import gleeunit/should

pub fn float_beta_function_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Valid input returns a result
  maths.beta(-0.5, 0.5)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.beta(0.5, 0.5)
  |> maths.is_close(3.1415926535897927, 0.0, tol)
  |> should.be_true()

  maths.beta(0.5, -0.5)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.beta(5.0, 5.0)
  |> maths.is_close(0.0015873015873015873, 0.0, tol)
  |> should.be_true()
}

pub fn float_error_function_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Valid input returns a result
  maths.erf(-0.5)
  |> maths.is_close(-0.5204998778130465, 0.0, tol)
  |> should.be_true()

  maths.erf(0.5)
  |> maths.is_close(0.5204998778130465, 0.0, tol)
  |> should.be_true()

  maths.erf(1.0)
  |> maths.is_close(0.8427007929497148, 0.0, tol)
  |> should.be_true()

  maths.erf(2.0)
  |> maths.is_close(0.9953222650189527, 0.0, tol)
  |> should.be_true()

  maths.erf(10.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_gamma_function_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Valid input returns a result
  maths.gamma(-0.5)
  |> maths.is_close(-3.5449077018110318, 0.0, tol)
  |> should.be_true()

  maths.gamma(0.5)
  |> maths.is_close(1.7724538509055159, 0.0, tol)
  |> should.be_true()

  maths.gamma(1.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.gamma(2.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.gamma(3.0)
  |> maths.is_close(2.0, 0.0, tol)
  |> should.be_true()

  maths.gamma(10.0)
  |> maths.is_close(362_880.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_incomplete_gamma_function_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Invalid input gives an error
  // 1st arg is invalid
  maths.incomplete_gamma(-1.0, 1.0)
  |> should.be_error()

  // 2nd arg is invalid
  maths.incomplete_gamma(1.0, -1.0)
  |> should.be_error()

  // Valid input returns a result
  maths.incomplete_gamma(1.0, 0.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.incomplete_gamma(1.0, 2.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.864664716763387308106, 0.0, tol)
  |> should.be_true()

  maths.incomplete_gamma(2.0, 3.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.8008517265285442280826, 0.0, tol)
  |> should.be_true()

  maths.incomplete_gamma(3.0, 4.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(1.523793388892911312363, 0.0, tol)
  |> should.be_true()
}
