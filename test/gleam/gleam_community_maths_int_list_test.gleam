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
