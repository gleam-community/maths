import gleam_community/maths/int as intx
import gleeunit
import gleeunit/should
import gleam/result
import gleam/io

pub fn int_absdiff_test() {
  intx.absdiff(0, 0)
  |> should.equal(0)

  intx.absdiff(1, 2)
  |> should.equal(1)

  intx.absdiff(2, 1)
  |> should.equal(1)

  intx.absdiff(-1, 0)
  |> should.equal(1)

  intx.absdiff(0, -1)
  |> should.equal(1)

  intx.absdiff(10, 20)
  |> should.equal(10)

  intx.absdiff(-10, -20)
  |> should.equal(10)

  intx.absdiff(-10, 10)
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

pub fn float_min_test() {
  intx.min(75, 50)
  |> should.equal(50)

  intx.min(50, 75)
  |> should.equal(50)

  intx.min(-75, 50)
  |> should.equal(-75)

  intx.min(-75, 50)
  |> should.equal(-75)
}

pub fn float_max_test() {
  intx.max(75, 50)
  |> should.equal(75)

  intx.max(50, 75)
  |> should.equal(75)

  intx.max(-75, 50)
  |> should.equal(50)

  intx.max(-75, 50)
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

pub fn int_flipsign_test() {
  intx.flipsign(100)
  |> should.equal(-100)

  intx.flipsign(0)
  |> should.equal(-0)

  intx.flipsign(-100)
  |> should.equal(100)
}
