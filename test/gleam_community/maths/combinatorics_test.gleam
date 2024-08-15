import gleam/iterator
import gleam/list
import gleam/option
import gleam/set
import gleam_community/maths/combinatorics
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
  combinatorics.combination(
    -1,
    1,
    option.Some(combinatorics.WithoutRepetitions),
  )
  |> should.be_error()

  // Valid input returns a result
  combinatorics.combination(4, 0, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(1))

  combinatorics.combination(4, 4, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(1))

  combinatorics.combination(4, 2, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(6))

  combinatorics.combination(7, 5, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(21))
  // NOTE: Tests with the 'combination' function that produce values that
  // exceed precision of the JavaScript 'Number' primitive will result in
  // errors
}

pub fn math_permutation_test() {
  // Invalid input gives an error
  // Error on: n = -1 < 0
  combinatorics.permutation(
    -1,
    1,
    option.Some(combinatorics.WithoutRepetitions),
  )
  |> should.be_error()

  // Valid input returns a result
  combinatorics.permutation(4, 0, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(1))

  combinatorics.permutation(4, 4, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(24))

  combinatorics.permutation(4, 2, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(12))

  combinatorics.permutation(6, 2, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(30))

  combinatorics.permutation(6, 3, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(120))
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
// pub fn list_permutation_test() {
//   // An empty lists returns one (empty) permutation
//   []
//   |> combinatorics.list_permutation()
//   |> iterator.to_list()
//   |> should.equal([[]])

//   // Singleton returns one (singleton) permutation
//   // Also works regardless of type of list elements
//   ["a"]
//   |> combinatorics.list_permutation()
//   |> iterator.to_list()
//   |> should.equal([["a"]])

//   // Test with some arbitrary inputs
//   [1, 2]
//   |> combinatorics.list_permutation()
//   |> iterator.to_list()
//   |> set.from_list()
//   |> should.equal(set.from_list([[1, 2], [2, 1]]))

//   // Test with some arbitrary inputs
//   [1, 2, 3]
//   |> combinatorics.list_permutation()
//   |> iterator.to_list()
//   |> set.from_list()
//   |> should.equal(
//     set.from_list([
//       [1, 2, 3],
//       [2, 1, 3],
//       [3, 1, 2],
//       [1, 3, 2],
//       [2, 3, 1],
//       [3, 2, 1],
//     ]),
//   )

//   // Repeated elements are treated as distinct for the
//   // purpose of permutations, so two identical elements
//   // will appear "both ways round"
//   [1.0, 1.0]
//   |> combinatorics.list_permutation()
//   |> iterator.to_list()
//   |> should.equal([[1.0, 1.0], [1.0, 1.0]])

//   // This means lists with repeated elements return the
//   // same number of permutations as ones without
//   ["l", "e", "t", "t", "e", "r", "s"]
//   |> combinatorics.list_permutation()
//   |> iterator.to_list()
//   |> list.length()
//   |> should.equal(5040)

//   // Test that the number of generate permutations of the given input list aligns with the computed
//   // number of possible permutations (using the formula for the binomial coefficient)
//   let arr = ["a", "b", "c", "x", "y", "z"]
//   let length = list.length(arr)
//   let assert Ok(permuations) =
//     combinatorics.permutation(
//       length,
//       length,
//       option.Some(combinatorics.WithoutRepetitions),
//     )

//   arr
//   |> combinatorics.list_permutation()
//   |> iterator.to_list()
//   |> list.length()
//   |> should.equal(permuations)
// }

// pub fn list_combination_test() {
//   // Invaldi input: A negative number returns an error
//   []
//   |> combinatorics.list_combination(-1)
//   |> should.be_error()

//   // Invalid input: k is larger than given input list, so it returns an error 
//   [1, 2]
//   |> combinatorics.list_combination(3)
//   |> should.be_error()

//   // Valid input: An empty lists returns an empty list
//   let assert Ok(combinations) =
//     []
//     |> combinatorics.list_combination(0)

//   combinations
//   |> iterator.to_list()
//   |> should.equal([[]])

//   // Test with some arbitrary but valid inputs
//   let assert Ok(combinations) =
//     [1, 2]
//     |> combinatorics.list_combination(1)

//   combinations
//   |> iterator.to_list()
//   |> should.equal([[1], [2]])

//   // Test with some arbitrary but valid inputs
//   let assert Ok(combinations) =
//     [1, 2]
//     |> combinatorics.list_combination(2)

//   combinations
//   |> iterator.to_list()
//   |> should.equal([[1, 2]])

//   // Test with some arbitrary but valid inputs
//   let assert Ok(combinations) =
//     [1, 2, 3, 4] |> combinatorics.list_combination(2)

//   combinations
//   |> iterator.to_list()
//   |> set.from_list()
//   |> should.equal(
//     set.from_list([[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]),
//   )

//   // Test with some arbitrary but valid inputs
//   let assert Ok(combinations) =
//     [1, 2, 3, 4] |> combinatorics.list_combination(3)

//   combinations
//   |> iterator.to_list()
//   |> set.from_list()
//   |> should.equal(set.from_list([[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]))
// }
