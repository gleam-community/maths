import gleam/float
import gleam_community/maths
import gleeunit/should

pub fn int_gcd_test() {
  maths.gcd(1, 1)
  |> should.equal(1)

  maths.gcd(100, 10)
  |> should.equal(10)

  maths.gcd(10, 100)
  |> should.equal(10)

  maths.gcd(100, -10)
  |> should.equal(10)

  maths.gcd(-36, -17)
  |> should.equal(1)

  maths.gcd(-30, -42)
  |> should.equal(6)
}

pub fn euclidean_modulo_test() {
  // Base Case: Positive x, Positive y
  // Note that the truncated, floored, and euclidean 
  // definitions should agree for this base case
  maths.euclidean_modulo(15, 4)
  |> should.equal(3)

  // Case: Positive x, Negative y
  maths.euclidean_modulo(15, -4)
  |> should.equal(3)

  // Case: Negative x, Positive y
  maths.euclidean_modulo(-15, 4)
  |> should.equal(1)

  // Case: Negative x, Negative y
  maths.euclidean_modulo(-15, -4)
  |> should.equal(1)

  // Case: Positive x, Zero y
  maths.euclidean_modulo(5, 0)
  |> should.equal(0)

  // Case: Zero x, Negative y
  maths.euclidean_modulo(0, 5)
  |> should.equal(0)
}

pub fn lcm_test() {
  maths.lcm(1, 1)
  |> should.equal(1)

  maths.lcm(100, 10)
  |> should.equal(100)

  maths.lcm(10, 100)
  |> should.equal(100)

  maths.lcm(100, -10)
  |> should.equal(100)

  maths.lcm(-36, -17)
  |> should.equal(612)

  maths.lcm(-30, -42)
  |> should.equal(210)
}

pub fn proper_divisors_test() {
  maths.proper_divisors(2)
  |> should.equal([1])

  maths.proper_divisors(6)
  |> should.equal([1, 2, 3])

  maths.proper_divisors(13)
  |> should.equal([1])

  maths.proper_divisors(18)
  |> should.equal([1, 2, 3, 6, 9])

  maths.proper_divisors(8128)
  |> should.equal([1, 2, 4, 8, 16, 32, 64, 127, 254, 508, 1016, 2032, 4064])
}

pub fn divisors_test() {
  maths.divisors(2)
  |> should.equal([1, 2])

  maths.divisors(6)
  |> should.equal([1, 2, 3, 6])

  maths.divisors(13)
  |> should.equal([1, 13])

  maths.divisors(18)
  |> should.equal([1, 2, 3, 6, 9, 18])

  maths.divisors(8128)
  |> should.equal([
    1, 2, 4, 8, 16, 32, 64, 127, 254, 508, 1016, 2032, 4064, 8128,
  ])
}

pub fn list_cumulative_sum_test() {
  // An empty lists returns an empty list
  []
  |> maths.cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.cumulative_sum()
  |> should.equal([1.0, 3.0, 6.0])

  [-2.0, 4.0, 6.0]
  |> maths.cumulative_sum()
  |> should.equal([-2.0, 2.0, 8.0])
}

pub fn int_list_cumulative_sum_test() {
  // An empty lists returns an empty list
  []
  |> maths.int_cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> maths.int_cumulative_sum()
  |> should.equal([1, 3, 6])

  [-2, 4, 6]
  |> maths.int_cumulative_sum()
  |> should.equal([-2, 2, 8])
}

pub fn list_cumulative_product_test() {
  // An empty lists returns an empty list
  []
  |> maths.cumulative_product()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.cumulative_product()
  |> should.equal([1.0, 2.0, 6.0])

  [-2.0, 4.0, 6.0]
  |> maths.cumulative_product()
  |> should.equal([-2.0, -8.0, -48.0])
}

pub fn int_list_cumulative_product_test() {
  // An empty lists returns an empty list
  []
  |> maths.int_cumulative_product()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> maths.int_cumulative_product()
  |> should.equal([1, 2, 6])

  [-2, 4, 6]
  |> maths.int_cumulative_product()
  |> should.equal([-2, -8, -48])
}

pub fn weighted_product_test() {
  []
  |> maths.weighted_product()
  |> should.equal(Ok(1.0))

  [#(1.0, 0.0), #(2.0, 0.0), #(3.0, 0.0)]
  |> maths.weighted_product()
  |> should.equal(Ok(1.0))

  [#(1.0, 1.0), #(2.0, 1.0), #(3.0, 1.0)]
  |> maths.weighted_product()
  |> should.equal(Ok(6.0))

  let assert Ok(tolerance) = float.power(10.0, -6.0)
  let assert Ok(result) =
    [#(9.0, 0.5), #(10.0, 0.5), #(10.0, 0.5)]
    |> maths.weighted_product()
  result
  |> maths.is_close(30.0, 0.0, tolerance)
  |> should.be_true()
}

pub fn weighted_sum_test() {
  []
  |> maths.weighted_sum()
  |> should.equal(Ok(0.0))

  [#(1.0, 0.0), #(2.0, 0.0), #(3.0, 0.0)]
  |> maths.weighted_sum()
  |> should.equal(Ok(0.0))

  [#(1.0, 1.0), #(2.0, 1.0), #(3.0, 1.0)]
  |> maths.weighted_sum()
  |> should.equal(Ok(6.0))

  [#(9.0, 0.5), #(10.0, 0.5), #(10.0, 0.5)]
  |> maths.weighted_sum()
  |> should.equal(Ok(14.5))
}
