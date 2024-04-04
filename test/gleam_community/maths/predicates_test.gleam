import gleam_community/maths/predicates
import gleam/list
import gleeunit/should

pub fn float_is_close_test() {
  let val: Float = 99.0
  let ref_val: Float = 100.0
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol: Float = 0.01
  let atol: Float = 0.1
  predicates.is_close(val, ref_val, rtol, atol)
  |> should.be_true()
}

pub fn float_list_all_close_test() {
  let val: Float = 99.0
  let ref_val: Float = 100.0
  let xarr: List(Float) = list.repeat(val, 42)
  let yarr: List(Float) = list.repeat(ref_val, 42)
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol: Float = 0.01
  let atol: Float = 0.1
  predicates.all_close(xarr, yarr, rtol, atol)
  |> fn(zarr: Result(List(Bool), String)) -> Result(Bool, Nil) {
    case zarr {
      Ok(arr) ->
        arr
        |> list.all(fn(a: Bool) -> Bool { a })
        |> Ok
      _ ->
        Nil
        |> Error
    }
  }
  |> should.equal(Ok(True))
}

pub fn float_is_fractional_test() {
  predicates.is_fractional(1.5)
  |> should.equal(True)

  predicates.is_fractional(0.5)
  |> should.equal(True)

  predicates.is_fractional(0.3333)
  |> should.equal(True)

  predicates.is_fractional(0.9999)
  |> should.equal(True)

  predicates.is_fractional(1.0)
  |> should.equal(False)

  predicates.is_fractional(999.0)
  |> should.equal(False)
}

pub fn int_is_power_test() {
  predicates.is_power(10, 10)
  |> should.equal(True)

  predicates.is_power(11, 10)
  |> should.equal(False)

  predicates.is_power(4, 2)
  |> should.equal(True)

  predicates.is_power(5, 2)
  |> should.equal(False)

  predicates.is_power(27, 3)
  |> should.equal(True)

  predicates.is_power(28, 3)
  |> should.equal(False)
}

pub fn int_is_even_test() {
  predicates.is_even(0)
  |> should.equal(True)

  predicates.is_even(2)
  |> should.equal(True)

  predicates.is_even(12)
  |> should.equal(True)

  predicates.is_even(5)
  |> should.equal(False)

  predicates.is_even(-3)
  |> should.equal(False)

  predicates.is_even(-4)
  |> should.equal(True)
}

pub fn int_is_odd_test() {
  predicates.is_odd(0)
  |> should.equal(False)

  predicates.is_odd(3)
  |> should.equal(True)

  predicates.is_odd(13)
  |> should.equal(True)

  predicates.is_odd(4)
  |> should.equal(False)

  predicates.is_odd(-3)
  |> should.equal(True)

  predicates.is_odd(-4)
  |> should.equal(False)
}

pub fn int_is_perfect_test() {
  predicates.is_perfect(6)
  |> should.equal(True)

  predicates.is_perfect(28)
  |> should.equal(True)

  predicates.is_perfect(496)
  |> should.equal(True)

  predicates.is_perfect(1)
  |> should.equal(False)

  predicates.is_perfect(3)
  |> should.equal(False)

  predicates.is_perfect(13)
  |> should.equal(False)
}

pub fn int_is_prime_test() {
  // Test a negative integer, i.e., not a natural number
  predicates.is_prime(-7)
  |> should.equal(False)

  predicates.is_prime(1)
  |> should.equal(False)

  predicates.is_prime(2)
  |> should.equal(True)

  predicates.is_prime(3)
  |> should.equal(True)

  predicates.is_prime(5)
  |> should.equal(True)

  predicates.is_prime(7)
  |> should.equal(True)

  predicates.is_prime(11)
  |> should.equal(True)

  predicates.is_prime(42)
  |> should.equal(False)

  predicates.is_prime(7919)
  |> should.equal(True)

  // Test 1st Carmichael number
  predicates.is_prime(561)
  |> should.equal(False)

  // Test 2nd Carmichael number
  predicates.is_prime(1105)
  |> should.equal(False)
}
