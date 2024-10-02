import gleam/iterator
import gleam/list
import gleam/option
import gleam/set
import gleam_community/maths/combinatorics
import gleeunit/should

pub fn int_factorial_test() {
  // Invalid input gives an error (factorial of negative number)
  combinatorics.factorial(-1)
  |> should.be_error()

  // Valid inputs for factorial of small numbers
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
  // Invalid input: k < 0 should return an error
  combinatorics.combination(1, -1, option.None)
  |> should.be_error()

  // Invalid input: n < 0 should return an error
  combinatorics.combination(-1, 1, option.None)
  |> should.be_error()

  // Valid input: k > n without repetition gives 0 combinations
  combinatorics.combination(2, 3, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(0))

  // Valid input: k > n with repetition allowed
  combinatorics.combination(2, 3, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(4))

  // Valid input: zero combinations (k=0) should always yield 1 combination
  combinatorics.combination(4, 0, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(1))

  combinatorics.combination(4, 0, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(1))

  // Valid input: k = n without repetition gives 1 combination
  combinatorics.combination(4, 4, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(1))

  // Valid input: k = n with repetition allows more combinations
  combinatorics.combination(4, 4, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(35))

  // Valid input: k < n without and with repetition
  combinatorics.combination(4, 2, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(6))

  combinatorics.combination(4, 2, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(10))

  // Valid input with larger values of n and k
  combinatorics.combination(7, 5, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(21))

  combinatorics.combination(7, 5, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(462))
  // NOTE: Tests with the 'combination' function that produce values that exceed
  // precision of the JavaScript 'Number' primitive will result in errors
}

pub fn math_permutation_test() {
  // Invalid input: k < 0 should return an error
  combinatorics.permutation(1, -1, option.None)
  |> should.be_error()

  // Invalid input: n < 0 should return an error
  combinatorics.permutation(-1, 1, option.None)
  |> should.be_error()

  // Valid input: k > n without repetition gives 0 permutations
  combinatorics.permutation(2, 3, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(0))

  // Valid input: k > n with repetition allowed gives non-zero permutations
  combinatorics.permutation(2, 3, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(8))

  // Valid input: k = 0 should always yield 1 permutation
  combinatorics.permutation(4, 0, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(1))

  combinatorics.permutation(4, 0, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(1))

  // Valid input: k = n permutations without repetition
  combinatorics.permutation(4, 4, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(24))

  // Valid input: k = n permutations with repetition
  combinatorics.permutation(4, 4, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(256))

  // Valid input: k < n permutations without and with repetition
  combinatorics.permutation(4, 2, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(12))

  combinatorics.permutation(4, 2, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(16))

  // Valid input with larger values of n and k
  combinatorics.permutation(6, 2, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(30))

  combinatorics.permutation(6, 2, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(36))

  combinatorics.permutation(6, 3, option.Some(combinatorics.WithoutRepetitions))
  |> should.equal(Ok(120))

  combinatorics.permutation(6, 3, option.Some(combinatorics.WithRepetitions))
  |> should.equal(Ok(216))
}

pub fn list_cartesian_product_test() {
  // An empty list returns an empty list as the Cartesian product
  let xset = set.from_list([])
  let yset = set.from_list([])
  let expected_result = set.from_list([])
  xset
  |> combinatorics.cartesian_product(yset)
  |> should.equal(expected_result)

  // Cartesian product of two sets with the same elements
  let xset = set.from_list([1, 2, 3])
  let yset = set.from_list([1, 2, 3])
  let expected_result =
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
    ])
  xset
  |> combinatorics.cartesian_product(yset)
  |> should.equal(expected_result)

  // Cartesian product with floating-point numbers
  let xset = set.from_list([1.0, 10.0])
  let yset = set.from_list([1.0, 2.0])
  let expected_result =
    set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)])
  xset
  |> combinatorics.cartesian_product(yset)
  |> should.equal(expected_result)

  // Cartesian product of sets with different sizes
  let xset = set.from_list([1.0, 10.0, 100.0])
  let yset = set.from_list([1.0, 2.0])
  let expected_result =
    set.from_list([
      #(1.0, 1.0),
      #(1.0, 2.0),
      #(10.0, 1.0),
      #(10.0, 2.0),
      #(100.0, 1.0),
      #(100.0, 2.0),
    ])
  xset
  |> combinatorics.cartesian_product(yset)
  |> should.equal(expected_result)

  // Cartesian product with different types (strings)
  let xset = set.from_list(["a", "y", "z"])
  let yset = set.from_list(["a", "x"])
  let expected_result =
    set.from_list([
      #("a", "a"),
      #("a", "x"),
      #("y", "a"),
      #("y", "x"),
      #("z", "a"),
      #("z", "x"),
    ])
  xset
  |> combinatorics.cartesian_product(yset)
  |> should.equal(expected_result)
}

pub fn list_permutation_test() {
  // Invalid input: k < 0 should return an error for an empty list
  []
  |> combinatorics.list_permutation(-1, option.None)
  |> should.be_error()

  // Invalid input: k > n should return an error without repetition
  [1, 2]
  |> combinatorics.list_permutation(
    3,
    option.Some(combinatorics.WithoutRepetitions),
  )
  |> should.be_error()

  // Valid input: An empty list returns a single empty permutation
  let assert Ok(permutations) =
    []
    |> combinatorics.list_permutation(0, option.None)
  permutations
  |> iterator.to_list()
  |> should.equal([[]])

  // Singleton list returns a single permutation regardless of repetition settings
  let assert Ok(permutations) =
    ["a"]
    |> combinatorics.list_permutation(
      1,
      option.Some(combinatorics.WithoutRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> should.equal([["a"]])

  let assert Ok(permutations) =
    ["a"]
    |> combinatorics.list_permutation(
      1,
      option.Some(combinatorics.WithRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> should.equal([["a"]])

  // 4-permutations of a single element repeats it 4 times
  let assert Ok(permutations) =
    ["a"]
    |> combinatorics.list_permutation(
      4,
      option.Some(combinatorics.WithRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> should.equal([["a", "a", "a", "a"]])

  // 2-permutations of [1, 2] without repetition
  let assert Ok(permutations) =
    [1, 2]
    |> combinatorics.list_permutation(
      2,
      option.Some(combinatorics.WithoutRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> set.from_list()
  |> should.equal(set.from_list([[1, 2], [2, 1]]))

  // 2-permutations of [1, 2] with repetition
  let assert Ok(permutations) =
    [1, 2]
    |> combinatorics.list_permutation(
      2,
      option.Some(combinatorics.WithRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> set.from_list()
  |> should.equal(set.from_list([[1, 1], [1, 2], [2, 2], [2, 1]]))

  // 3-permutations of [1, 2, 3] without repetition
  let assert Ok(permutations) =
    [1, 2, 3]
    |> combinatorics.list_permutation(
      3,
      option.Some(combinatorics.WithoutRepetitions),
    )
  permutations
  |> iterator.to_list()
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

  // 3-permutations of [1, 2, 3] with repetition
  let assert Ok(permutations) =
    [1, 2, 3]
    |> combinatorics.list_permutation(
      3,
      option.Some(combinatorics.WithRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> set.from_list()
  |> should.equal(
    set.from_list([
      [1, 1, 1],
      [1, 1, 2],
      [1, 1, 3],
      [1, 2, 1],
      [1, 2, 2],
      [1, 2, 3],
      [1, 3, 1],
      [1, 3, 2],
      [1, 3, 3],
      [2, 1, 1],
      [2, 1, 2],
      [2, 1, 3],
      [2, 2, 1],
      [2, 2, 2],
      [2, 2, 3],
      [2, 3, 1],
      [2, 3, 2],
      [2, 3, 3],
      [3, 1, 1],
      [3, 1, 2],
      [3, 1, 3],
      [3, 2, 1],
      [3, 2, 2],
      [3, 2, 3],
      [3, 3, 1],
      [3, 3, 2],
      [3, 3, 3],
    ]),
  )

  // Repeated elements are treated as distinct in permutations without repetition
  let assert Ok(permutations) =
    [1.0, 1.0]
    |> combinatorics.list_permutation(
      2,
      option.Some(combinatorics.WithoutRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> should.equal([[1.0, 1.0], [1.0, 1.0]])

  // Repeated elements allow more possibilities when repetition is allowed
  let assert Ok(permutations) =
    [1.0, 1.0]
    |> combinatorics.list_permutation(
      2,
      option.Some(combinatorics.WithRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> should.equal([[1.0, 1.0], [1.0, 1.0], [1.0, 1.0], [1.0, 1.0]])

  // Large inputs: Ensure the correct number of permutations is generated
  let assert Ok(permutations) =
    ["a", "b", "c", "d", "e"]
    |> combinatorics.list_permutation(
      5,
      option.Some(combinatorics.WithoutRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(120)

  let assert Ok(permutations) =
    ["a", "b", "c", "d", "e"]
    |> combinatorics.list_permutation(
      5,
      option.Some(combinatorics.WithRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(3125)
}

pub fn permutation_alignment_test() {
  // Test: Number of generated permutations should match the expected count
  // Without repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_permutations) =
    combinatorics.permutation(
      length,
      length,
      option.Some(combinatorics.WithoutRepetitions),
    )
  let assert Ok(permutations) =
    arr
    |> combinatorics.list_permutation(
      length,
      option.Some(combinatorics.WithoutRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(number_of_permutations)

  // With repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_permutations) =
    combinatorics.permutation(
      length,
      length,
      option.Some(combinatorics.WithRepetitions),
    )
  let assert Ok(permutations) =
    arr
    |> combinatorics.list_permutation(
      length,
      option.Some(combinatorics.WithRepetitions),
    )
  permutations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(number_of_permutations)
}

pub fn list_combination_test() {
  // Invalid input: k < 0 should return an error for an empty list
  []
  |> combinatorics.list_combination(-1, option.None)
  |> should.be_error()

  // Invalid input: k > n should return an error without repetition
  [1, 2]
  |> combinatorics.list_combination(
    3,
    option.Some(combinatorics.WithoutRepetitions),
  )
  |> should.be_error()

  // Valid input: k > n with repetition allowed
  let assert Ok(combinations) =
    [1, 2]
    |> combinatorics.list_combination(
      3,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[1, 1, 1], [1, 1, 2], [1, 2, 2], [2, 2, 2]])

  // Valid input: Empty list should return a single empty combination
  let assert Ok(combinations) =
    []
    |> combinatorics.list_combination(
      0,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[]])

  let assert Ok(combinations) =
    []
    |> combinatorics.list_combination(
      0,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[]])

  // 1-combination of [1, 2] without and with repetition
  let assert Ok(combinations) =
    [1, 2]
    |> combinatorics.list_combination(
      1,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[1], [2]])

  let assert Ok(combinations) =
    [1, 2]
    |> combinatorics.list_combination(
      1,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[1], [2]])

  // 2-combination of [1, 2] without and with repetition
  let assert Ok(combinations) =
    [1, 2]
    |> combinatorics.list_combination(
      2,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[1, 2]])

  let assert Ok(combinations) =
    [1, 2]
    |> combinatorics.list_combination(
      2,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[1, 1], [1, 2], [2, 2]])

  // 2-combination of [1, 2, 3, 4] without and with repetition
  let assert Ok(combinations) =
    [1, 2, 3, 4]
    |> combinatorics.list_combination(
      2,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> set.from_list()
  |> should.equal(
    set.from_list([[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]),
  )

  let assert Ok(combinations) =
    [1, 2, 3, 4]
    |> combinatorics.list_combination(
      2,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> set.from_list()
  |> should.equal(
    set.from_list([
      [1, 1],
      [1, 2],
      [1, 3],
      [1, 4],
      [2, 2],
      [2, 3],
      [2, 4],
      [3, 3],
      [3, 4],
      [4, 4],
    ]),
  )

  // 3-combination of [1, 2, 3, 4] without repetition
  let assert Ok(combinations) =
    [1, 2, 3, 4]
    |> combinatorics.list_combination(
      3,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> set.from_list()
  |> should.equal(set.from_list([[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]))

  // 3-combination of [1, 2, 3] with repetition
  let assert Ok(combinations) =
    [1, 2, 3]
    |> combinatorics.list_combination(
      3,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> set.from_list()
  |> should.equal(
    set.from_list([
      [1, 1, 1],
      [1, 1, 2],
      [1, 1, 3],
      [1, 2, 2],
      [1, 2, 3],
      [1, 3, 3],
      [2, 2, 2],
      [2, 2, 3],
      [2, 3, 3],
      [3, 3, 3],
    ]),
  )

  // Combinations treat repeated elements as distinct in certain scenarios
  let assert Ok(combinations) =
    [1.0, 1.0]
    |> combinatorics.list_combination(
      2,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[1.0, 1.0]])

  // Repetition creates more possibilities even with identical elements
  let assert Ok(combinations) =
    [1.0, 1.0]
    |> combinatorics.list_combination(
      2,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> should.equal([[1.0, 1.0], [1.0, 1.0], [1.0, 1.0]])

  // Large input: Ensure correct number of combinations is generated
  let assert Ok(combinations) =
    ["a", "b", "c", "d", "e"]
    |> combinatorics.list_combination(
      5,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(1)

  let assert Ok(combinations) =
    ["a", "b", "c", "d", "e"]
    |> combinatorics.list_combination(
      5,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(126)
}

pub fn combination_alignment_test() {
  // Test: Number of generated combinations should match the expected count
  // Without repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_combinations) =
    combinatorics.combination(
      length,
      length,
      option.Some(combinatorics.WithoutRepetitions),
    )
  let assert Ok(combinations) =
    arr
    |> combinatorics.list_combination(
      length,
      option.Some(combinatorics.WithoutRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(number_of_combinations)

  // With repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_combinations) =
    combinatorics.combination(
      length,
      length,
      option.Some(combinatorics.WithRepetitions),
    )
  let assert Ok(combinations) =
    arr
    |> combinatorics.list_combination(
      length,
      option.Some(combinatorics.WithRepetitions),
    )
  combinations
  |> iterator.to_list()
  |> list.length()
  |> should.equal(number_of_combinations)
}

pub fn example_test() {
  // Cartesian product of two empty sets
  set.from_list([])
  |> combinatorics.cartesian_product(set.from_list([]))
  |> should.equal(set.from_list([]))

  // Cartesian product of two sets with numeric values
  set.from_list([1.0, 10.0])
  |> combinatorics.cartesian_product(set.from_list([1.0, 2.0]))
  |> should.equal(
    set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)]),
  )

  // Cartesian product of two sets with different types
  set.from_list(["1", "10"])
  |> combinatorics.cartesian_product(set.from_list([1.0, 2.0]))
  |> should.equal(
    set.from_list([#("1", 1.0), #("1", 2.0), #("10", 1.0), #("10", 2.0)]),
  )
}
