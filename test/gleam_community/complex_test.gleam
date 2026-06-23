import gleam/float
import gleam/function
import gleam/list
import gleam/order.{Eq, Gt, Lt}
import gleam_community/complex.{Complex}
import gleam_community/maths
import gleeunit/should

pub fn is_close_relative_positive_test() {
  complex.is_close(Complex(0.0, 0.9), Complex(0.0, 1.0), 0.1, 0.0)
  |> should.be_true
}

pub fn is_close_relative_negative_test() {
  complex.is_close(Complex(0.0, 0.9), Complex(0.0, 1.0), 0.09, 0.0)
  |> should.be_false
}

pub fn is_close_absolute_positive_test() {
  complex.is_close(Complex(0.0, 0.9), Complex(0.0, 1.0), 0.0, 0.1)
  |> should.be_true
}

pub fn is_close_absolute_negative_test() {
  complex.is_close(Complex(0.0, 0.9), Complex(0.0, 1.0), 0.0, 0.09)
  |> should.be_false
}

pub fn is_close_negative_relative_tolerance_test() {
  complex.is_close(Complex(1.0, 1.0), Complex(1.0, 1.0), -0.01, 0.0)
  |> should.be_false
}

pub fn is_close_negative_absolute_tolerance_test() {
  complex.is_close(Complex(1.0, 1.0), Complex(1.0, 1.0), 0.0, -0.01)
  |> should.be_false
}

pub fn add_test() {
  complex.add(Complex(1.0, 2.0), Complex(3.0, 4.0))
  |> should.equal(Complex(4.0, 6.0))
}

pub fn multiply_test() {
  complex.multiply(Complex(1.0, 2.0), Complex(3.0, 4.0))
  |> should.equal(Complex(-5.0, 10.0))
}

pub fn subtract_test() {
  complex.subtract(Complex(1.0, 2.0), Complex(3.0, 4.0))
  |> should.equal(Complex(-2.0, -2.0))
}

pub fn divide_test() {
  complex.divide(Complex(1.0, 2.0), Complex(3.0, 4.0))
  |> complex.is_close(Complex(0.44, 0.08), 0.0, 0.01)
  |> should.be_true
}

pub fn divide_by_one_test() {
  complex.divide(Complex(1.0, 2.0), Complex(1.0, 0.0))
  |> should.equal(Complex(1.0, 2.0))
}

pub fn divide_by_zero_test() {
  // Plain complex division follows the library convention: division by zero
  // returns zero rather than an error.
  complex.divide(Complex(1.0, 2.0), Complex(0.0, 0.0))
  |> should.equal(Complex(0.0, 0.0))
}

pub fn absolute_value_test() {
  complex.absolute_value(Complex(-4.0, 6.0))
  |> float.loosely_equals(7.21, 0.05)
  |> should.be_true
}

pub fn absolute_value_zero_test() {
  complex.absolute_value(Complex(0.0, 0.0))
  |> should.equal(0.0)
}

pub fn argument_origin_test() {
  complex.argument(Complex(0.0, 0.0))
  |> should.equal(0.0)
}

pub fn argument_real_positive_test() {
  complex.argument(Complex(1.0, 0.0))
  |> float.loosely_equals(0.0, 0.01)
  |> should.be_true
}

pub fn argument_real_negative_test() {
  complex.argument(Complex(-1.0, 0.0))
  |> float.loosely_equals(maths.pi(), 0.01)
  |> should.be_true
}

pub fn argument_imaginary_positive_test() {
  complex.argument(Complex(0.0, 1.0))
  |> float.loosely_equals(maths.pi() *. 0.5, 0.01)
  |> should.be_true
}

pub fn argument_imaginary_negative_test() {
  complex.argument(Complex(0.0, -1.0))
  |> float.loosely_equals(maths.pi() *. -0.5, 0.01)
  |> should.be_true
}

pub fn argument_1st_quadrant_test() {
  complex.argument(Complex(1.0, 1.0))
  |> float.loosely_equals(maths.pi() *. 0.25, 0.01)
  |> should.be_true
}

pub fn argument_2nd_quadrant_test() {
  complex.argument(Complex(-1.0, 1.0))
  |> float.loosely_equals(maths.pi() *. 0.75, 0.01)
  |> should.be_true
}

pub fn argument_3rd_quadrant_test() {
  complex.argument(Complex(-1.0, -1.0))
  |> float.loosely_equals(maths.pi() *. -0.75, 0.01)
  |> should.be_true
}

pub fn argument_4th_quadrant_test() {
  complex.argument(Complex(1.0, -1.0))
  |> float.loosely_equals(maths.pi() *. -0.25, 0.01)
  |> should.be_true
}

pub fn from_float_test() {
  complex.from_float(69.42)
  |> complex.is_close(Complex(69.42, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn from_polar_test() {
  complex.from_polar(50.0, 4.0)
  |> complex.is_close(Complex(-32.68, -37.84), 0.0, 0.01)
  |> should.be_true
}

pub fn from_polar_zero_radius_test() {
  complex.from_polar(0.0, 4.0)
  |> should.equal(Complex(0.0, 0.0))
}

pub fn to_polar_origin_test() {
  complex.to_polar(Complex(0.0, 0.0))
  |> should.equal(#(0.0, 0.0))
}

pub fn to_polar_default_test() {
  let #(r, phi) = complex.to_polar(Complex(123.0, -321.0))

  r
  |> float.loosely_equals(343.76, 0.01)
  |> should.be_true

  phi
  |> float.loosely_equals(-1.2, 0.01)
  |> should.be_true
}

pub fn exponential_test() {
  complex.exponential(Complex(-0.1, 10.0))
  |> complex.is_close(Complex(-0.759, -0.492), 0.0, 0.01)
  |> should.be_true
}

pub fn exponential_zero_test() {
  complex.exponential(Complex(0.0, 0.0))
  |> should.equal(Complex(1.0, 0.0))
}

pub fn reciprocal_test() {
  complex.reciprocal(Complex(0.19, -0.7))
  |> complex.is_close(Complex(0.361, 1.33), 0.0, 0.1)
  |> should.be_true
}

pub fn reciprocal_one_test() {
  complex.reciprocal(Complex(1.0, 0.0))
  |> should.equal(Complex(1.0, 0.0))
}

pub fn reciprocal_zero_test() {
  // Reciprocals use the same plain-value division convention as divide/2.
  complex.reciprocal(Complex(0.0, 0.0))
  |> should.equal(Complex(0.0, 0.0))
}

pub fn power_with_real_exponent_undefined_test() {
  // Zero to the zeroth power is undefined for Result-returning powers.
  complex.power_with_real_exponent(Complex(0.0, 0.0), 0.0)
  |> should.be_error
}

pub fn power_with_real_exponent_of_zero_test() {
  // Zero to a positive real exponent returns zero.
  complex.power_with_real_exponent(Complex(0.0, 0.0), 4.0)
  |> should.be_ok
  |> should.equal(Complex(0.0, 0.0))
}

pub fn power_with_real_exponent_zero_to_positive_fractional_test() {
  // Positive fractional real exponents follow the same zero-base convention.
  complex.power_with_real_exponent(Complex(0.0, 0.0), 0.5)
  |> should.be_ok
  |> should.equal(Complex(0.0, 0.0))
}

pub fn power_with_real_exponent_to_the_zeroth_test() {
  complex.power_with_real_exponent(Complex(42.0, 42.0), 0.0)
  |> should.be_ok
  |> should.equal(Complex(1.0, 0.0))
}

pub fn power_with_real_exponent_zero_to_negative_test() {
  // Zero to a negative exponent would require a reciprocal of zero.
  complex.power_with_real_exponent(Complex(0.0, 0.0), -1.0)
  |> should.be_error
}

pub fn power_with_real_exponent_to_a_negative_test() {
  complex.power_with_real_exponent(Complex(1.0, 1.0), -1.0)
  |> should.be_ok
  |> complex.is_close(Complex(0.5, -0.5), 0.0, 0.01)
  |> should.be_true
}

pub fn power_with_real_exponent_to_fractional_real_test() {
  complex.power_with_real_exponent(Complex(4.0, 0.0), 0.5)
  |> should.be_ok
  |> complex.is_close(Complex(2.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn power_with_real_exponent_to_fractional_real_principal_value_test() {
  complex.power_with_real_exponent(Complex(-1.0, 0.0), 0.5)
  |> should.be_ok
  |> complex.is_close(Complex(0.0, 1.0), 0.0, 0.01)
  |> should.be_true
}

pub fn power_to_complex_exponent_test() {
  complex.power(Complex(1.0, 1.0), Complex(0.5, -0.25))
  |> should.be_ok
  |> complex.is_close(
    Complex(1.3799555962546408, 0.4360437919248824),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn power_to_zero_complex_exponent_test() {
  complex.power(Complex(42.0, 42.0), Complex(0.0, 0.0))
  |> should.be_ok
  |> should.equal(Complex(1.0, 0.0))
}

pub fn power_zero_to_complex_exponent_test() {
  // A zero base only succeeds when the complex exponent is positive and real.
  complex.power(Complex(0.0, 0.0), Complex(1.0, 0.0))
  |> should.be_ok
  |> should.equal(Complex(0.0, 0.0))
}

pub fn power_zero_to_zero_complex_exponent_test() {
  // Zero to the zeroth power is undefined for complex exponents too.
  complex.power(Complex(0.0, 0.0), Complex(0.0, 0.0))
  |> should.be_error
}

pub fn power_zero_to_negative_complex_exponent_test() {
  // Negative real exponents are undefined for a zero base.
  complex.power(Complex(0.0, 0.0), Complex(-1.0, 0.0))
  |> should.be_error
}

pub fn power_zero_to_non_real_complex_exponent_test() {
  // Non-real exponents would require evaluating the logarithm of zero.
  complex.power(Complex(0.0, 0.0), Complex(1.0, 1.0))
  |> should.be_error
}

pub fn power_with_real_exponent_default_test() {
  complex.power_with_real_exponent(Complex(-1.5, 1.2), 10.0)
  |> should.be_ok
  |> complex.is_close(Complex(611.72, -306.3), 0.0, 0.1)
  |> should.be_true
}

pub fn nth_root_zeroth_test() {
  complex.nth_root(Complex(13.4, -16.4), 0)
  |> should.be_error
}

pub fn nth_root_default_positive_test() {
  let roots =
    complex.nth_root(Complex(13.4, -16.4), 5)
    |> should.be_ok

  roots
  |> list.length
  |> should.equal(5)

  roots
  |> list.zip([
    Complex(1.81, -0.32),
    Complex(0.868, 1.62),
    Complex(-1.275, 1.328),
    Complex(-1.657, -0.8),
    Complex(0.25, -1.82),
  ])
  |> list.all(fn(tuple) {
    let #(actual, expected) = tuple
    complex.is_close(actual, expected, 0.0, 0.01)
  })
  |> should.be_true
}

pub fn nth_root_negative_test() {
  complex.nth_root(Complex(13.4, -16.4), -3)
  |> should.be_error
}

pub fn nth_root_zero_to_negative_test() {
  complex.nth_root(Complex(0.0, 0.0), -3)
  |> should.be_error
}

pub fn nth_root_zero_to_positive_test() {
  // All roots of zero collapse to the single zero root.
  complex.nth_root(Complex(0.0, 0.0), 3)
  |> should.be_ok
  |> should.equal([Complex(0.0, 0.0)])
}

pub fn nth_root_first_test() {
  complex.nth_root(Complex(1.0, 2.0), 1)
  |> should.be_ok
  |> list.first
  |> should.be_ok
  |> complex.is_close(Complex(1.0, 2.0), 0.0, 0.01)
  |> should.be_true
}

pub fn zero_test() {
  complex.zero()
  |> should.equal(Complex(0.0, 0.0))
}

pub fn one_test() {
  complex.one()
  |> should.equal(Complex(1.0, 0.0))
}

pub fn imaginary_unit_test() {
  complex.imaginary_unit()
  |> should.equal(Complex(0.0, 1.0))
}

pub fn sum_default_test() {
  complex.sum([
    Complex(1.0, 2.0),
    Complex(-1.0, -1.0),
    Complex(5.0, 4.0),
    Complex(-5.0, -6.0),
  ])
  |> complex.is_close(Complex(0.0, -1.0), 0.0, 0.01)
  |> should.be_true
}

pub fn sum_empty_test() {
  complex.sum([])
  |> should.equal(Complex(0.0, 0.0))
}

pub fn product_default_test() {
  complex.product([
    Complex(1.0, 2.0),
    Complex(-1.0, -1.0),
    Complex(5.0, 4.0),
    Complex(-5.0, -6.0),
  ])
  |> complex.is_close(Complex(-151.0, -47.0), 0.0, 0.1)
  |> should.be_true
}

pub fn product_empty_test() {
  complex.product([])
  |> should.equal(Complex(1.0, 0.0))
}

pub fn cumulative_sum_default_test() {
  complex.cumulative_sum([
    Complex(1.0, 2.0),
    Complex(-1.0, -1.0),
    Complex(5.0, 4.0),
    Complex(-5.0, -6.0),
  ])
  |> should.equal([
    Complex(1.0, 2.0),
    Complex(0.0, 1.0),
    Complex(5.0, 5.0),
    Complex(0.0, -1.0),
  ])
}

pub fn cumulative_sum_empty_test() {
  complex.cumulative_sum([])
  |> should.equal([])
}

pub fn cumulative_product_default_test() {
  complex.cumulative_product([
    Complex(1.0, 2.0),
    Complex(-1.0, -1.0),
    Complex(5.0, 4.0),
    Complex(-5.0, -6.0),
  ])
  |> should.equal([
    Complex(1.0, 2.0),
    Complex(1.0, -3.0),
    Complex(17.0, -11.0),
    Complex(-151.0, -47.0),
  ])
}

pub fn cumulative_product_empty_test() {
  complex.cumulative_product([])
  |> should.equal([])
}

pub fn absolute_difference_test() {
  complex.absolute_difference(Complex(1.0, 1.0), Complex(4.0, 5.0))
  |> should.equal(5.0)
}

pub fn mean_empty_test() {
  complex.mean([])
  |> should.be_error
}

pub fn mean_with_one_element_test() {
  complex.mean([Complex(42.0, 1337.0)])
  |> should.be_ok
  |> should.equal(Complex(42.0, 1337.0))
}

pub fn mean_default_test() {
  complex.mean([
    Complex(1.0, 1.0),
    Complex(3.0, 5.0),
    Complex(-2.0, -3.0),
    Complex(-3.0, -2.0),
  ])
  |> should.be_ok
  |> should.equal(Complex(-0.25, 0.25))
}

pub fn all_close_absolute_positive_test() {
  complex.all_close(
    [
      #(Complex(1.0, 1.0), Complex(1.1, 1.1)),
      #(Complex(-4.0, -5.0), Complex(-4.0, -4.9)),
      #(Complex(-3.0, 2.0), Complex(-2.9, 2.1)),
    ],
    0.0,
    0.2,
  )
  |> list.all(function.identity)
  |> should.be_true
}

pub fn all_close_absolute_negative_test() {
  complex.all_close(
    [
      #(Complex(1.0, 1.0), Complex(1.1, 1.1)),
      #(Complex(-4.0, -5.0), Complex(-4.0, -4.7)),
      #(Complex(-3.0, 2.0), Complex(-2.9, 2.1)),
    ],
    0.0,
    0.2,
  )
  |> list.all(function.identity)
  |> should.be_false
}

pub fn all_close_relative_positive_test() {
  complex.all_close(
    [
      #(Complex(1.0, 1.0), Complex(1.1, 1.1)),
      #(Complex(-4.0, -5.0), Complex(-4.0, -4.9)),
      #(Complex(-3.0, 2.0), Complex(-2.9, 2.1)),
    ],
    0.1,
    0.0,
  )
  |> list.all(function.identity)
  |> should.be_true
}

pub fn all_close_relative_negative_test() {
  complex.all_close(
    [
      #(Complex(1.0, 1.0), Complex(1.1, 1.1)),
      #(Complex(-4.0, -5.0), Complex(-4.0, -4.7)),
      #(Complex(-3.0, 2.0), Complex(-2.9, 2.1)),
    ],
    0.05,
    0.0,
  )
  |> list.all(function.identity)
  |> should.be_false
}

pub fn all_close_empty_test() {
  complex.all_close([], 0.0, 0.0)
  |> should.equal([])
}

pub fn all_close_negative_tolerance_test() {
  // Negative tolerances are invalid and make the comparison fail.
  complex.all_close([#(Complex(1.0, 1.0), Complex(1.0, 1.0))], -0.01, 0.0)
  |> should.equal([False])
}

pub fn natural_logarithm_zero_test() {
  complex.natural_logarithm(Complex(0.0, 0.0))
  |> should.be_error
}

pub fn natural_logarithm_default_test() {
  complex.natural_logarithm(Complex(1.0, 1.0))
  |> should.be_ok
  |> complex.is_close(
    Complex(0.34657359027997264, 0.7853981633974483),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn natural_logarithm_negative_real_principal_value_test() {
  complex.natural_logarithm(Complex(-1.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(0.0, maths.pi()), 0.0, 0.01)
  |> should.be_true
}

pub fn logarithm_zero_input_test() {
  complex.logarithm(Complex(0.0, 0.0), Complex(2.0, 0.0))
  |> should.be_error
}

pub fn logarithm_zero_base_test() {
  complex.logarithm(Complex(2.0, 0.0), Complex(0.0, 0.0))
  |> should.be_error
}

pub fn logarithm_default_test() {
  complex.logarithm(Complex(8.0, 0.0), Complex(2.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(3.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn logarithm_undefined_base_test() {
  complex.logarithm(Complex(1.0, 0.0), Complex(1.0, 0.0))
  |> should.be_error
}

pub fn logarithm_10_default_test() {
  complex.logarithm_10(Complex(100.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(2.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn logarithm_10_zero_test() {
  complex.logarithm_10(Complex(0.0, 0.0))
  |> should.be_error
}

pub fn square_root_zero_test() {
  complex.square_root(Complex(0.0, 0.0))
  |> should.equal(Complex(0.0, 0.0))
}

pub fn square_root_default_test() {
  complex.square_root(Complex(-1.0, 0.0))
  |> complex.is_close(Complex(0.0, 1.0), 0.0, 0.01)
  |> should.be_true
}

pub fn square_root_positive_real_test() {
  complex.square_root(Complex(4.0, 0.0))
  |> complex.is_close(Complex(2.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn sin_zero_test() {
  complex.sin(Complex(0.0, 0.0))
  |> should.equal(Complex(0.0, 0.0))
}

pub fn sin_default_test() {
  complex.sin(Complex(1.0, 2.0))
  |> complex.is_close(Complex(3.165778513216168, 1.9596010414216063), 0.0, 0.01)
  |> should.be_true
}

pub fn cos_zero_test() {
  complex.cos(Complex(0.0, 0.0))
  |> should.equal(Complex(1.0, 0.0))
}

pub fn cos_default_test() {
  complex.cos(Complex(1.0, 2.0))
  |> complex.is_close(Complex(2.0327230070196656, -3.0518977991518), 0.0, 0.01)
  |> should.be_true
}

pub fn tan_zero_test() {
  complex.tan(Complex(0.0, 0.0))
  |> should.be_ok
  |> should.equal(Complex(0.0, 0.0))
}

pub fn tan_singularity_test() {
  // Lock in exact pole detection at pi / 2, not tolerance-based near-pole
  // behavior.
  complex.tan(Complex(maths.pi() /. 2.0, 0.0))
  |> should.be_error
}

pub fn tan_default_test() {
  complex.tan(Complex(1.0, 2.0))
  |> should.be_ok
  |> complex.is_close(
    Complex(0.0338128260798967, 1.0147936161466335),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn asin_zero_test() {
  complex.asin(Complex(0.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(0.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn asin_default_test() {
  complex.asin(Complex(1.0, 2.0))
  |> should.be_ok
  |> complex.is_close(
    Complex(0.4270785863924761, 1.5285709194809982),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn acos_one_test() {
  complex.acos(Complex(1.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(0.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn acos_default_test() {
  complex.acos(Complex(1.0, 2.0))
  |> should.be_ok
  |> complex.is_close(
    Complex(1.1437177404024204, -1.5285709194809982),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn atan_zero_test() {
  complex.atan(Complex(0.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(0.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn atan_singularity_test() {
  complex.atan(Complex(0.0, 1.0))
  |> should.be_error
}

pub fn atan_default_test() {
  complex.atan(Complex(0.5, 0.25))
  |> should.be_ok
  |> complex.is_close(
    Complex(0.4842544903299662, 0.20058661813123432),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn sinh_zero_test() {
  complex.sinh(Complex(0.0, 0.0))
  |> should.equal(Complex(0.0, 0.0))
}

pub fn sinh_default_test() {
  complex.sinh(Complex(1.0, 2.0))
  |> complex.is_close(
    Complex(-0.4890562590412937, 1.4031192506220405),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn cosh_zero_test() {
  complex.cosh(Complex(0.0, 0.0))
  |> should.equal(Complex(1.0, 0.0))
}

pub fn cosh_default_test() {
  complex.cosh(Complex(1.0, 2.0))
  |> complex.is_close(Complex(-0.64214812471552, 1.0686074213827783), 0.0, 0.01)
  |> should.be_true
}

pub fn tanh_zero_test() {
  complex.tanh(Complex(0.0, 0.0))
  |> should.be_ok
  |> should.equal(Complex(0.0, 0.0))
}

pub fn tanh_singularity_test() {
  // Lock in exact pole detection at i*pi/2 for the hyperbolic tangent.
  complex.tanh(Complex(0.0, maths.pi() /. 2.0))
  |> should.be_error
}

pub fn tanh_default_test() {
  complex.tanh(Complex(1.0, 2.0))
  |> should.be_ok
  |> complex.is_close(
    Complex(1.16673625724092, -0.24345820118572534),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn asinh_zero_test() {
  complex.asinh(Complex(0.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(0.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn asinh_default_test() {
  complex.asinh(Complex(1.0, 2.0))
  |> should.be_ok
  |> complex.is_close(Complex(1.4693517443681852, 1.063440023577752), 0.0, 0.01)
  |> should.be_true
}

pub fn acosh_one_test() {
  complex.acosh(Complex(1.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(0.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn acosh_default_test() {
  complex.acosh(Complex(1.0, 2.0))
  |> should.be_ok
  |> complex.is_close(
    Complex(1.5285709194809982, 1.1437177404024204),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn atanh_zero_test() {
  complex.atanh(Complex(0.0, 0.0))
  |> should.be_ok
  |> complex.is_close(Complex(0.0, 0.0), 0.0, 0.01)
  |> should.be_true
}

pub fn atanh_one_test() {
  complex.atanh(Complex(1.0, 0.0))
  |> should.be_error
}

pub fn atanh_default_test() {
  complex.atanh(Complex(0.25, 0.5))
  |> should.be_ok
  |> complex.is_close(
    Complex(0.20058661813123432, 0.4842544903299662),
    0.0,
    0.01,
  )
  |> should.be_true
}

pub fn compare_real_eq_test() {
  complex.compare_real(Complex(5.0, 0.0), Complex(5.0, 42.0))
  |> should.equal(Eq)
}

pub fn compare_real_lt_test() {
  complex.compare_real(Complex(4.9, 0.0), Complex(5.0, 42.0))
  |> should.equal(Lt)
}

pub fn compare_real_gt_test() {
  complex.compare_real(Complex(5.1, 0.0), Complex(5.0, 42.0))
  |> should.equal(Gt)
}

pub fn compare_imaginary_eq_test() {
  complex.compare_imaginary(Complex(1.0, 42.0), Complex(5.0, 42.0))
  |> should.equal(Eq)
}

pub fn compare_imaginary_lt_test() {
  complex.compare_imaginary(Complex(1.0, 41.9), Complex(5.0, 42.0))
  |> should.equal(Lt)
}

pub fn compare_imaginary_gt_test() {
  complex.compare_imaginary(Complex(1.0, 42.1), Complex(5.0, 42.0))
  |> should.equal(Gt)
}

pub fn conjugate_test() {
  complex.conjugate(Complex(42.0, 69.0))
  |> should.equal(Complex(42.0, -69.0))
}

pub fn to_string_only_real_test() {
  complex.to_string(Complex(-42.0, 0.0))
  |> should.equal("-42.0")
}

pub fn to_string_positive_imaginary_test() {
  complex.to_string(Complex(4.0, 5.6))
  |> should.equal("4.0 + 5.6i")
}

pub fn to_string_negative_imaginary_test() {
  complex.to_string(Complex(0.0, -4.2))
  |> should.equal("0.0 - 4.2i")
}
