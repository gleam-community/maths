import gleam_community/maths/combinatorics
import gleam/set
import gleam/list
import gleeunit/should

pub fn int_factorial_test() {
  // Invalid input gives an error
  combinatorics.factorial(-1)
  |> should.be_error()

  // Valid input returns a result
  combinatorics.factorial(0)
  |> should.equal(Ok(1))

  combinatorics.factorial(1)
  |> should.equal(Ok(1))

  combinatorics.factorial(2)
  |> should.equal(Ok(2))

  combinatorics.factorial(3)
  |> should.equal(Ok(6))

  combinatorics.factorial(4)
  |> should.equal(Ok(24))
}

pub fn int_combination_test() {
  // Invalid input gives an error
  // Error on: n = -1 < 0
  combinatorics.combination(-1, 1)
  |> should.be_error()

  // Valid input returns a result
  combinatorics.combination(4, 0)
  |> should.equal(Ok(1))

  combinatorics.combination(4, 4)
  |> should.equal(Ok(1))

  combinatorics.combination(4, 2)
  |> should.equal(Ok(6))

  combinatorics.combination(7, 5)
  |> should.equal(Ok(21))
  // NOTE: Tests with the 'combination' function that produce values that
  // exceed precision of the JavaScript 'Number' primitive will result in
  // errors
}

pub fn math_permutation_test() {
  // Invalid input gives an error
  // Error on: n = -1 < 0
  combinatorics.permutation(-1, 1)
  |> should.be_error()

  // Valid input returns a result
  combinatorics.permutation(4, 0)
  |> should.equal(Ok(1))

  combinatorics.permutation(4, 4)
  |> should.equal(Ok(1))

  combinatorics.permutation(4, 2)
  |> should.equal(Ok(12))
}

pub fn list_cartesian_product_test() {
  // An empty lists returns an empty list
  []
  |> combinatorics.cartesian_product([])
  |> should.equal([])

  // Test with some arbitrary inputs
  [1, 2, 3]
  |> combinatorics.cartesian_product([1, 2, 3])
  |> set.from_list()
  |> should.equal(
    set.from_list([
      #(1, 1),
      #(1, 2),
      #(1, 3),
      #(2, 1),
      #(2, 2),
      #(2, 3),
      #(3, 1),
      #(3, 2),
      #(3, 3),
    ]),
  )

  [1.0, 10.0]
  |> combinatorics.cartesian_product([1.0, 2.0])
  |> set.from_list()
  |> should.equal(
    set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)]),
  )
}

pub fn list_permutation_test() {
  // An empty lists returns one (empty) permutation
  []
  |> combinatorics.list_permutation()
  |> should.equal([[]])

  // Singleton returns one (singleton) permutation
  // Also works regardless of type of list elements
  ["a"]
  |> combinatorics.list_permutation()
  |> should.equal([["a"]])

  // Test with some arbitrary inputs
  [1, 2]
  |> combinatorics.list_permutation()
  |> set.from_list()
  |> should.equal(set.from_list([[1, 2], [2, 1]]))

  // Test with some arbitrary inputs
  [1, 2, 3]
  |> combinatorics.list_permutation()
  |> set.from_list()
  |> should.equal(
    set.from_list([
      [1, 2, 3],
      [2, 1, 3],
      [3, 1, 2],
      [1, 3, 2],
      [2, 3, 1],
      [3, 2, 1],
    ]),
  )

  // Repeated elements are treated as distinct for the
  // purpose of permutations, so two identical elements
  // will appear "both ways round"
  [1.0, 1.0]
  |> combinatorics.list_permutation()
  |> should.equal([[1.0, 1.0], [1.0, 1.0]])

  // This means lists with repeated elements return the
  // same number of permutations as ones without
  ["l", "e", "t", "t", "e", "r", "s"]
  |> combinatorics.list_permutation()
  |> list.length()
  |> should.equal(5040)
}

pub fn list_combination_test() {
  // A negative number returns an error
  []
  |> combinatorics.list_combination(-1)
  |> should.be_error()

  // k is larger than given input list returns an error 
  [1, 2]
  |> combinatorics.list_combination(3)
  |> should.be_error()
  // An empty lists returns an empty list
  []
  |> combinatorics.list_combination(0)
  |> should.equal(Ok([[]]))

  // Test with some arbitrary inputs
  [1, 2]
  |> combinatorics.list_combination(1)
  |> should.equal(Ok([[1], [2]]))

  // Test with some arbitrary inputs
  [1, 2]
  |> combinatorics.list_combination(2)
  |> should.equal(Ok([[1, 2]]))

  // Test with some arbitrary inputs
  let assert Ok(result) = combinatorics.list_combination([1, 2, 3, 4], 2)
  result
  |> set.from_list()
  |> should.equal(
    set.from_list([[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]),
  )

  // Test with some arbitrary inputs
  let assert Ok(result) = combinatorics.list_combination([1, 2, 3, 4], 3)
  result
  |> set.from_list()
  |> should.equal(set.from_list([[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]))
}
