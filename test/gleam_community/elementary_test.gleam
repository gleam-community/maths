import gleam/float
import gleam_community/maths
import gleeunit/should

pub fn acos_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.acos(1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.acos(0.5)
  result
  |> maths.is_close(1.0471975511965979, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.acos(1.1)
  |> should.be_error()

  maths.acos(-1.1)
  |> should.be_error()
}

pub fn acosh_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.acosh(1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.acosh(2.0)
  result
  |> maths.is_close(1.3169578969248166, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.acosh(0.0)
  |> should.be_error()
}

pub fn asin_test() {
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.asin(0.0)
  |> should.equal(Ok(0.0))

  let assert Ok(tol) = float.power(10.0, -9.0)
  let assert Ok(result) = maths.asin(0.5)
  result
  |> maths.is_close(0.5235987755982989, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.asin(1.1)
  |> should.be_error()

  maths.asin(-1.1)
  |> should.be_error()
}

pub fn asinh_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.asinh(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.asinh(0.5)
  |> maths.is_close(0.48121182505960347, 0.0, tol)
  |> should.be_true()

  maths.asinh(-0.5)
  |> maths.is_close(-0.48121182505960347, 0.0, tol)
  |> should.be_true()
}

pub fn atan_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.atan(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.atan(0.5)
  |> maths.is_close(0.4636476090008061, 0.0, tol)
  |> should.be_true()
}

pub fn math_atan2_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
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

pub fn atanh_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.atanh(0.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.atanh(0.5)
  result
  |> maths.is_close(0.5493061443340548, 0.0, tol)
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

pub fn cos_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.cos(0.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.cos(maths.pi())
  |> maths.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  maths.cos(0.5)
  |> maths.is_close(0.8775825618903728, 0.0, tol)
  |> should.be_true()
}

pub fn cosh_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.cosh(0.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.cosh(0.5)
  |> maths.is_close(1.1276259652063807, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. maths.cosh(1000.0) but this is a property of the
  // runtime.
}

pub fn sin_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.sin(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.sin(0.5 *. maths.pi())
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.sin(0.5)
  |> maths.is_close(0.479425538604203, 0.0, tol)
  |> should.be_true()
}

pub fn sinh_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.sinh(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.sinh(0.5)
  |> maths.is_close(0.5210953054937474, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. maths.sinh(1000.0) but this is a property of the
  // runtime.
}

pub fn math_tan_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(tan_zero) = maths.tan(0.0)
  tan_zero
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(tan_half) = maths.tan(0.5)
  tan_half
  |> maths.is_close(0.5463024898437905, 0.0, tol)
  |> should.be_true()

  let assert Ok(tan_pi_quarter) = maths.tan(maths.pi() /. 4.0)
  tan_pi_quarter
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(tan_negative_pi_quarter) = maths.tan(-1.0 *. maths.pi() /. 4.0)
  tan_negative_pi_quarter
  |> maths.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  // Test periodicity: tan(x) = tan(x + π)
  let assert Ok(tan_periodic) = maths.tan(0.5 +. maths.pi())
  tan_periodic
  |> maths.is_close(tan_half, 0.0, tol)
  |> should.be_true()

  // Test symmetry: tan(-x) = -tan(x)
  let assert Ok(tan_negative) = maths.tan(-0.75)
  let assert Ok(tan_positive) = maths.tan(0.75)
  tan_negative
  |> maths.is_close(-1.0 *. tan_positive, 0.0, tol)
  |> should.be_true()

  // Exact poles return Error(Nil); nearby values remain finite and are
  // checked below.
  maths.tan(maths.pi() /. 2.0)
  |> should.be_error()

  maths.tan(-1.0 *. maths.pi() /. 2.0)
  |> should.be_error()

  // Near asymptote: pi/2 from below so the result
  // should be large positive number
  let assert Ok(large_number) = float.power(10.0, 6.0)
  let assert Ok(small_number) = float.power(10.0, -6.0)
  let assert Ok(tan_near_left) =
    maths.tan(maths.pi() /. 2.0 -. 1.0 *. small_number)
  let result = tan_near_left >. large_number
  should.be_true(result)

  // Near asymptote: pi/2 from above so the result
  // should be a large negative number
  let assert Ok(tan_near_right) =
    maths.tan(maths.pi() /. 2.0 +. 1.0 *. small_number)
  let result = tan_near_right <. -1.0 *. large_number
  should.be_true(result)
}

pub fn math_tanh_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
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
  |> maths.is_close(0.46211715726000974, 0.0, tol)
  |> should.be_true()
}

pub fn exponential_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  maths.exponential(0.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.exponential(0.5)
  |> maths.is_close(1.6487212707001282, 0.0, tol)
  |> should.be_true()
  // An (overflow) error might occur when given an input
  // value that will result in a too large output value
  // e.g. maths.exponential(1000.0) but this is a property of the
  // runtime.
}

pub fn natural_logarithm_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.natural_logarithm(1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.natural_logarithm(0.5)
  result
  |> maths.is_close(-0.6931471805599453, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.natural_logarithm(0.0)
  |> should.be_error()

  maths.natural_logarithm(-1.0)
  |> should.be_error()
}

pub fn logarithm_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.logarithm(10.0, 10.0)
  result
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.logarithm(10.0, 100.0)
  result
  |> maths.is_close(0.5, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.logarithm(1.0, 0.25)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()
  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.logarithm(0.0, 10.0)
  |> should.be_error()

  maths.logarithm(10.0, 0.0)
  |> should.be_error()

  maths.logarithm(1.0, 1.0)
  |> should.be_error()

  maths.logarithm(10.0, 1.0)
  |> should.be_error()

  maths.logarithm(-1.0, 1.0)
  |> should.be_error()

  let assert Ok(result) = maths.logarithm(1.0, 10.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.logarithm(maths.e(), maths.e())
  result
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  maths.logarithm(-1.0, 2.0)
  |> should.be_error()
}

pub fn logarithm_2_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) = maths.logarithm_2(1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.logarithm_2(2.0)
  result
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) = maths.logarithm_2(5.0)
  result
  |> maths.is_close(2.321928094887362, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.logarithm_2(0.0)
  |> should.be_error()

  maths.logarithm_2(-1.0)
  |> should.be_error()
}

pub fn logarithm_10_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)
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
  |> maths.is_close(1.6989700043360187, 0.0, tol)
  |> should.be_true()

  // Check that we get an error when the function is evaluated
  // outside its domain
  maths.logarithm_10(0.0)
  |> should.be_error()

  maths.logarithm_10(-1.0)
  |> should.be_error()
}

pub fn nth_root_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  maths.nth_root(9.0, 2)
  |> should.equal(Ok(3.0))

  maths.nth_root(27.0, 3)
  |> should.equal(Ok(3.0))

  maths.nth_root(1.0, 4)
  |> should.equal(Ok(1.0))

  maths.nth_root(256.0, 4)
  |> should.equal(Ok(4.0))

  // Negative input values have real roots for odd root degrees
  let assert Ok(result) = maths.nth_root(-27.0, 3)
  result
  |> maths.is_close(-3.0, 0.0, tol)
  |> should.be_true()

  // Negative input values have no real root for even root degrees
  maths.nth_root(-1.0, 4)
  |> should.be_error()

  maths.nth_root(4.0, 0)
  |> should.be_error()

  maths.nth_root(4.0, -2)
  |> should.be_error()
}

pub fn constants_test() {
  let assert Ok(tolerance) = float.power(10.0, -12.0)

  // Test that the constant is approximately equal to 2.71828...
  maths.e()
  |> maths.is_close(2.7182818284590452353602, 0.0, tolerance)
  |> should.be_true()

  // Test that the constant is approximately equal to 3.14159...
  maths.pi()
  |> maths.is_close(3.141592653589793, 0.0, tolerance)
  |> should.be_true()

  // Test that tau is equal to 2π.
  maths.tau()
  |> maths.is_close(2.0 *. maths.pi(), 0.0, tolerance)
  |> should.be_true()

  // Test that the constant is approximately equal to 1.6180...
  maths.golden_ratio()
  |> maths.is_close(1.618033988749895, 0.0, tolerance)
  |> should.be_true()
}
