import gleam/int
import gleam/list
import gleam/pair
import gleam_community/maths/int_list
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn int_list_maximum_test() {
  // An empty lists returns an error
  []
  |> int_list.maximum()
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> int_list.maximum()
  |> should.equal(Ok(4))
}

pub fn int_list_minimum_test() {
  // An empty lists returns an error
  []
  |> int_list.minimum()
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> int_list.minimum()
  |> should.equal(Ok(1))
}

pub fn int_list_arg_maximum_test() {
  // An empty lists returns an error
  []
  |> int_list.arg_maximum()
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> int_list.arg_maximum()
  |> should.equal(Ok([0, 1]))
}

pub fn int_list_arg_minimum_test() {
  // An empty lists returns an error
  []
  |> int_list.arg_minimum()
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> int_list.arg_minimum()
  |> should.equal(Ok([4]))
}

pub fn int_list_extrema_test() {
  // An empty lists returns an error
  []
  |> int_list.extrema()
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> int_list.extrema()
  |> should.equal(Ok(#(1, 4)))
}

pub fn int_list_sum_test() {
  // An empty list returns 0
  []
  |> int_list.sum()
  |> should.equal(0)

  // Valid input returns a result
  [1, 2, 3]
  |> int_list.sum()
  |> should.equal(6)

  [-2, 4, 6]
  |> int_list.sum()
  |> should.equal(8)
}

pub fn int_list_cumulative_sum_test() {
  // An empty lists returns an empty list
  []
  |> int_list.cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> int_list.cumulative_sum()
  |> should.equal([1, 3, 6])

  [-2, 4, 6]
  |> int_list.cumulative_sum()
  |> should.equal([-2, 2, 8])
}

pub fn int_list_product_test() {
  // An empty list returns 0
  []
  |> int_list.product()
  |> should.equal(1)

  // Valid input returns a result
  [1, 2, 3]
  |> int_list.product()
  |> should.equal(6)

  [-2, 4, 6]
  |> int_list.product()
  |> should.equal(-48)
}

pub fn int_list_cumulative_product_test() {
  // An empty lists returns an empty list
  []
  |> int_list.cumulative_product()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> int_list.cumulative_product()
  |> should.equal([1, 2, 6])

  [-2, 4, 6]
  |> int_list.cumulative_product()
  |> should.equal([-2, -8, -48])
}

pub fn int_list_manhatten_test() {
  // Empty lists returns 0
  int_list.manhatten_distance([], [])
  |> should.equal(Ok(0))

  // Differing lengths returns error
  int_list.manhatten_distance([], [1])
  |> should.be_error()

  let assert Ok(result) = int_list.manhatten_distance([0, 0], [1, 2])
  result
  |> should.equal(3)
}
