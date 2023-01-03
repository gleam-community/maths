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
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.acos(1.0)
  result
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.acos(0.5)
  result
  |> floatx.isclose(1.047197, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.acos(1.1)
  |> should.be_error()

  floatx.acos(-1.1)
  |> should.be_error()
}

pub fn float_acosh_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.acosh(1.0)
  result
  |> floatx.isclose(0.0, 0.0, tol)
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

  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  assert Ok(result) = floatx.asin(0.5)
  result
  |> floatx.isclose(0.523598, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.asin(1.1)
  |> should.be_error()

  floatx.asin(-1.1)
  |> should.be_error()
}

pub fn float_asinh_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.asinh(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.asinh(0.5)
  |> floatx.isclose(0.481211, 0.0, tol)
  |> should.be_true()
}

pub fn float_atan_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.atan(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.atan(0.5)
  |> floatx.isclose(0.463647, 0.0, tol)
  |> should.be_true()
}

pub fn math_atan2_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.atan2(0.0, 0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.atan2(0.0, 1.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.0, x=0.5)
  // Should be equal to atan(y / x) for any x > 0 and any y
  let result = floatx.atan(1.0 /. 0.5)
  floatx.atan2(1.0, 0.5)
  |> floatx.isclose(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=2.0, x=-1.5)
  // Should be equal to pi + atan(y / x) for any x < 0 and y >= 0
  let result = floatx.pi() +. floatx.atan(2.0 /. -1.5)
  floatx.atan2(2.0, -1.5)
  |> floatx.isclose(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-2.0, x=-1.5)
  // Should be equal to atan(y / x) - pi for any x < 0 and y < 0
  let result = floatx.atan(-2.0 /. -1.5) -. floatx.pi()
  floatx.atan2(-2.0, -1.5)
  |> floatx.isclose(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.5, x=0.0)
  // Should be equal to pi/2 for x = 0 and any y > 0
  let result = floatx.pi() /. 2.0
  floatx.atan2(1.5, 0.0)
  |> floatx.isclose(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-1.5, x=0.0)
  // Should be equal to -pi/2 for x = 0 and any y < 0
  let result = -1.0 *. floatx.pi() /. 2.0
  floatx.atan2(-1.5, 0.0)
  |> floatx.isclose(result, 0.0, tol)
  |> should.be_true()
}

pub fn float_atanh_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.atanh(0.0)
  result
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.atanh(0.5)
  result
  |> floatx.isclose(0.549306, 0.0, tol)
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
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.cos(0.0)
  |> floatx.isclose(1.0, 0.0, tol)
  |> should.be_true()

  floatx.cos(floatx.pi())
  |> floatx.isclose(-1.0, 0.0, tol)
  |> should.be_true()

  floatx.cos(0.5)
  |> floatx.isclose(0.877582, 0.0, tol)
  |> should.be_true()
}

pub fn float_cosh_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.cosh(0.0)
  |> floatx.isclose(1.0, 0.0, tol)
  |> should.be_true()

  floatx.cosh(0.5)
  |> floatx.isclose(1.127625, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. floatx.cosh(1000.0) but this is a property of the
  // runtime.
}

pub fn float_exp_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.exp(0.0)
  |> floatx.isclose(1.0, 0.0, tol)
  |> should.be_true()

  floatx.exp(0.5)
  |> floatx.isclose(1.648721, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. floatx.exp(1000.0) but this is a property of the
  // runtime.
}

pub fn float_log_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.log(1.0)
  |> should.equal(Ok(0.0))

  assert Ok(result) = floatx.log(0.5)
  result
  |> floatx.isclose(-0.693147, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.log(-1.0)
  |> should.be_error()
}

pub fn floatx_log10_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = floatx.log10(1.0)
  result
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.log10(10.0)
  result
  |> floatx.isclose(1.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = floatx.log10(50.0)
  result
  |> floatx.isclose(1.698970, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.log10(-1.0)
  |> should.be_error()
}

pub fn floatx_log2_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.log2(1.0)
  |> should.equal(Ok(0.0))

  floatx.log2(2.0)
  |> should.equal(Ok(1.0))

  assert Ok(result) = floatx.log2(5.0)
  result
  |> floatx.isclose(2.321928, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.log2(-1.0)
  |> should.be_error()
}

pub fn floatx_logb_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.logb(10.0, 10.0)
  |> should.equal(Ok(1.0))

  floatx.logb(10.0, 100.0)
  |> should.equal(Ok(0.5))

  floatx.logb(1.0, 0.25)
  |> should.equal(Ok(0.0))

  // Check that we get an error when the function is evaluated
  // outside its domain
  floatx.logb(1.0, 1.0)
  |> should.be_error()

  floatx.logb(10.0, 1.0)
  |> should.be_error()

  floatx.logb(-1.0, 1.0)
  |> should.be_error()
}

pub fn float_pow_test() {
  floatx.pow(2.0, 2.0)
  |> should.equal(Ok(4.0))

  floatx.pow(-5.0, 3.0)
  |> should.equal(Ok(-125.0))

  floatx.pow(10.5, 0.0)
  |> should.equal(Ok(1.0))

  floatx.pow(16.0, 0.5)
  |> should.equal(Ok(4.0))

  floatx.pow(2.0, -1.0)
  |> should.equal(Ok(0.5))

  floatx.pow(2.0, -1.0)
  |> should.equal(Ok(0.5))

  // floatx.pow(-1.0, 0.5) is equivalent to float.square_root(-1.0)
  // and should return an error as an imaginary number would otherwise
  // have to be returned
  floatx.pow(-1.0, 0.5)
  |> should.be_error()

  // Check another case with a negative base and fractional exponent
  floatx.pow(-1.5, 1.5)
  |> should.be_error()

  // floatx.pow(0.0, -1.0) is equivalent to 1. /. 0 and is expected
  // to be an error
  floatx.pow(0.0, -1.0)
  |> should.be_error()

  // Check that a negative base and exponent is fine as long as the
  // exponent is not fractional
  floatx.pow(-2.0, -1.0)
  |> should.equal(Ok(-0.5))
}

pub fn float_sqrt_test() {
  floatx.sqrt(1.0)
  |> should.equal(Ok(1.0))

  floatx.sqrt(9.0)
  |> should.equal(Ok(3.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  floatx.sqrt(-1.0)
  |> should.be_error()
}

pub fn float_cbrt_test() {
  floatx.cbrt(1.0)
  |> should.equal(Ok(1.0))

  floatx.cbrt(27.0)
  |> should.equal(Ok(3.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  floatx.cbrt(-1.0)
  |> should.be_error()
}

pub fn float_hypot_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)

  floatx.hypot(0.0, 0.0)
  |> should.equal(0.0)

  floatx.hypot(1.0, 0.0)
  |> should.equal(1.0)

  floatx.hypot(0.0, 1.0)
  |> should.equal(1.0)

  let result = floatx.hypot(11.0, 22.0)
  result
  |> floatx.isclose(24.596747, 0.0, tol)
  |> should.be_true()
}

pub fn float_sin_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.sin(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.sin(0.5 *. floatx.pi())
  |> floatx.isclose(1.0, 0.0, tol)
  |> should.be_true()

  floatx.sin(0.5)
  |> floatx.isclose(0.479425, 0.0, tol)
  |> should.be_true()
}

pub fn float_sinh_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.sinh(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.sinh(0.5)
  |> floatx.isclose(0.521095, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. floatx.sinh(1000.0) but this is a property of the
  // runtime.
}

pub fn math_tan_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.tan(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.tan(0.5)
  |> floatx.isclose(0.546302, 0.0, tol)
  |> should.be_true()
}

pub fn math_tanh_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  floatx.tanh(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.tanh(25.0)
  |> floatx.isclose(1.0, 0.0, tol)
  |> should.be_true()

  floatx.tanh(-25.0)
  |> floatx.isclose(-1.0, 0.0, tol)
  |> should.be_true()

  floatx.tanh(0.5)
  |> floatx.isclose(0.462117, 0.0, tol)
  |> should.be_true()
}

pub fn float_rad2deg_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  floatx.rad2deg(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.rad2deg(2.0 *. floatx.pi())
  |> floatx.isclose(360.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_deg2rads_test() {
  assert Ok(tol) = floatx.pow(-10.0, -6.0)
  floatx.deg2rad(0.0)
  |> floatx.isclose(0.0, 0.0, tol)
  |> should.be_true()

  floatx.deg2rad(360.0)
  |> floatx.isclose(2.0 *. floatx.pi(), 0.0, tol)
  |> should.be_true()
}

pub fn float_ceil_test() {
  floatx.ceil(0.1)
  |> should.equal(1.0)

  floatx.ceil(0.9)
  |> should.equal(1.0)
}

pub fn float_floor_test() {
  floatx.floor(0.1)
  |> should.equal(0.0)

  floatx.floor(0.9)
  |> should.equal(0.0)
}

pub fn float_min_test() {
  floatx.min(0.75, 0.5)
  |> should.equal(0.5)

  floatx.min(0.5, 0.75)
  |> should.equal(0.5)

  floatx.min(-0.75, 0.5)
  |> should.equal(-0.75)

  floatx.min(-0.75, 0.5)
  |> should.equal(-0.75)
}

pub fn float_max_test() {
  floatx.max(0.75, 0.5)
  |> should.equal(0.75)

  floatx.max(0.5, 0.75)
  |> should.equal(0.75)

  floatx.max(-0.75, 0.5)
  |> should.equal(0.5)

  floatx.max(-0.75, 0.5)
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

pub fn float_flipsign_test() {
  floatx.flipsign(100.0)
  |> should.equal(-100.0)

  floatx.flipsign(0.0)
  |> should.equal(-0.0)

  floatx.flipsign(-100.0)
  |> should.equal(100.0)
}

pub fn float_beta_test() {
  io.debug("TODO: Implement tests for 'floatx.beta'.")
}

pub fn float_erf_test() {
  io.debug("TODO: Implement tests for 'floatx.erf'.")
}

pub fn float_gamma_test() {
  io.debug("TODO: Implement tests for 'floatx.gamma'.")
}

pub fn math_round_to_nearest_test() {
  floatx.round(1.50, option.Some(0), option.Some("Nearest"))
  |> should.equal(Ok(2.0))

  floatx.round(1.75, option.Some(0), option.Some("Nearest"))
  |> should.equal(Ok(2.0))

  floatx.round(2.00, option.Some(0), option.Some("Nearest"))
  |> should.equal(Ok(2.0))

  floatx.round(3.50, option.Some(0), option.Some("Nearest"))
  |> should.equal(Ok(4.0))

  floatx.round(4.50, option.Some(0), option.Some("Nearest"))
  |> should.equal(Ok(4.0))

  floatx.round(-3.50, option.Some(0), option.Some("Nearest"))
  |> should.equal(Ok(-4.0))

  floatx.round(-4.50, option.Some(0), option.Some("Nearest"))
  |> should.equal(Ok(-4.0))
}

pub fn math_round_up_test() {
  floatx.round(0.45, option.Some(0), option.Some("Up"))
  |> should.equal(Ok(1.0))

  floatx.round(0.50, option.Some(0), option.Some("Up"))
  |> should.equal(Ok(1.0))

  floatx.round(0.45, option.Some(1), option.Some("Up"))
  |> should.equal(Ok(0.5))

  floatx.round(0.50, option.Some(1), option.Some("Up"))
  |> should.equal(Ok(0.5))

  floatx.round(0.455, option.Some(2), option.Some("Up"))
  |> should.equal(Ok(0.46))

  floatx.round(0.505, option.Some(2), option.Some("Up"))
  |> should.equal(Ok(0.51))
}

pub fn math_round_down_test() {
  floatx.round(0.45, option.Some(0), option.Some("Down"))
  |> should.equal(Ok(0.0))

  floatx.round(0.50, option.Some(0), option.Some("Down"))
  |> should.equal(Ok(0.0))

  floatx.round(0.45, option.Some(1), option.Some("Down"))
  |> should.equal(Ok(0.4))

  floatx.round(0.50, option.Some(1), option.Some("Down"))
  |> should.equal(Ok(0.50))

  floatx.round(0.4550, option.Some(2), option.Some("Down"))
  |> should.equal(Ok(0.45))

  floatx.round(0.5050, option.Some(2), option.Some("Down"))
  |> should.equal(Ok(0.50))
}

pub fn math_round_to_zero_test() {
  floatx.round(0.50, option.Some(0), option.Some("ToZero"))
  |> should.equal(Ok(0.0))

  floatx.round(0.75, option.Some(0), option.Some("ToZero"))
  |> should.equal(Ok(0.0))

  floatx.round(0.45, option.Some(1), option.Some("ToZero"))
  |> should.equal(Ok(0.4))

  floatx.round(0.57, option.Some(1), option.Some("ToZero"))
  |> should.equal(Ok(0.50))

  floatx.round(0.4575, option.Some(2), option.Some("ToZero"))
  |> should.equal(Ok(0.45))

  floatx.round(0.5075, option.Some(2), option.Some("ToZero"))
  |> should.equal(Ok(0.50))
}

pub fn math_round_ties_away_test() {
  floatx.round(-1.40, option.Some(0), option.Some("TiesAway"))
  |> should.equal(Ok(-1.0))

  floatx.round(-1.50, option.Some(0), option.Some("TiesAway"))
  |> should.equal(Ok(-2.0))

  floatx.round(-2.00, option.Some(0), option.Some("TiesAway"))
  |> should.equal(Ok(-2.0))

  floatx.round(-2.50, option.Some(0), option.Some("TiesAway"))
  |> should.equal(Ok(-3.0))

  floatx.round(1.40, option.Some(0), option.Some("TiesAway"))
  |> should.equal(Ok(1.0))

  floatx.round(1.50, option.Some(0), option.Some("TiesAway"))
  |> should.equal(Ok(2.0))

  floatx.round(2.50, option.Some(0), option.Some("TiesAway"))
  |> should.equal(Ok(3.0))
}

pub fn math_round_ties_up_test() {
  floatx.round(-1.40, option.Some(0), option.Some("TiesUp"))
  |> should.equal(Ok(-1.0))

  floatx.round(-1.50, option.Some(0), option.Some("TiesUp"))
  |> should.equal(Ok(-1.0))

  floatx.round(-2.00, option.Some(0), option.Some("TiesUp"))
  |> should.equal(Ok(-2.0))

  floatx.round(-2.50, option.Some(0), option.Some("TiesUp"))
  |> should.equal(Ok(-2.0))

  floatx.round(1.40, option.Some(0), option.Some("TiesUp"))
  |> should.equal(Ok(1.0))

  floatx.round(1.50, option.Some(0), option.Some("TiesUp"))
  |> should.equal(Ok(2.0))

  floatx.round(2.50, option.Some(0), option.Some("TiesUp"))
  |> should.equal(Ok(3.0))
}

pub fn float_gammainc_test() {
  // Invalid input gives an error
  // 1st arg is invalid
  floatx.gammainc(-1.0, 1.0)
  |> should.be_error()

  // 2nd arg is invalid
  floatx.gammainc(1.0, -1.0)
  |> should.be_error()

  // Valid input returns a result
  floatx.gammainc(1.0, 0.0)
  |> result.unwrap(-999.0)
  |> floatx.isclose(0.0, 0.0, 0.01)
  |> should.be_true()

  floatx.gammainc(1.0, 2.0)
  |> result.unwrap(-999.0)
  |> floatx.isclose(0.864664716763387308106, 0.0, 0.01)
  |> should.be_true()

  floatx.gammainc(2.0, 3.0)
  |> result.unwrap(-999.0)
  |> floatx.isclose(0.8008517265285442280826, 0.0, 0.01)
  |> should.be_true()

  floatx.gammainc(3.0, 4.0)
  |> result.unwrap(-999.0)
  |> floatx.isclose(1.523793388892911312363, 0.0, 0.01)
  |> should.be_true()
}

pub fn float_absdiff_test() {
  floatx.absdiff(0.0, 0.0)
  |> should.equal(0.0)

  floatx.absdiff(1.0, 2.0)
  |> should.equal(1.0)

  floatx.absdiff(2.0, 1.0)
  |> should.equal(1.0)

  floatx.absdiff(-1.0, 0.0)
  |> should.equal(1.0)

  floatx.absdiff(0.0, -1.0)
  |> should.equal(1.0)

  floatx.absdiff(10.0, 20.0)
  |> should.equal(10.0)

  floatx.absdiff(-10.0, -20.0)
  |> should.equal(10.0)

  floatx.absdiff(-10.5, 10.5)
  |> should.equal(21.0)
}
