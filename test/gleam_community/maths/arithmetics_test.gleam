import gleam_community/maths/arithmetics
import gleeunit/should

pub fn int_gcd_test() {
  arithmetics.gcd(1, 1)
  |> should.equal(1)

  arithmetics.gcd(100, 10)
  |> should.equal(10)

  arithmetics.gcd(10, 100)
  |> should.equal(10)

  arithmetics.gcd(100, -10)
  |> should.equal(10)

  arithmetics.gcd(-36, -17)
  |> should.equal(1)

  arithmetics.gcd(-30, -42)
  |> should.equal(6)
}

pub fn euclidian_modulo_test() {
  arithmetics.euclidian_modulo(15, 4)
  |> should.equal(3)

  arithmetics.euclidian_modulo(-3, -2)
  |> should.equal(1)

  arithmetics.euclidian_modulo(5, 0)
  |> should.equal(0)
}

pub fn int_lcm_test() {
  arithmetics.lcm(1, 1)
  |> should.equal(1)

  arithmetics.lcm(100, 10)
  |> should.equal(100)

  arithmetics.lcm(10, 100)
  |> should.equal(100)

  arithmetics.lcm(100, -10)
  |> should.equal(100)

  arithmetics.lcm(-36, -17)
  |> should.equal(612)

  arithmetics.lcm(-30, -42)
  |> should.equal(210)
}

pub fn int_proper_divisors_test() {
  arithmetics.proper_divisors(2)
  |> should.equal([1])

  arithmetics.proper_divisors(6)
  |> should.equal([1, 2, 3])

  arithmetics.proper_divisors(13)
  |> should.equal([1])

  arithmetics.proper_divisors(18)
  |> should.equal([1, 2, 3, 6, 9])
}

pub fn int_divisors_test() {
  arithmetics.divisors(2)
  |> should.equal([1, 2])

  arithmetics.divisors(6)
  |> should.equal([1, 2, 3, 6])

  arithmetics.divisors(13)
  |> should.equal([1, 13])

  arithmetics.divisors(18)
  |> should.equal([1, 2, 3, 6, 9, 18])
}

pub fn float_list_sum_test() {
  // An empty list returns 0
  []
  |> arithmetics.float_sum()
  |> should.equal(0.0)

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> arithmetics.float_sum()
  |> should.equal(6.0)

  [-2.0, 4.0, 6.0]
  |> arithmetics.float_sum()
  |> should.equal(8.0)
}

pub fn int_list_sum_test() {
  // An empty list returns 0
  []
  |> arithmetics.int_sum()
  |> should.equal(0)

  // Valid input returns a result
  [1, 2, 3]
  |> arithmetics.int_sum()
  |> should.equal(6)

  [-2, 4, 6]
  |> arithmetics.int_sum()
  |> should.equal(8)
}

pub fn float_list_product_test() {
  // An empty list returns 0
  []
  |> arithmetics.float_product()
  |> should.equal(1.0)

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> arithmetics.float_product()
  |> should.equal(6.0)

  [-2.0, 4.0, 6.0]
  |> arithmetics.float_product()
  |> should.equal(-48.0)
}

pub fn int_list_product_test() {
  // An empty list returns 0
  []
  |> arithmetics.int_product()
  |> should.equal(1)

  // Valid input returns a result
  [1, 2, 3]
  |> arithmetics.int_product()
  |> should.equal(6)

  [-2, 4, 6]
  |> arithmetics.int_product()
  |> should.equal(-48)
}

pub fn float_list_cumulative_sum_test() {
  // An empty lists returns an empty list
  []
  |> arithmetics.float_cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> arithmetics.float_cumulative_sum()
  |> should.equal([1.0, 3.0, 6.0])

  [-2.0, 4.0, 6.0]
  |> arithmetics.float_cumulative_sum()
  |> should.equal([-2.0, 2.0, 8.0])
}

pub fn int_list_cumulative_sum_test() {
  // An empty lists returns an empty list
  []
  |> arithmetics.int_cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> arithmetics.int_cumulative_sum()
  |> should.equal([1, 3, 6])

  [-2, 4, 6]
  |> arithmetics.int_cumulative_sum()
  |> should.equal([-2, 2, 8])
}

pub fn float_list_cumulative_product_test() {
  // An empty lists returns an empty list
  []
  |> arithmetics.float_cumumlative_product()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> arithmetics.float_cumumlative_product()
  |> should.equal([1.0, 2.0, 6.0])

  [-2.0, 4.0, 6.0]
  |> arithmetics.float_cumumlative_product()
  |> should.equal([-2.0, -8.0, -48.0])
}

pub fn int_list_cumulative_product_test() {
  // An empty lists returns an empty list
  []
  |> arithmetics.int_cumulative_product()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> arithmetics.int_cumulative_product()
  |> should.equal([1, 2, 6])

  [-2, 4, 6]
  |> arithmetics.int_cumulative_product()
  |> should.equal([-2, -8, -48])
}
