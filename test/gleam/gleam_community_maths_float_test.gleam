import gleam_community/maths/float as floatx
import gleeunit
import gleeunit/should
import gleam/result
import gleam/io
import gleam/option

pub fn main() {
  gleeunit.main()
}

pub fn float_acos_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.acos(1.0)
  result
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.acos(0.5)
  result
  |> floatx.is_close(1.047197, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.acos(1.1)
  |> should.be_error()

  floatx.acos(-1.1)
  |> should.be_error()
}

pub fn float_acosh_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.acosh(1.0)
  result
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.acosh(0.0)
  |> should.be_error()
}

pub fn float_asin_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.asin(0.0)
  |> should.equal(Ok(0.0))

  assert Ok(tol) = floatx.power(-10.0, -6.0)
  assert Ok(result) = floatx.asin(0.5)
  result
  |> floatx.is_close(0.523598, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.asin(1.1)
  |> should.be_error()

  floatx.asin(-1.1)
  |> should.be_error()
}

pub fn float_asinh_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.asinh(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.asinh(0.5)
  |> floatx.is_close(0.481211, 0.0, tol)
  |> should.be_true()
}

pub fn float_atan_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.atan(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.atan(0.5)
  |> floatx.is_close(0.463647, 0.0, tol)
  |> should.be_true()
}

pub fn math_atan2_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.atan2(0.0, 0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.atan2(0.0, 1.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.0, x=0.5)
  // Should be equal to atan(y / x) for any x > 0 and any y
  let result = floatx.atan(1.0 /. 0.5)
  floatx.atan2(1.0, 0.5)
  |> floatx.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=2.0, x=-1.5)
  // Should be equal to pi + atan(y / x) for any x < 0 and y >= 0
  let result = floatx.pi() +. floatx.atan(2.0 /. -1.5)
  floatx.atan2(2.0, -1.5)
  |> floatx.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-2.0, x=-1.5)
  // Should be equal to atan(y / x) - pi for any x < 0 and y < 0
  let result = floatx.atan(-2.0 /. -1.5) -. floatx.pi()
  floatx.atan2(-2.0, -1.5)
  |> floatx.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.5, x=0.0)
  // Should be equal to pi/2 for x = 0 and any y > 0
  let result = floatx.pi() /. 2.0
  floatx.atan2(1.5, 0.0)
  |> floatx.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-1.5, x=0.0)
  // Should be equal to -pi/2 for x = 0 and any y < 0
  let result = -1.0 *. floatx.pi() /. 2.0
  floatx.atan2(-1.5, 0.0)
  |> floatx.is_close(result, 0.0, tol)
  |> should.be_true()
}

pub fn float_atanh_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.atanh(0.0)
  result
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.atanh(0.5)
  result
  |> floatx.is_close(0.549306, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.atanh(1.0)
  |> should.be_error()

  floatx.atanh(2.0)
  |> should.be_error()

  floatx.atanh(1.0)
  |> should.be_error()

  floatx.atanh(-2.0)
  |> should.be_error()
}

pub fn float_cos_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.cos(0.0)
  |> floatx.is_close(1.0, 0.0, tol)
  |> should.be_true()

  floatx.cos(floatx.pi())
  |> floatx.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  floatx.cos(0.5)
  |> floatx.is_close(0.877582, 0.0, tol)
  |> should.be_true()
}

pub fn float_cosh_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.cosh(0.0)
  |> floatx.is_close(1.0, 0.0, tol)
  |> should.be_true()

  floatx.cosh(0.5)
  |> floatx.is_close(1.127625, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. floatx.cosh(1000.0) but this is a property of the
  // runtime.
}

pub fn float_exponential_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.exponential(0.0)
  |> floatx.is_close(1.0, 0.0, tol)
  |> should.be_true()

  floatx.exponential(0.5)
  |> floatx.is_close(1.648721, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. floatx.exponential(1000.0) but this is a property of the
  // runtime.
}

pub fn float_natural_logarithm_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.natural_logarithm(1.0)
  |> should.equal(Ok(0.0))

  assert Ok(result) = floatx.natural_logarithm(0.5)
  result
  |> floatx.is_close(-0.693147, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.natural_logarithm(-1.0)
  |> should.be_error()
}

pub fn float_logarithm_10_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.logarithm_10(1.0)
  result
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.logarithm_10(10.0)
  result
  |> floatx.is_close(1.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.logarithm_10(50.0)
  result
  |> floatx.is_close(1.698970, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.logarithm_10(-1.0)
  |> should.be_error()
}

pub fn float_logarithm_2_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.logarithm_2(1.0)
  |> should.equal(Ok(0.0))

  floatx.logarithm_2(2.0)
  |> should.equal(Ok(1.0))

  assert Ok(result) = floatx.logarithm_2(5.0)
  result
  |> floatx.is_close(2.321928, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.logarithm_2(-1.0)
  |> should.be_error()
}

pub fn float_logarithm_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.logarithm(10.0, option.Some(10.0))
  |> should.equal(Ok(1.0))

  floatx.logarithm(10.0, option.Some(100.0))
  |> should.equal(Ok(0.5))

  floatx.logarithm(1.0, option.Some(0.25))
  |> should.equal(Ok(0.0))

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.logarithm(1.0, option.Some(1.0))
  |> should.be_error()

  floatx.logarithm(10.0, option.Some(1.0))
  |> should.be_error()

  floatx.logarithm(-1.0, option.Some(1.0))
  |> should.be_error()

  floatx.logarithm(1.0, option.Some(10.0))
  |> should.equal(Ok(0.0))

  floatx.logarithm(floatx.e(), option.Some(floatx.e()))
  |> should.equal(Ok(1.0))

  floatx.logarithm(-1.0, option.Some(2.0))
  |> should.be_error()
}

pub fn float_power_test() {
  floatx.power(2.0, 2.0)
  |> should.equal(Ok(4.0))

  floatx.power(-5.0, 3.0)
  |> should.equal(Ok(-125.0))

  floatx.power(10.5, 0.0)
  |> should.equal(Ok(1.0))

  floatx.power(16.0, 0.5)
  |> should.equal(Ok(4.0))

  floatx.power(2.0, -1.0)
  |> should.equal(Ok(0.5))

  floatx.power(2.0, -1.0)
  |> should.equal(Ok(0.5))

  // floatx.power(-1.0, 0.5) is equivalent to float.square_root(-1.0)
  // and should return an error as an imaginary number would otherwise
  // have to be returned
  floatx.power(-1.0, 0.5)
  |> should.be_error()

  // Check another case with a negative base and fractional exponent
  floatx.power(-1.5, 1.5)
  |> should.be_error()

  // floatx.power(0.0, -1.0) is equivalent to 1. /. 0 and is expected
  // to be an error
  floatx.power(0.0, -1.0)
  |> should.be_error()

  // Check that a negative base and exponent is fine as long as the
  // exponent is not fractional
  floatx.power(-2.0, -1.0)
  |> should.equal(Ok(-0.5))
}

pub fn float_square_root_test() {
  floatx.square_root(1.0)
  |> should.equal(Ok(1.0))

  floatx.square_root(9.0)
  |> should.equal(Ok(3.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  floatx.square_root(-1.0)
  |> should.be_error()
}

pub fn float_cube_root_test() {
  floatx.cube_root(1.0)
  |> should.equal(Ok(1.0))

  floatx.cube_root(27.0)
  |> should.equal(Ok(3.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  floatx.cube_root(-1.0)
  |> should.be_error()
}

pub fn float_nth_root_test() {
  floatx.nth_root(9.0, 2)
  |> should.equal(Ok(3.0))

  floatx.nth_root(27.0, 3)
  |> should.equal(Ok(3.0))

  floatx.nth_root(1.0, 4)
  |> should.equal(Ok(1.0))

  floatx.nth_root(256.0, 4)
  |> should.equal(Ok(4.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  floatx.nth_root(-1.0, 4)
  |> should.be_error()
}

pub fn float_hypotenuse_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)

  floatx.hypotenuse(0.0, 0.0)
  |> should.equal(0.0)

  floatx.hypotenuse(1.0, 0.0)
  |> should.equal(1.0)

  floatx.hypotenuse(0.0, 1.0)
  |> should.equal(1.0)

  let result = floatx.hypotenuse(11.0, 22.0)
  result
  |> floatx.is_close(24.596747, 0.0, tol)
  |> should.be_true()
}

pub fn float_sin_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.sin(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.sin(0.5 *. floatx.pi())
  |> floatx.is_close(1.0, 0.0, tol)
  |> should.be_true()

  floatx.sin(0.5)
  |> floatx.is_close(0.479425, 0.0, tol)
  |> should.be_true()
}

pub fn float_sinh_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.sinh(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.sinh(0.5)
  |> floatx.is_close(0.521095, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. floatx.sinh(1000.0) but this is a property of the
  // runtime.
}

pub fn math_tan_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.tan(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.tan(0.5)
  |> floatx.is_close(0.546302, 0.0, tol)
  |> should.be_true()
}

pub fn math_tanh_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.tanh(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.tanh(25.0)
  |> floatx.is_close(1.0, 0.0, tol)
  |> should.be_true()

  floatx.tanh(-25.0)
  |> floatx.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  floatx.tanh(0.5)
  |> floatx.is_close(0.462117, 0.0, tol)
  |> should.be_true()
}

pub fn float_to_degree_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  floatx.to_degree(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.to_degree(2.0 *. floatx.pi())
  |> floatx.is_close(360.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_to_radian_test() {
  assert Ok(tol) = floatx.power(-10.0, -6.0)
  floatx.to_radian(0.0)
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  floatx.to_radian(360.0)
  |> floatx.is_close(2.0 *. floatx.pi(), 0.0, tol)
  |> should.be_true()
}

pub fn float_ceiling_test() {
  // Round 3. digit AFTER decimal point 
  floatx.ceiling(12.0654, option.Some(3))
  |> should.equal(Ok(12.066))

  // Round 2. digit AFTER decimal point 
  floatx.ceiling(12.0654, option.Some(2))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  floatx.ceiling(12.0654, option.Some(1))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  floatx.ceiling(12.0654, option.Some(0))
  |> should.equal(Ok(13.0))

  // Round 1. digit BEFORE decimal point 
  floatx.ceiling(12.0654, option.Some(-1))
  |> should.equal(Ok(20.0))

  // Round 2. digit BEFORE decimal point 
  floatx.ceiling(12.0654, option.Some(-2))
  |> should.equal(Ok(100.0))

  // Round 3. digit BEFORE decimal point 
  floatx.ceiling(12.0654, option.Some(-3))
  |> should.equal(Ok(1000.0))
}

pub fn float_floor_test() {
  // Round 3. digit AFTER decimal point 
  floatx.floor(12.0654, option.Some(3))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  floatx.floor(12.0654, option.Some(2))
  |> should.equal(Ok(12.06))

  // Round 1. digit AFTER decimal point 
  floatx.floor(12.0654, option.Some(1))
  |> should.equal(Ok(12.0))

  // Round 0. digit BEFORE decimal point 
  floatx.floor(12.0654, option.Some(0))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  floatx.floor(12.0654, option.Some(-1))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  floatx.floor(12.0654, option.Some(-2))
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  floatx.floor(12.0654, option.Some(-3))
  |> should.equal(Ok(0.0))
}

pub fn float_truncate_test() {
  // Round 3. digit AFTER decimal point 
  floatx.truncate(12.0654, option.Some(3))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  floatx.truncate(12.0654, option.Some(2))
  |> should.equal(Ok(12.06))

  // Round 1. digit AFTER decimal point 
  floatx.truncate(12.0654, option.Some(1))
  |> should.equal(Ok(12.0))

  // Round 0. digit BEFORE decimal point 
  floatx.truncate(12.0654, option.Some(0))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  floatx.truncate(12.0654, option.Some(-1))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  floatx.truncate(12.0654, option.Some(-2))
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  floatx.truncate(12.0654, option.Some(-3))
  |> should.equal(Ok(0.0))
}

pub fn float_minimum_test() {
  floatx.minimum(0.75, 0.5)
  |> should.equal(0.5)

  floatx.minimum(0.5, 0.75)
  |> should.equal(0.5)

  floatx.minimum(-0.75, 0.5)
  |> should.equal(-0.75)

  floatx.minimum(-0.75, 0.5)
  |> should.equal(-0.75)
}

pub fn float_maximum_test() {
  floatx.maximum(0.75, 0.5)
  |> should.equal(0.75)

  floatx.maximum(0.5, 0.75)
  |> should.equal(0.75)

  floatx.maximum(-0.75, 0.5)
  |> should.equal(0.5)

  floatx.maximum(-0.75, 0.5)
  |> should.equal(0.5)
}

pub fn float_minmax_test() {
  floatx.minmax(0.75, 0.5)
  |> should.equal(#(0.5, 0.75))

  floatx.minmax(0.5, 0.75)
  |> should.equal(#(0.5, 0.75))

  floatx.minmax(-0.75, 0.5)
  |> should.equal(#(-0.75, 0.5))

  floatx.minmax(-0.75, 0.5)
  |> should.equal(#(-0.75, 0.5))
}

pub fn float_sign_test() {
  floatx.sign(100.0)
  |> should.equal(1.0)

  floatx.sign(0.0)
  |> should.equal(0.0)

  floatx.sign(-100.0)
  |> should.equal(-1.0)
}

pub fn float_flip_sign_test() {
  floatx.flip_sign(100.0)
  |> should.equal(-100.0)

  floatx.flip_sign(0.0)
  |> should.equal(-0.0)

  floatx.flip_sign(-100.0)
  |> should.equal(100.0)
}

pub fn float_copy_sign_test() {
  floatx.copy_sign(100.0, 10.0)
  |> should.equal(100.0)

  floatx.copy_sign(-100.0, 10.0)
  |> should.equal(100.0)

  floatx.copy_sign(100.0, -10.0)
  |> should.equal(-100.0)

  floatx.copy_sign(-100.0, -10.0)
  |> should.equal(-100.0)
}

pub fn float_beta_function_test() {
  io.debug("TODO: Implement tests for 'float.beta'.")
}

pub fn float_error_function_test() {
  io.debug("TODO: Implement tests for 'float.erf'.")
}

pub fn float_gamma_function_test() {
  io.debug("TODO: Implement tests for 'float.gamma'.")
}

pub fn math_round_to_nearest_test() {
  // Try with positive values
  floatx.round(1.50, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(2.0))

  floatx.round(1.75, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(2.0))

  floatx.round(2.00, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(2.0))

  floatx.round(3.50, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(4.0))

  floatx.round(4.50, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(4.0))

  // Try with negative values
  floatx.round(-3.50, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(-4.0))

  floatx.round(-4.50, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(-4.0))

  // Round 3. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(3), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(1), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(0), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-1), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-2), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(0.0))

  // Round 3. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-3), option.Some(floatx.RoundNearest))
  |> should.equal(Ok(0.0))
}

pub fn math_round_up_test() {
  // Note: Rounding mode "RoundUp" is an alias for the ceiling function
  // Try with positive values
  floatx.round(0.45, option.Some(0), option.Some(floatx.RoundUp))
  |> should.equal(Ok(1.0))

  floatx.round(0.50, option.Some(0), option.Some(floatx.RoundUp))
  |> should.equal(Ok(1.0))

  floatx.round(0.45, option.Some(1), option.Some(floatx.RoundUp))
  |> should.equal(Ok(0.5))

  floatx.round(0.50, option.Some(1), option.Some(floatx.RoundUp))
  |> should.equal(Ok(0.5))

  floatx.round(0.455, option.Some(2), option.Some(floatx.RoundUp))
  |> should.equal(Ok(0.46))

  floatx.round(0.505, option.Some(2), option.Some(floatx.RoundUp))
  |> should.equal(Ok(0.51))

  // Try with negative values
  floatx.round(-0.45, option.Some(0), option.Some(floatx.RoundUp))
  |> should.equal(Ok(-0.0))

  floatx.round(-0.50, option.Some(0), option.Some(floatx.RoundUp))
  |> should.equal(Ok(-0.0))

  floatx.round(-0.45, option.Some(1), option.Some(floatx.RoundUp))
  |> should.equal(Ok(-0.4))

  floatx.round(-0.50, option.Some(1), option.Some(floatx.RoundUp))
  |> should.equal(Ok(-0.5))

  floatx.round(-0.4550, option.Some(2), option.Some(floatx.RoundUp))
  |> should.equal(Ok(-0.45))

  floatx.round(-0.5050, option.Some(2), option.Some(floatx.RoundUp))
  |> should.equal(Ok(-0.5))
}

pub fn math_round_down_test() {
  // Note: Rounding mode "RoundDown" is an alias for the floor function
  // Try with positive values
  floatx.round(0.45, option.Some(0), option.Some(floatx.RoundDown))
  |> should.equal(Ok(0.0))

  floatx.round(0.50, option.Some(0), option.Some(floatx.RoundDown))
  |> should.equal(Ok(0.0))

  floatx.round(0.45, option.Some(1), option.Some(floatx.RoundDown))
  |> should.equal(Ok(0.4))

  floatx.round(0.50, option.Some(1), option.Some(floatx.RoundDown))
  |> should.equal(Ok(0.50))

  floatx.round(0.4550, option.Some(2), option.Some(floatx.RoundDown))
  |> should.equal(Ok(0.45))

  floatx.round(0.5050, option.Some(2), option.Some(floatx.RoundDown))
  |> should.equal(Ok(0.50))

  // Try with negative values
  floatx.round(-0.45, option.Some(0), option.Some(floatx.RoundDown))
  |> should.equal(Ok(-1.0))

  floatx.round(-0.50, option.Some(0), option.Some(floatx.RoundDown))
  |> should.equal(Ok(-1.0))

  floatx.round(-0.45, option.Some(1), option.Some(floatx.RoundDown))
  |> should.equal(Ok(-0.5))

  floatx.round(-0.50, option.Some(1), option.Some(floatx.RoundDown))
  |> should.equal(Ok(-0.50))

  floatx.round(-0.4550, option.Some(2), option.Some(floatx.RoundDown))
  |> should.equal(Ok(-0.46))

  floatx.round(-0.5050, option.Some(2), option.Some(floatx.RoundDown))
  |> should.equal(Ok(-0.51))
}

pub fn math_round_to_zero_test() {
  // Note: Rounding mode "RoundToZero" is an alias for the truncate function
  // Try with positive values
  floatx.round(0.50, option.Some(0), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.0))

  floatx.round(0.75, option.Some(0), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.0))

  floatx.round(0.45, option.Some(1), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.4))

  floatx.round(0.57, option.Some(1), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.50))

  floatx.round(0.4575, option.Some(2), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.45))

  floatx.round(0.5075, option.Some(2), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.50))

  // Try with negative values
  floatx.round(-0.50, option.Some(0), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.0))

  floatx.round(-0.75, option.Some(0), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(0.0))

  floatx.round(-0.45, option.Some(1), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(-0.4))

  floatx.round(-0.57, option.Some(1), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(-0.50))

  floatx.round(-0.4575, option.Some(2), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(-0.45))

  floatx.round(-0.5075, option.Some(2), option.Some(floatx.RoundToZero))
  |> should.equal(Ok(-0.50))
}

pub fn math_round_ties_away_test() {
  // Try with positive values
  floatx.round(1.40, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(1.0))

  floatx.round(1.50, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(2.0))

  floatx.round(2.50, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(3.0))

  // Try with negative values
  floatx.round(-1.40, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(-1.0))

  floatx.round(-1.50, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(-2.0))

  floatx.round(-2.00, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(-2.0))

  floatx.round(-2.50, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(-3.0))

  // Round 3. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(3), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(1), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(0), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-1), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-2), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-3), option.Some(floatx.RoundTiesAway))
  |> should.equal(Ok(0.0))
}

pub fn math_round_ties_up_test() {
  // Try with positive values
  floatx.round(1.40, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(1.0))

  floatx.round(1.50, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(2.0))

  floatx.round(2.50, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(3.0))

  // Try with negative values
  floatx.round(-1.40, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(-1.0))

  floatx.round(-1.50, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(-1.0))

  floatx.round(-2.00, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(-2.0))

  floatx.round(-2.50, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(-2.0))

  // Round 3. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(3), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  floatx.round(12.0654, option.Some(1), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(0), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-1), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-2), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  floatx.round(12.0654, option.Some(-3), option.Some(floatx.RoundTiesUp))
  |> should.equal(Ok(0.0))
}

pub fn math_round_edge_cases_test() {
  // The default number of digits is 0 if None is provided
  floatx.round(12.0654, option.None, option.Some(floatx.RoundNearest))
  |> should.equal(Ok(12.0))

  // The default rounding mode is floatx.RoundNearest if None is provided 
  floatx.round(12.0654, option.None, option.None)
  |> should.equal(Ok(12.0))
}

pub fn float_incomplete_gamma_function_test() {
  // Invalid input gives an error
  // 1st arg is invalid
  floatx.incomplete_gamma(-1.0, 1.0)
  |> should.be_error()

  // 2nd arg is invalid
  floatx.incomplete_gamma(1.0, -1.0)
  |> should.be_error()

  // Valid input returns a result
  floatx.incomplete_gamma(1.0, 0.0)
  |> result.unwrap(-999.0)
  |> floatx.is_close(0.0, 0.0, 0.01)
  |> should.be_true()

  floatx.incomplete_gamma(1.0, 2.0)
  |> result.unwrap(-999.0)
  |> floatx.is_close(0.864664716763387308106, 0.0, 0.01)
  |> should.be_true()

  floatx.incomplete_gamma(2.0, 3.0)
  |> result.unwrap(-999.0)
  |> floatx.is_close(0.8008517265285442280826, 0.0, 0.01)
  |> should.be_true()

  floatx.incomplete_gamma(3.0, 4.0)
  |> result.unwrap(-999.0)
  |> floatx.is_close(1.523793388892911312363, 0.0, 0.01)
  |> should.be_true()
}

pub fn float_absolute_difference_test() {
  floatx.absolute_difference(0.0, 0.0)
  |> should.equal(0.0)

  floatx.absolute_difference(1.0, 2.0)
  |> should.equal(1.0)

  floatx.absolute_difference(2.0, 1.0)
  |> should.equal(1.0)

  floatx.absolute_difference(-1.0, 0.0)
  |> should.equal(1.0)

  floatx.absolute_difference(0.0, -1.0)
  |> should.equal(1.0)

  floatx.absolute_difference(10.0, 20.0)
  |> should.equal(10.0)

  floatx.absolute_difference(-10.0, -20.0)
  |> should.equal(10.0)

  floatx.absolute_difference(-10.5, 10.5)
  |> should.equal(21.0)
}

pub fn float_constants_test() {
  floatx.e()
  |> floatx.is_close(2.71828, 0.0, 0.00001)
  |> should.be_true()

  floatx.pi()
  |> floatx.is_close(3.14159, 0.0, 0.00001)
  |> should.be_true()
}

pub fn float_is_close_test() {
  let val: Float = 99.0
  let ref_val: Float = 100.0
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol: Float = 0.01
  let atol: Float = 0.10
  floatx.is_close(val, ref_val, rtol, atol)
  |> should.be_true()
}

pub fn float_to_int_test() {
  floatx.to_int(12.0654)
  |> should.equal(12)
}
