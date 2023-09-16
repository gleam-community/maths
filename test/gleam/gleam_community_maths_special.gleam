import gleam_community/maths/special
import gleam_community/maths/tests
import gleeunit
import gleeunit/should
import gleam/result
import gleam/io

pub fn main() {
  gleeunit.main()
}

pub fn float_beta_function_test() {
  io.debug("")
  io.debug("TODO: Implement tests for 'float.beta'.")
}

pub fn float_error_function_test() {
  io.debug("")
  io.debug("TODO: Implement tests for 'float.erf'.")
}

pub fn float_gamma_function_test() {
  io.debug("")
  io.debug("TODO: Implement tests for 'float.gamma'.")
}

pub fn float_incomplete_gamma_function_test() {
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
  |> tests.is_close(0.0, 0.0, 0.01)
  |> should.be_true()

  special.incomplete_gamma(1.0, 2.0)
  |> result.unwrap(-999.0)
  |> tests.is_close(0.864664716763387308106, 0.0, 0.01)
  |> should.be_true()

  special.incomplete_gamma(2.0, 3.0)
  |> result.unwrap(-999.0)
  |> tests.is_close(0.8008517265285442280826, 0.0, 0.01)
  |> should.be_true()

  special.incomplete_gamma(3.0, 4.0)
  |> result.unwrap(-999.0)
  |> tests.is_close(1.523793388892911312363, 0.0, 0.01)
  |> should.be_true()
}
