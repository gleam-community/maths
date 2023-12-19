import gleam_community/maths/elementary
import gleam_community/maths/predicates
import gleeunit/should
import gleam/option

pub fn float_acos_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = elementary.acos(1.0)
  result
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = elementary.acos(0.5)
  result
  |> predicates.is_close(1.047197, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.acos(1.1)
  |> should.be_error()

  elementary.acos(-1.1)
  |> should.be_error()
}

pub fn float_acosh_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = elementary.acosh(1.0)
  result
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.acosh(0.0)
  |> should.be_error()
}

pub fn float_asin_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.asin(0.0)
  |> should.equal(Ok(0.0))

  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  let assert Ok(result) = elementary.asin(0.5)
  result
  |> predicates.is_close(0.523598, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.asin(1.1)
  |> should.be_error()

  elementary.asin(-1.1)
  |> should.be_error()
}

pub fn float_asinh_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.asinh(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  elementary.asinh(0.5)
  |> predicates.is_close(0.481211, 0.0, tol)
  |> should.be_true()
}

pub fn float_atan_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.atan(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  elementary.atan(0.5)
  |> predicates.is_close(0.463647, 0.0, tol)
  |> should.be_true()
}

pub fn math_atan2_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.atan2(0.0, 0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  elementary.atan2(0.0, 1.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.0, x=0.5)
  // Should be equal to atan(y / x) for any x > 0 and any y
  let result = elementary.atan(1.0 /. 0.5)
  elementary.atan2(1.0, 0.5)
  |> predicates.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=2.0, x=-1.5)
  // Should be equal to pi + atan(y / x) for any x < 0 and y >= 0
  let result = elementary.pi() +. elementary.atan(2.0 /. -1.5)
  elementary.atan2(2.0, -1.5)
  |> predicates.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-2.0, x=-1.5)
  // Should be equal to atan(y / x) - pi for any x < 0 and y < 0
  let result = elementary.atan(-2.0 /. -1.5) -. elementary.pi()
  elementary.atan2(-2.0, -1.5)
  |> predicates.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.5, x=0.0)
  // Should be equal to pi/2 for x = 0 and any y > 0
  let result = elementary.pi() /. 2.0
  elementary.atan2(1.5, 0.0)
  |> predicates.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-1.5, x=0.0)
  // Should be equal to -pi/2 for x = 0 and any y < 0
  let result = -1.0 *. elementary.pi() /. 2.0
  elementary.atan2(-1.5, 0.0)
  |> predicates.is_close(result, 0.0, tol)
  |> should.be_true()
}

pub fn float_atanh_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = elementary.atanh(0.0)
  result
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = elementary.atanh(0.5)
  result
  |> predicates.is_close(0.549306, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.atanh(1.0)
  |> should.be_error()

  elementary.atanh(2.0)
  |> should.be_error()

  elementary.atanh(1.0)
  |> should.be_error()

  elementary.atanh(-2.0)
  |> should.be_error()
}

pub fn float_cos_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.cos(0.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  elementary.cos(elementary.pi())
  |> predicates.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  elementary.cos(0.5)
  |> predicates.is_close(0.877582, 0.0, tol)
  |> should.be_true()
}

pub fn float_cosh_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.cosh(0.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  elementary.cosh(0.5)
  |> predicates.is_close(1.127625, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. elementary.cosh(1000.0) but this is a property of the
  // runtime.
}

pub fn float_sin_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.sin(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  elementary.sin(0.5 *. elementary.pi())
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  elementary.sin(0.5)
  |> predicates.is_close(0.479425, 0.0, tol)
  |> should.be_true()
}

pub fn float_sinh_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.sinh(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  elementary.sinh(0.5)
  |> predicates.is_close(0.521095, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. elementary.sinh(1000.0) but this is a property of the
  // runtime.
}

pub fn math_tan_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.tan(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  elementary.tan(0.5)
  |> predicates.is_close(0.546302, 0.0, tol)
  |> should.be_true()
}

pub fn math_tanh_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.tanh(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  elementary.tanh(25.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  elementary.tanh(-25.0)
  |> predicates.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  elementary.tanh(0.5)
  |> predicates.is_close(0.462117, 0.0, tol)
  |> should.be_true()
}

pub fn float_exponential_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.exponential(0.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  elementary.exponential(0.5)
  |> predicates.is_close(1.648721, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. elementary.exponential(1000.0) but this is a property of the
  // runtime.
}

pub fn float_natural_logarithm_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.natural_logarithm(1.0)
  |> should.equal(Ok(0.0))

  let assert Ok(result) = elementary.natural_logarithm(0.5)
  result
  |> predicates.is_close(-0.693147, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.natural_logarithm(-1.0)
  |> should.be_error()
}

pub fn float_logarithm_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.logarithm(10.0, option.Some(10.0))
  |> should.equal(Ok(1.0))

  elementary.logarithm(10.0, option.Some(100.0))
  |> should.equal(Ok(0.5))

  elementary.logarithm(1.0, option.Some(0.25))
  |> should.equal(Ok(0.0))

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.logarithm(1.0, option.Some(1.0))
  |> should.be_error()

  elementary.logarithm(10.0, option.Some(1.0))
  |> should.be_error()

  elementary.logarithm(-1.0, option.Some(1.0))
  |> should.be_error()

  elementary.logarithm(1.0, option.Some(10.0))
  |> should.equal(Ok(0.0))

  elementary.logarithm(elementary.e(), option.Some(elementary.e()))
  |> should.equal(Ok(1.0))

  elementary.logarithm(-1.0, option.Some(2.0))
  |> should.be_error()
}

pub fn float_logarithm_2_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  elementary.logarithm_2(1.0)
  |> should.equal(Ok(0.0))

  elementary.logarithm_2(2.0)
  |> should.equal(Ok(1.0))

  let assert Ok(result) = elementary.logarithm_2(5.0)
  result
  |> predicates.is_close(2.321928, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.logarithm_2(-1.0)
  |> should.be_error()
}

pub fn float_logarithm_10_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = elementary.logarithm_10(1.0)
  result
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = elementary.logarithm_10(10.0)
  result
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = elementary.logarithm_10(50.0)
  result
  |> predicates.is_close(1.69897, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  elementary.logarithm_10(-1.0)
  |> should.be_error()
}

pub fn float_power_test() {
  elementary.power(2.0, 2.0)
  |> should.equal(Ok(4.0))

  elementary.power(-5.0, 3.0)
  |> should.equal(Ok(-125.0))

  elementary.power(10.5, 0.0)
  |> should.equal(Ok(1.0))

  elementary.power(16.0, 0.5)
  |> should.equal(Ok(4.0))

  elementary.power(2.0, -1.0)
  |> should.equal(Ok(0.5))

  elementary.power(2.0, -1.0)
  |> should.equal(Ok(0.5))

  // elementary.power(-1.0, 0.5) is equivalent to float.square_root(-1.0)
  // and should return an error as an imaginary number would otherwise
  // have to be returned
  elementary.power(-1.0, 0.5)
  |> should.be_error()

  // Check another case with a negative base and fractional exponent
  elementary.power(-1.5, 1.5)
  |> should.be_error()

  // elementary.power(0.0, -1.0) is equivalent to 1. /. 0 and is expected
  // to be an error
  elementary.power(0.0, -1.0)
  |> should.be_error()

  // Check that a negative base and exponent is fine as long as the
  // exponent is not fractional
  elementary.power(-2.0, -1.0)
  |> should.equal(Ok(-0.5))
}

pub fn float_square_root_test() {
  elementary.square_root(1.0)
  |> should.equal(Ok(1.0))

  elementary.square_root(9.0)
  |> should.equal(Ok(3.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  elementary.square_root(-1.0)
  |> should.be_error()
}

pub fn float_cube_root_test() {
  elementary.cube_root(1.0)
  |> should.equal(Ok(1.0))

  elementary.cube_root(27.0)
  |> should.equal(Ok(3.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  elementary.cube_root(-1.0)
  |> should.be_error()
}

pub fn float_nth_root_test() {
  elementary.nth_root(9.0, 2)
  |> should.equal(Ok(3.0))

  elementary.nth_root(27.0, 3)
  |> should.equal(Ok(3.0))

  elementary.nth_root(1.0, 4)
  |> should.equal(Ok(1.0))

  elementary.nth_root(256.0, 4)
  |> should.equal(Ok(4.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  elementary.nth_root(-1.0, 4)
  |> should.be_error()
}

pub fn float_constants_test() {
  elementary.e()
  |> predicates.is_close(2.71828, 0.0, 0.00001)
  |> should.be_true()

  elementary.pi()
  |> predicates.is_close(3.14159, 0.0, 0.00001)
  |> should.be_true()
}
