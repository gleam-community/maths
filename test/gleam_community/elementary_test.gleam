import gleam/float
import gleam_community/maths
import gleeunit/should

pub fn float_acos_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.acos(1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.acos(0.5)
  result
  |> maths.is_close(1.047197, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.acos(1.1)
  |> should.be_error()

  maths.acos(-1.1)
  |> should.be_error()
}

pub fn float_acosh_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.acosh(1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.acosh(0.0)
  |> should.be_error()
}

pub fn float_asin_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.asin(0.0)
  |> should.equal(Ok(0.0))

  let assert Ok(tol) = float.power(10.0, -6.0)
  let assert Ok(result) = maths.asin(0.5)
  result
  |> maths.is_close(0.523598, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.asin(1.1)
  |> should.be_error()

  maths.asin(-1.1)
  |> should.be_error()
}

pub fn float_asinh_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.asinh(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.asinh(0.5)
  |> maths.is_close(0.481211, 0.0, tol)
  |> should.be_true()
}

pub fn float_atan_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.atan(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.atan(0.5)
  |> maths.is_close(0.463647, 0.0, tol)
  |> should.be_true()
}

pub fn math_atan2_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.atan2(0.0, 0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.atan2(0.0, 1.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.0, x=0.5)
  // Should be equal to atan(y / x) for any x > 0 and any y
  let result = maths.atan(1.0 /. 0.5)
  maths.atan2(1.0, 0.5)
  |> maths.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=2.0, x=-1.5)
  // Should be equal to pi + atan(y / x) for any x < 0 and y >= 0
  let result = maths.pi() +. maths.atan(2.0 /. -1.5)
  maths.atan2(2.0, -1.5)
  |> maths.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-2.0, x=-1.5)
  // Should be equal to atan(y / x) - pi for any x < 0 and y < 0
  let result = maths.atan(-2.0 /. -1.5) -. maths.pi()
  maths.atan2(-2.0, -1.5)
  |> maths.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=1.5, x=0.0)
  // Should be equal to pi/2 for x = 0 and any y > 0
  let result = maths.pi() /. 2.0
  maths.atan2(1.5, 0.0)
  |> maths.is_close(result, 0.0, tol)
  |> should.be_true()

  // Check atan2(y=-1.5, x=0.0)
  // Should be equal to -pi/2 for x = 0 and any y < 0
  let result = -1.0 *. maths.pi() /. 2.0
  maths.atan2(-1.5, 0.0)
  |> maths.is_close(result, 0.0, tol)
  |> should.be_true()
}

pub fn float_atanh_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.atanh(0.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.atanh(0.5)
  result
  |> maths.is_close(0.549306, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.atanh(1.0)
  |> should.be_error()

  maths.atanh(2.0)
  |> should.be_error()

  maths.atanh(1.0)
  |> should.be_error()

  maths.atanh(-2.0)
  |> should.be_error()
}

pub fn float_cos_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.cos(0.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.cos(maths.pi())
  |> maths.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  maths.cos(0.5)
  |> maths.is_close(0.877582, 0.0, tol)
  |> should.be_true()
}

pub fn float_cosh_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.cosh(0.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.cosh(0.5)
  |> maths.is_close(1.127625, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. maths.cosh(1000.0) but this is a property of the
  // runtime.
}

pub fn float_sin_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.sin(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.sin(0.5 *. maths.pi())
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.sin(0.5)
  |> maths.is_close(0.479425, 0.0, tol)
  |> should.be_true()
}

pub fn float_sinh_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.sinh(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.sinh(0.5)
  |> maths.is_close(0.521095, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. maths.sinh(1000.0) but this is a property of the
  // runtime.
}

pub fn math_tan_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.tan(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.tan(0.5)
  |> maths.is_close(0.546302, 0.0, tol)
  |> should.be_true()
}

pub fn math_tanh_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.tanh(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.tanh(25.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.tanh(-25.0)
  |> maths.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  maths.tanh(0.5)
  |> maths.is_close(0.462117, 0.0, tol)
  |> should.be_true()
}

pub fn float_exponential_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.exponential(0.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.exponential(0.5)
  |> maths.is_close(1.648721, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. maths.exponential(1000.0) but this is a property of the
  // runtime.
}

pub fn float_natural_logarithm_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.natural_logarithm(1.0)
  |> should.equal(Ok(0.0))

  let assert Ok(result) = maths.natural_logarithm(0.5)
  result
  |> maths.is_close(-0.693147, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.natural_logarithm(-1.0)
  |> should.be_error()
}

pub fn float_logarithm_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.logarithm(10.0, 10.0)
  |> should.equal(Ok(1.0))

  maths.logarithm(10.0, 100.0)
  |> should.equal(Ok(0.5))

  maths.logarithm(1.0, 0.25)
  |> should.equal(Ok(0.0))

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.logarithm(1.0, 1.0)
  |> should.be_error()

  maths.logarithm(10.0, 1.0)
  |> should.be_error()

  maths.logarithm(-1.0, 1.0)
  |> should.be_error()

  maths.logarithm(1.0, 10.0)
  |> should.equal(Ok(0.0))

  maths.logarithm(maths.e(), maths.e())
  |> should.equal(Ok(1.0))

  maths.logarithm(-1.0, 2.0)
  |> should.be_error()
}

pub fn float_logarithm_2_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.logarithm_2(1.0)
  |> should.equal(Ok(0.0))

  maths.logarithm_2(2.0)
  |> should.equal(Ok(1.0))

  let assert Ok(result) = maths.logarithm_2(5.0)
  result
  |> maths.is_close(2.321928, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.logarithm_2(-1.0)
  |> should.be_error()
}

pub fn float_logarithm_10_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.logarithm_10(1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.logarithm_10(10.0)
  result
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.logarithm_10(50.0)
  result
  |> maths.is_close(1.69897, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.logarithm_10(-1.0)
  |> should.be_error()
}

pub fn float_nth_root_test() {
  maths.nth_root(9.0, 2)
  |> should.equal(Ok(3.0))

  maths.nth_root(27.0, 3)
  |> should.equal(Ok(3.0))

  maths.nth_root(1.0, 4)
  |> should.equal(Ok(1.0))

  maths.nth_root(256.0, 4)
  |> should.equal(Ok(4.0))

  // An error should be returned as an imaginary number would otherwise
  // have to be returned
  maths.nth_root(-1.0, 4)
  |> should.be_error()
}

pub fn float_constants_test() {
  let assert Ok(tolerance) = float.power(10.0, -12.0)

  // Test that the constant is approximately equal to 2.7128...
  maths.e()
  |> maths.is_close(2.7182818284590452353602, 0.0, tolerance)
  |> should.be_true()

  // Test that the constant is approximately equal to 2.7128...
  maths.pi()
  |> maths.is_close(3.14159265359, 0.0, tolerance)
  |> should.be_true()

  // Test that the constant is approximately equal to 1.6180...
  maths.golden_ratio()
  |> maths.is_close(1.618033988749895, 0.0, tolerance)
  |> should.be_true()
}
