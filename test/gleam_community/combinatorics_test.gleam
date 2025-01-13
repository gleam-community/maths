import gleam/list
import gleam/set
import gleam/yielder
import gleam_community/maths
import gleeunit/should

pub fn int_factorial_test() {
  // Invalid input gives an error (factorial of negative number)
  maths.factorial(-1)
  |> should.be_error()

  // Valid inputs for factorial of small numbers
  maths.factorial(0)
  |> should.equal(Ok(1))

  maths.factorial(1)
  |> should.equal(Ok(1))

  maths.factorial(2)
  |> should.equal(Ok(2))

  maths.factorial(3)
  |> should.equal(Ok(6))

  maths.factorial(4)
  |> should.equal(Ok(24))
}

pub fn int_combination_with_repetitions_test() {
  // Invalid input: k < 0 should return an error
  maths.combination_with_repetitions(1, -1)
  |> should.be_error()

  // Invalid input: n < 0 should return an error
  maths.combination_with_repetitions(-1, 1)
  |> should.be_error()

  // Valid input: k > n with repetition allowed
  maths.combination_with_repetitions(2, 3)
  |> should.equal(Ok(4))

  maths.combination_with_repetitions(4, 0)
  |> should.equal(Ok(1))

  // Valid input: k = n with repetition allows more combinations
  maths.combination_with_repetitions(4, 4)
  |> should.equal(Ok(35))

  maths.combination_with_repetitions(4, 2)
  |> should.equal(Ok(10))

  maths.combination_with_repetitions(7, 5)
  |> should.equal(Ok(462))
  // NOTE: Tests with the 'combination' function that produce values that exceed
  // precision of the JavaScript 'Number' primitive will result in errors
}

pub fn int_combination_without_repetitions_test() {
  // Valid input: k > n without repetition gives 0 combinations
  maths.combination(2, 3)
  |> should.equal(Ok(0))
  maths.combination(10, 20)
  |> should.equal(Ok(0))

  // Valid input: k = n without repetition gives 1 combination
  maths.combination(4, 4)
  |> should.equal(Ok(1))

  // Valid input: zero combinations (k=0) should always yield 1 combination
  maths.combination(4, 0)
  |> should.equal(Ok(1))

  // Valid input: k < n without and with repetition
  maths.combination(4, 2)
  |> should.equal(Ok(6))

  // Valid input with larger values of n and k
  maths.combination(7, 5)
  |> should.equal(Ok(21))
}

pub fn math_permutation_with_repetitions_test() {
  // Invalid input: k < 0 should return an error
  maths.permutation_with_repetitions(1, -1)
  |> should.be_error()

  // Valid input: k > n with repetition allowed gives non-zero permutations
  maths.permutation_with_repetitions(2, 3)
  |> should.equal(Ok(8))

  maths.permutation_with_repetitions(4, 0)
  |> should.equal(Ok(1))

  // Valid input: k = n permutations with repetition
  maths.permutation_with_repetitions(4, 4)
  |> should.equal(Ok(256))

  maths.permutation_with_repetitions(4, 2)
  |> should.equal(Ok(16))

  maths.permutation_with_repetitions(6, 2)
  |> should.equal(Ok(36))

  maths.permutation_with_repetitions(6, 3)
  |> should.equal(Ok(216))
}

pub fn math_permutation_without_repetitions_test() {
  // Invalid input: k < 0 should return an error
  maths.permutation(1, -1)
  |> should.be_error()

  // Invalid input: n < 0 should return an error
  maths.permutation(-1, 1)
  |> should.be_error()

  // Valid input: k > n without repetition gives 0 permutations
  maths.permutation(2, 3)
  |> should.equal(Ok(0))

  // Valid input: k = 0 should always yield 1 permutation
  maths.permutation(4, 0)
  |> should.equal(Ok(1))

  // Valid input: k = n permutations without repetition
  maths.permutation(4, 4)
  |> should.equal(Ok(24))

  // Valid input: k < n permutations without and with repetition
  maths.permutation(4, 2)
  |> should.equal(Ok(12))

  // Valid input with larger values of n and k
  maths.permutation(6, 2)
  |> should.equal(Ok(30))

  maths.permutation(6, 3)
  |> should.equal(Ok(120))
}

pub fn list_cartesian_product_test() {
  // An empty list returns an empty list as the Cartesian product
  let xset = set.from_list([])
  let yset = set.from_list([])
  let expected_result = set.from_list([])
  xset
  |> maths.cartesian_product(yset)
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
  |> maths.cartesian_product(yset)
  |> should.equal(expected_result)

  // Cartesian product with floating-point numbers
  let xset = set.from_list([1.0, 10.0])
  let yset = set.from_list([1.0, 2.0])
  let expected_result =
    set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)])
  xset
  |> maths.cartesian_product(yset)
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
  |> maths.cartesian_product(yset)
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
  |> maths.cartesian_product(yset)
  |> should.equal(expected_result)
}

pub fn cartesian_product_mixed_types_test() {
  // Cartesian product of two empty sets
  set.from_list([])
  |> maths.cartesian_product(set.from_list([]))
  |> should.equal(set.from_list([]))

  // Cartesian product of two sets with numeric values
  set.from_list([1.0, 10.0])
  |> maths.cartesian_product(set.from_list([1.0, 2.0]))
  |> should.equal(
    set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)]),
  )

  // Cartesian product of two sets with different types
  set.from_list(["1", "10"])
  |> maths.cartesian_product(set.from_list([1.0, 2.0]))
  |> should.equal(
    set.from_list([#("1", 1.0), #("1", 2.0), #("10", 1.0), #("10", 2.0)]),
  )
}

pub fn list_permutation_with_repetitions_test() {
  // Invalid input: k < 0 should return an error for an empty list
  []
  |> maths.list_permutation_with_repetitions(-1)
  |> should.be_error()

  // Valid input: An empty list returns a single empty permutation
  let assert Ok(permutations) =
    []
    |> maths.list_permutation_with_repetitions(0)
  permutations
  |> yielder.to_list()
  |> should.equal([[]])

  let assert Ok(permutations) =
    ["a"]
    |> maths.list_permutation_with_repetitions(1)
  permutations
  |> yielder.to_list()
  |> should.equal([["a"]])

  // 4-permutations of a single element repeats it 4 times
  let assert Ok(permutations) =
    ["a"]
    |> maths.list_permutation_with_repetitions(4)
  permutations
  |> yielder.to_list()
  |> should.equal([["a", "a", "a", "a"]])

  // 2-permutations of [1, 2] with repetition
  let assert Ok(permutations) =
    [1, 2]
    |> maths.list_permutation_with_repetitions(2)
  permutations
  |> yielder.to_list()
  |> set.from_list()
  |> should.equal(set.from_list([[1, 1], [1, 2], [2, 2], [2, 1]]))

  // 3-permutations of [1, 2, 3] with repetition
  let assert Ok(permutations) =
    [1, 2, 3]
    |> maths.list_permutation_with_repetitions(3)
  permutations
  |> yielder.to_list()
  |> should.equal([
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
  ])

  // Repeated elements allow more possibilities when repetition is allowed
  let assert Ok(permutations) =
    [1.0, 1.0]
    |> maths.list_permutation_with_repetitions(2)
  permutations
  |> yielder.to_list()
  |> should.equal([[1.0, 1.0], [1.0, 1.0], [1.0, 1.0], [1.0, 1.0]])

  let assert Ok(permutations) =
    ["a", "b", "c", "d", "e"]
    |> maths.list_permutation_with_repetitions(5)
  permutations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(3125)
}

pub fn list_permutation_without_repetitions_test() {
  // Invalid input: k > n should return an error without repetition
  [1, 2]
  |> maths.list_permutation(3)
  |> should.be_error()

  // Singleton list returns a single permutation regardless of repetition settings
  let assert Ok(permutations) =
    ["a"]
    |> maths.list_permutation(1)
  permutations
  |> yielder.to_list()
  |> should.equal([["a"]])

  // 2-permutations of [1, 2] without repetition
  let assert Ok(permutations) =
    [1, 2]
    |> maths.list_permutation(2)
  permutations
  |> yielder.to_list()
  |> should.equal([[1, 2], [2, 1]])

  // 2-permutations without repetition
  let assert Ok(result) =
    [1, 2, 3]
    |> maths.list_permutation(2)
  result
  |> yielder.to_list()
  |> should.equal([[1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]])

  // 3-permutations of [1, 2, 3] without repetition
  let assert Ok(permutations) =
    [1, 2, 3]
    |> maths.list_permutation(3)
  permutations
  |> yielder.to_list()
  |> should.equal([
    [1, 2, 3],
    [1, 3, 2],
    [2, 1, 3],
    [2, 3, 1],
    [3, 1, 2],
    [3, 2, 1],
  ])

  // 3-permutations of [1, 2, 3, 4] without repetition
  let assert Ok(permutations) =
    [1, 2, 3, 4]
    |> maths.list_permutation(3)
  permutations
  |> yielder.to_list()
  |> should.equal([
    [1, 2, 3],
    [1, 2, 4],
    [1, 3, 2],
    [1, 3, 4],
    [1, 4, 2],
    [1, 4, 3],
    [2, 1, 3],
    [2, 1, 4],
    [2, 3, 1],
    [2, 3, 4],
    [2, 4, 1],
    [2, 4, 3],
    [3, 1, 2],
    [3, 1, 4],
    [3, 2, 1],
    [3, 2, 4],
    [3, 4, 1],
    [3, 4, 2],
    [4, 1, 2],
    [4, 1, 3],
    [4, 2, 1],
    [4, 2, 3],
    [4, 3, 1],
    [4, 3, 2],
  ])

  // Repeated elements are treated as distinct in permutations without repetition
  let assert Ok(permutations) =
    [1.0, 1.0]
    |> maths.list_permutation(2)
  permutations
  |> yielder.to_list()
  |> should.equal([[1.0, 1.0], [1.0, 1.0]])

  // Large inputs: Ensure the correct number of permutations is generated
  let assert Ok(permutations) =
    ["a", "b", "c", "d", "e"]
    |> maths.list_permutation(5)
  permutations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(120)
}

pub fn permutation_alignment_test() {
  // Test: Number of generated permutations should match the expected count
  // Without repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_permutations) = maths.permutation(length, length)
  let assert Ok(permutations) =
    arr
    |> maths.list_permutation(length)
  permutations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(number_of_permutations)

  // With repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_permutations) =
    maths.permutation_with_repetitions(length, length)
  let assert Ok(permutations) =
    arr
    |> maths.list_permutation_with_repetitions(length)
  permutations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(number_of_permutations)
}

pub fn list_combination_with_repetitions_test() {
  // Invalid input: k < 0 should return an error for an empty list
  []
  |> maths.list_combination_with_repetitions(-1)
  |> should.be_error()

  // Valid input: k > n with repetition allowed
  let assert Ok(combinations) =
    [1, 2]
    |> maths.list_combination_with_repetitions(3)
  combinations
  |> yielder.to_list()
  |> should.equal([[1, 1, 1], [1, 1, 2], [1, 2, 2], [2, 2, 2]])

  let assert Ok(combinations) =
    []
    |> maths.list_combination_with_repetitions(0)
  combinations
  |> yielder.to_list()
  |> should.equal([[]])

  let assert Ok(combinations) =
    [1, 2]
    |> maths.list_combination_with_repetitions(1)
  combinations
  |> yielder.to_list()
  |> should.equal([[1], [2]])

  let assert Ok(combinations) =
    [1, 2]
    |> maths.list_combination_with_repetitions(2)
  combinations
  |> yielder.to_list()
  |> should.equal([[1, 1], [1, 2], [2, 2]])

  let assert Ok(combinations) =
    [1, 2, 3, 4]
    |> maths.list_combination_with_repetitions(2)
  combinations
  |> yielder.to_list()
  |> should.equal([
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
  ])

  // 3-combination of [1, 2, 3] with repetition
  let assert Ok(combinations) =
    [1, 2, 3]
    |> maths.list_combination_with_repetitions(3)
  combinations
  |> yielder.to_list()
  |> should.equal([
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
  ])

  // 3-permutations of [1, 2, 3, 4] with repetition
  let assert Ok(permutations) =
    maths.list_combination_with_repetitions([1, 2, 3, 4], 3)

  permutations
  |> yielder.to_list()
  |> should.equal([
    [1, 1, 1],
    [1, 1, 2],
    [1, 1, 3],
    [1, 1, 4],
    [1, 2, 2],
    [1, 2, 3],
    [1, 2, 4],
    [1, 3, 3],
    [1, 3, 4],
    [1, 4, 4],
    [2, 2, 2],
    [2, 2, 3],
    [2, 2, 4],
    [2, 3, 3],
    [2, 3, 4],
    [2, 4, 4],
    [3, 3, 3],
    [3, 3, 4],
    [3, 4, 4],
    [4, 4, 4],
  ])

  // Repetition creates more possibilities even with identical elements
  let assert Ok(combinations) =
    [1.0, 1.0]
    |> maths.list_combination_with_repetitions(2)
  combinations
  |> yielder.to_list()
  |> should.equal([[1.0, 1.0], [1.0, 1.0], [1.0, 1.0]])

  let assert Ok(combinations) =
    ["a", "b", "c", "d", "e"]
    |> maths.list_combination_with_repetitions(5)
  combinations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(126)
}

pub fn list_combination_without_repetitions_test() {
  // Invalid input: k > n should return an error without repetition
  [1, 2]
  |> maths.list_combination(3)
  |> should.be_error()

  // Valid input: Empty list should return a single empty combination
  let assert Ok(combinations) =
    []
    |> maths.list_combination(0)
  combinations
  |> yielder.to_list()
  |> should.equal([[]])

  // 1-combination of [1, 2] without and with repetition
  let assert Ok(combinations) =
    [1, 2]
    |> maths.list_combination(1)
  combinations
  |> yielder.to_list()
  |> should.equal([[1], [2]])

  // 2-combination of [1, 2] without and with repetition
  let assert Ok(combinations) =
    [1, 2]
    |> maths.list_combination(2)
  combinations
  |> yielder.to_list()
  |> should.equal([[1, 2]])

  // 2-combination of [1, 2, 3, 4] without and with repetition
  let assert Ok(combinations) =
    [1, 2, 3, 4]
    |> maths.list_combination(2)
  combinations
  |> yielder.to_list()
  |> should.equal([[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]])

  // 3-combination of [1, 2, 3, 4] without repetition
  let assert Ok(combinations) =
    [1, 2, 3, 4]
    |> maths.list_combination(3)
  combinations
  |> yielder.to_list()
  |> should.equal([[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]])

  // Combinations treat repeated elements as distinct in certain scenarios
  let assert Ok(combinations) =
    [1.0, 1.0]
    |> maths.list_combination(2)
  combinations
  |> yielder.to_list()
  |> should.equal([[1.0, 1.0]])

  // Large input: Ensure correct number of combinations is generated
  let assert Ok(combinations) =
    ["a", "b", "c", "d", "e"]
    |> maths.list_combination(5)
  combinations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(1)
}

pub fn combination_alignment_test() {
  // Test: Number of generated combinations should match the expected count
  // Without repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_combinations) = maths.combination(length, length)
  let assert Ok(combinations) =
    arr
    |> maths.list_combination(length)
  combinations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(number_of_combinations)

  // With repetitions
  let arr = ["a", "b", "c", "d", "e", "f"]
  let length = list.length(arr)

  let assert Ok(number_of_combinations) =
    maths.combination_with_repetitions(length, length)
  let assert Ok(combinations) =
    arr
    |> maths.list_combination_with_repetitions(length)
  combinations
  |> yielder.to_list()
  |> list.length()
  |> should.equal(number_of_combinations)
}
