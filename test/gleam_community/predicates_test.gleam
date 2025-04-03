import gleam/function
import gleam/list
import gleam_community/maths
import gleeunit/should

pub fn float_is_close_test() {
  let val = 99.0
  let ref_val = 100.0
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol = 0.01
  let atol = 0.1
  maths.is_close(val, ref_val, rtol, atol)
  |> should.be_true()
}

pub fn float_list_all_close_test() {
  let val = 99.0
  let ref_val = 100.0
  let xarr = list.repeat(val, 42)
  let yarr = list.repeat(ref_val, 42)
  let arr = list.zip(xarr, yarr)
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol = 0.01
  let atol = 0.1
  maths.all_close(arr, rtol, atol)
  |> list.all(function.identity)
  |> should.equal(True)
}

pub fn float_is_fractional_test() {
  maths.is_fractional(1.5)
  |> should.equal(True)
  maths.is_fractional(0.5)
  |> should.equal(True)
  maths.is_fractional(0.3333)
  |> should.equal(True)
  maths.is_fractional(0.9999)
  |> should.equal(True)
  maths.is_fractional(1.0)
  |> should.equal(False)
  maths.is_fractional(999.0)
  |> should.equal(False)
}

pub fn int_is_power_test() {
  maths.is_power(10, 10)
  |> should.equal(True)
  maths.is_power(11, 10)
  |> should.equal(False)
  maths.is_power(4, 2)
  |> should.equal(True)
  maths.is_power(5, 2)
  |> should.equal(False)
  maths.is_power(27, 3)
  |> should.equal(True)
  maths.is_power(28, 3)
  |> should.equal(False)
  maths.is_power(-1, 10)
  |> should.equal(False)
  maths.is_power(1, -10)
  |> should.equal(False)
}

pub fn int_is_perfect_test() {
  maths.is_perfect(6)
  |> should.equal(True)
  maths.is_perfect(28)
  |> should.equal(True)
  maths.is_perfect(496)
  |> should.equal(True)
  maths.is_perfect(1)
  |> should.equal(False)
  maths.is_perfect(3)
  |> should.equal(False)
  maths.is_perfect(13)
  |> should.equal(False)
}

pub fn int_is_prime_test() {
  // Test a negative integer, i.e., not a natural number
  maths.is_prime(-7)
  |> should.equal(False)
  maths.is_prime(1)
  |> should.equal(False)
  maths.is_prime(2)
  |> should.equal(True)
  maths.is_prime(3)
  |> should.equal(True)
  maths.is_prime(5)
  |> should.equal(True)
  maths.is_prime(7)
  |> should.equal(True)
  maths.is_prime(11)
  |> should.equal(True)
  maths.is_prime(42)
  |> should.equal(False)
  maths.is_prime(7919)
  |> should.equal(True)
  // Test 1st Carmichael number
  maths.is_prime(561)
  |> should.equal(False)
  // Test 2nd Carmichael number
  maths.is_prime(1105)
  |> should.equal(False)
}

pub fn is_between_test() {
  maths.is_between(5.5, 5.0, 6.0)
  |> should.equal(True)
  maths.is_between(5.0, 5.0, 6.0)
  |> should.equal(False)
  maths.is_between(6.0, 5.0, 6.0)
  |> should.equal(False)
}

pub fn is_divisible_test() {
  maths.is_divisible(10, 2)
  |> should.equal(True)
  maths.is_divisible(7, 3)
  |> should.equal(False)
}

pub fn is_multiple_test() {
  maths.is_multiple(15, 5)
  |> should.equal(True)
  maths.is_multiple(14, 5)
  |> should.equal(False)
}
