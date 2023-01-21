import gleam_community/maths/int as intx
import gleeunit
import gleeunit/should
import gleam/result
import gleam/io

pub fn int_absolute_difference_test() {
  intx.absolute_difference(0, 0)
  |> should.equal(0)

  intx.absolute_difference(1, 2)
  |> should.equal(1)

  intx.absolute_difference(2, 1)
  |> should.equal(1)

  intx.absolute_difference(-1, 0)
  |> should.equal(1)

  intx.absolute_difference(0, -1)
  |> should.equal(1)

  intx.absolute_difference(10, 20)
  |> should.equal(10)

  intx.absolute_difference(-10, -20)
  |> should.equal(10)

  intx.absolute_difference(-10, 10)
  |> should.equal(20)
}

pub fn int_factorial_test() {
  // Invalid input gives an error
  intx.factorial(-1)
  |> should.be_error()

  // Valid input returns a result
  intx.factorial(0)
  |> should.equal(Ok(1))

  intx.factorial(1)
  |> should.equal(Ok(1))

  intx.factorial(2)
  |> should.equal(Ok(2))

  intx.factorial(3)
  |> should.equal(Ok(6))

  intx.factorial(4)
  |> should.equal(Ok(24))
}

pub fn int_combination_test() {
  // Invalid input gives an error
  // Error on: n = -1 < 0
  intx.combination(-1, 1)
  |> should.be_error()

  // Valid input returns a result
  intx.combination(4, 0)
  |> should.equal(Ok(1))

  intx.combination(4, 4)
  |> should.equal(Ok(1))

  intx.combination(4, 2)
  |> should.equal(Ok(6))

  intx.combination(7, 5)
  |> should.equal(Ok(21))
  // NOTE: Tests with the 'combination' function that produce values that
  // exceed precision of the JavaScript 'Number' primitive will result in
  // errors
}

pub fn math_permutation_test() {
  // Invalid input gives an error
  // Error on: n = -1 < 0
  intx.permutation(-1, 1)
  |> should.be_error()

  // Valid input returns a result
  intx.permutation(4, 0)
  |> should.equal(Ok(1))

  intx.permutation(4, 4)
  |> should.equal(Ok(1))

  intx.permutation(4, 2)
  |> should.equal(Ok(12))
}

pub fn float_minimum_test() {
  intx.minimum(75, 50)
  |> should.equal(50)

  intx.minimum(50, 75)
  |> should.equal(50)

  intx.minimum(-75, 50)
  |> should.equal(-75)

  intx.minimum(-75, 50)
  |> should.equal(-75)
}

pub fn float_maximum_test() {
  intx.maximum(75, 50)
  |> should.equal(75)

  intx.maximum(50, 75)
  |> should.equal(75)

  intx.maximum(-75, 50)
  |> should.equal(50)

  intx.maximum(-75, 50)
  |> should.equal(50)
}

pub fn int_minmax_test() {
  intx.minmax(75, 50)
  |> should.equal(#(50, 75))

  intx.minmax(50, 75)
  |> should.equal(#(50, 75))

  intx.minmax(-75, 50)
  |> should.equal(#(-75, 50))

  intx.minmax(-75, 50)
  |> should.equal(#(-75, 50))
}

pub fn int_sign_test() {
  intx.sign(100)
  |> should.equal(1)

  intx.sign(0)
  |> should.equal(0)

  intx.sign(-100)
  |> should.equal(-1)
}

pub fn int_flip_sign_test() {
  intx.flip_sign(100)
  |> should.equal(-100)

  intx.flip_sign(0)
  |> should.equal(-0)

  intx.flip_sign(-100)
  |> should.equal(100)
}

pub fn int_copy_sign_test() {
  intx.copy_sign(100, 10)
  |> should.equal(100)

  intx.copy_sign(-100, 10)
  |> should.equal(100)

  intx.copy_sign(100, -10)
  |> should.equal(-100)

  intx.copy_sign(-100, -10)
  |> should.equal(-100)
}

pub fn int_is_power_test() {
  intx.is_power(10, 10)
  |> should.equal(True)

  intx.is_power(11, 10)
  |> should.equal(False)

  intx.is_power(4, 2)
  |> should.equal(True)

  intx.is_power(5, 2)
  |> should.equal(False)
}
