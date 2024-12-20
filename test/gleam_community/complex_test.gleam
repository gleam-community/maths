import gleam/float
import gleam/function
import gleam/io
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

pub fn absolute_value_test() {
  complex.absolute_value(Complex(-4.0, 6.0))
  |> float.loosely_equals(7.21, 0.05)
  |> should.be_true
}

pub fn argument_origin_test() {
  complex.argument(Complex(0.0, 0.0))
  |> should.be_error
}

pub fn argument_real_positive_test() {
  complex.argument(Complex(1.0, 0.0))
  |> should.be_ok
  |> float.loosely_equals(0.0, 0.01)
  |> should.be_true
}

pub fn argument_real_negative_test() {
  complex.argument(Complex(-1.0, 0.0))
  |> should.be_ok
  |> float.loosely_equals(maths.pi(), 0.01)
  |> should.be_true
}

pub fn argument_imaginary_positive_test() {
  complex.argument(Complex(0.0, 1.0))
  |> should.be_ok
  |> float.loosely_equals(maths.pi() *. 0.5, 0.01)
  |> should.be_true
}

pub fn argument_imaginary_negative_test() {
  complex.argument(Complex(0.0, -1.0))
  |> should.be_ok
  |> float.loosely_equals(maths.pi() *. -0.5, 0.01)
  |> should.be_true
}

pub fn argument_1st_quadrant_test() {
  complex.argument(Complex(1.0, 1.0))
  |> should.be_ok
  |> float.loosely_equals(maths.pi() *. 0.25, 0.01)
  |> should.be_true
}

pub fn argument_2nd_quadrant_test() {
  complex.argument(Complex(-1.0, 1.0))
  |> should.be_ok
  |> float.loosely_equals(maths.pi() *. 0.75, 0.01)
  |> should.be_true
}

pub fn argument_3rd_quadrant_test() {
  complex.argument(Complex(-1.0, -1.0))
  |> should.be_ok
  |> float.loosely_equals(maths.pi() *. -0.75, 0.01)
  |> should.be_true
}

pub fn argument_4th_quadrant_test() {
  complex.argument(Complex(1.0, -1.0))
  |> should.be_ok
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

pub fn to_polar_origin_test() {
  complex.to_polar(Complex(0.0, 0.0))
  |> should.be_error
}

pub fn to_polar_default_test() {
  let #(r, phi) =
    complex.to_polar(Complex(123.0, -321.0))
    |> should.be_ok

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

pub fn reciprocal_test() {
  complex.reciprocal(Complex(0.19, -0.7))
  |> complex.is_close(Complex(0.361, 1.33), 0.0, 0.1)
  |> should.be_true
}

pub fn power_undefined_test() {
  complex.power(Complex(0.0, 0.0), 0)
  |> should.be_error
}

pub fn power_of_zero_test() {
  complex.power(Complex(0.0, 0.0), 4)
  |> should.be_ok
  |> should.equal(Complex(0.0, 0.0))
}

pub fn power_to_the_zeroth_test() {
  complex.power(Complex(42.0, 42.0), 0)
  |> should.be_ok
  |> should.equal(Complex(1.0, 0.0))
}

pub fn power_to_a_negative_test() {
  complex.power(Complex(0.13, 0.65), -2)
  |> should.be_error
}

pub fn power_default_test() {
  complex.power(Complex(-1.5, 1.2), 10)
  |> should.be_ok
  |> complex.is_close(Complex(611.72, -306.3), 0.0, 0.1)
  |> should.be_true
}

pub fn nth_root_zeroth_test() {
  complex.nth_root(Complex(13.4, -16.4), 0)
  |> should.be_error
}

pub fn nth_root_default_positive_test() {
  complex.nth_root(Complex(13.4, -16.4), 5)
  |> should.be_ok
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

pub fn nth_root_default_negative_test() {
  complex.nth_root(Complex(13.4, -16.4), -3)
  |> should.be_ok
  |> list.zip([
    Complex(0.346, 0.105),
    Complex(-0.08, -0.35),
    Complex(-0.26, 0.247),
  ])
  |> list.all(fn(tuple) {
    let #(actual, expected) = tuple
    complex.is_close(actual, expected, 0.0, 0.01)
  })
  |> should.be_true
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

pub fn weighted_sum_default_test() {
  complex.weighted_sum([
    #(Complex(1.0, 2.0), 1.0),
    #(Complex(-1.0, -1.0), 2.0),
    #(Complex(5.0, 4.0), 2.0),
    #(Complex(-5.0, -6.0), 0.5),
  ])
  |> should.be_ok
  |> complex.is_close(Complex(6.5, 5.0), 0.0, 0.01)
  |> should.be_true
}

pub fn weighted_sum_empty_test() {
  complex.weighted_sum([])
  |> should.be_ok
  |> should.equal(Complex(0.0, 0.0))
}

pub fn weighted_sum_negative_weights_test() {
  complex.weighted_sum([
    #(Complex(1.0, 2.0), -1.0),
    #(Complex(-1.0, -1.0), 2.0),
    #(Complex(5.0, 4.0), 2.0),
    #(Complex(-5.0, -6.0), 0.5),
  ])
  |> should.be_error
}

pub fn weighted_product_default_test() {
  complex.weighted_product([
    #(Complex(1.0, 2.0), 1),
    #(Complex(-1.0, -1.0), 2),
    #(Complex(5.0, 4.0), 2),
    #(Complex(-5.0, -6.0), 1),
  ])
  |> should.be_ok
  |> complex.is_close(Complex(-272.0, 1406.0), 0.0, 0.01)
  |> should.be_true
}

pub fn weighted_product_empty_test() {
  complex.weighted_product([])
  |> should.be_ok
  |> should.equal(Complex(1.0, 0.0))
}

pub fn weighted_product_negative_weights_test() {
  complex.weighted_product([
    #(Complex(1.0, 2.0), -1),
    #(Complex(-1.0, -1.0), 2),
    #(Complex(5.0, 4.0), 2),
    #(Complex(-5.0, -6.0), 1),
  ])
  |> should.be_error
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

pub fn median_empty_test() {
  complex.median([])
  |> should.be_error
}

pub fn median_with_one_element_test() {
  complex.mean([Complex(42.0, 1337.0)])
  |> should.be_ok
  |> should.equal(Complex(42.0, 1337.0))
}

pub fn median_with_two_elements_test() {
  complex.median([Complex(42.0, 10.0), Complex(-42.0, 20.0)])
  |> should.be_ok
  |> should.equal(Complex(0.0, 15.0))
}

pub fn median_with_three_elements_test() {
  complex.median([Complex(42.0, 10.0), Complex(-42.0, 20.0), Complex(0.0, 0.0)])
  |> should.be_ok
  |> should.equal(Complex(-42.0, 20.0))
}

pub fn median_default_odd_test() {
  complex.median([
    Complex(1.0, 1.0),
    Complex(3.0, 5.0),
    Complex(-2.0, -3.0),
    Complex(-3.0, -2.0),
    Complex(6.0, 9.0),
    Complex(1.0, 1.0),
    Complex(3.0, 5.0),
    Complex(-2.0, -3.0),
    Complex(-3.0, -2.0),
  ])
  |> should.be_ok
  |> should.equal(Complex(6.0, 9.0))
}

pub fn median_default_even_test() {
  complex.median([
    Complex(1.0, 1.0),
    Complex(3.0, 5.0),
    Complex(-2.0, -3.0),
    Complex(-3.0, -2.0),
    Complex(1.0, 1.0),
    Complex(3.0, 5.0),
    Complex(-2.0, -3.0),
    Complex(-3.0, -2.0),
  ])
  |> should.be_ok
  |> should.equal(Complex(-1.0, -0.5))
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
  |> should.be_ok
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
  |> should.be_ok
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
  |> should.be_ok
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
  |> should.be_ok
  |> list.all(function.identity)
  |> should.be_false
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
