import gleam_community/maths/elementary
import gleam_community/maths/metrics
import gleam_community/maths/predicates
import gleeunit/should
import gleam/set
import gleam/option

pub fn float_list_norm_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // An empty lists returns 0.0
  []
  |> metrics.norm(1.0, option.None)
  |> should.equal(Ok(0.0))

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) =
    [1.0, 1.0, 1.0]
    |> metrics.norm(1.0, option.None)
  result
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [1.0, 1.0, 1.0]
    |> metrics.norm(-1.0, option.None)
  result
  |> predicates.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -1.0, -1.0]
    |> metrics.norm(-1.0, option.None)
  result
  |> predicates.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -1.0, -1.0]
    |> metrics.norm(1.0, option.None)
  result
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -2.0, -3.0]
    |> metrics.norm(-10.0, option.None)
  result
  |> predicates.is_close(0.9999007044905545, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -2.0, -3.0]
    |> metrics.norm(-100.0, option.None)
  result
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -2.0, -3.0]
    |> metrics.norm(2.0, option.None)
  result
  |> predicates.is_close(3.7416573867739413, 0.0, tol)
  |> should.be_true()
}

pub fn float_list_manhattan_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Empty lists returns an error
  metrics.manhattan_distance([], [], option.None)
  |> should.be_error()

  // Differing lengths returns error
  metrics.manhattan_distance([], [1.0], option.None)
  |> should.be_error()

  // Try with valid input (same as Minkowski distance with p = 1)
  let assert Ok(result) =
    metrics.manhattan_distance([0.0, 0.0], [1.0, 2.0], option.None)
  result
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()

  metrics.manhattan_distance([1.0, 2.0, 3.0], [4.0, 5.0, 6.0], option.None)
  |> should.equal(Ok(9.0))

  metrics.manhattan_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([1.0, 1.0, 1.0]),
  )
  |> should.equal(Ok(9.0))

  metrics.manhattan_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([1.0, 2.0, 3.0]),
  )
  |> should.equal(Ok(18.0))

  // Try invalid input with weights (different sized lists returns an error)
  metrics.manhattan_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([7.0, 8.0]),
  )
  |> should.be_error()

  // Try invalid input with weights that are negative
  metrics.manhattan_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([-7.0, -8.0, -9.0]),
  )
  |> should.be_error()
}

pub fn float_list_minkowski_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Empty lists returns an error
  metrics.minkowski_distance([], [], 1.0, option.None)
  |> should.be_error()

  // Differing lengths returns error
  metrics.minkowski_distance([], [1.0], 1.0, option.None)
  |> should.be_error()

  // Test order < 1
  metrics.minkowski_distance([0.0, 0.0], [0.0, 0.0], -1.0, option.None)
  |> should.be_error()

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) =
    metrics.minkowski_distance([1.0, 1.0], [1.0, 1.0], 1.0, option.None)
  result
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0, option.None)
  result
  |> predicates.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 1.0], 100.0, option.None)
  result
  |> predicates.is_close(1.0069555500567189, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0, option.None)
  result
  |> predicates.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  // Euclidean distance (p = 2)
  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 2.0], 2.0, option.None)
  result
  |> predicates.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()

  // Manhattan distance (p = 1)
  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 2.0], 1.0, option.None)
  result
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()

  // Try different valid input
  let assert Ok(result) =
    metrics.minkowski_distance(
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0],
      4.0,
      option.None,
    )
  result
  |> predicates.is_close(3.9482220388574776, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance(
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0],
      4.0,
      option.Some([1.0, 1.0, 1.0]),
    )
  result
  |> predicates.is_close(3.9482220388574776, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance(
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0],
      4.0,
      option.Some([1.0, 2.0, 3.0]),
    )
  result
  |> predicates.is_close(4.6952537402198615, 0.0, tol)
  |> should.be_true()

  // Try invalid input with weights (different sized lists returns an error)
  metrics.minkowski_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    2.0,
    option.Some([7.0, 8.0]),
  )
  |> should.be_error()

  // Try invalid input with weights that are negative
  metrics.minkowski_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    2.0,
    option.Some([-7.0, -8.0, -9.0]),
  )
  |> should.be_error()
}

pub fn float_list_euclidean_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Empty lists returns an error
  metrics.euclidean_distance([], [], option.None)
  |> should.be_error()

  // Differing lengths returns error
  metrics.euclidean_distance([], [1.0], option.None)
  |> should.be_error()

  // Try with valid input (same as Minkowski distance with p = 2)
  let assert Ok(result) =
    metrics.euclidean_distance([0.0, 0.0], [1.0, 2.0], option.None)
  result
  |> predicates.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()

  // Try different valid input
  let assert Ok(result) =
    metrics.euclidean_distance([1.0, 2.0, 3.0], [4.0, 5.0, 6.0], option.None)
  result
  |> predicates.is_close(5.196152422706632, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.euclidean_distance(
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0],
      option.Some([1.0, 1.0, 1.0]),
    )
  result
  |> predicates.is_close(5.196152422706632, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.euclidean_distance(
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0],
      option.Some([1.0, 2.0, 3.0]),
    )
  result
  |> predicates.is_close(7.3484692283495345, 0.0, tol)
  |> should.be_true()

  // Try invalid input with weights (different sized lists returns an error)
  metrics.euclidean_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([7.0, 8.0]),
  )
  |> should.be_error()

  // Try invalid input with weights that are negative
  metrics.euclidean_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([-7.0, -8.0, -9.0]),
  )
  |> should.be_error()
}

pub fn mean_test() {
  // An empty list returns an error
  []
  |> metrics.mean()
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> metrics.mean()
  |> should.equal(Ok(2.0))
}

pub fn median_test() {
  // An empty list returns an error
  []
  |> metrics.median()
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> metrics.median()
  |> should.equal(Ok(2.0))

  [1.0, 2.0, 3.0, 4.0]
  |> metrics.median()
  |> should.equal(Ok(2.5))
}

pub fn variance_test() {
  // Degrees of freedom
  let ddof: Int = 1

  // An empty list returns an error
  []
  |> metrics.variance(ddof)
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> metrics.variance(ddof)
  |> should.equal(Ok(1.0))
}

pub fn standard_deviation_test() {
  // Degrees of freedom
  let ddof: Int = 1

  // An empty list returns an error
  []
  |> metrics.standard_deviation(ddof)
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> metrics.standard_deviation(ddof)
  |> should.equal(Ok(1.0))
}

pub fn jaccard_index_test() {
  metrics.jaccard_index(set.from_list([]), set.from_list([]))
  |> should.equal(0.0)

  let set_a: set.Set(Int) = set.from_list([0, 1, 2, 5, 6, 8, 9])
  let set_b: set.Set(Int) = set.from_list([0, 2, 3, 4, 5, 7, 9])
  metrics.jaccard_index(set_a, set_b)
  |> should.equal(4.0 /. 10.0)

  let set_c: set.Set(Int) = set.from_list([0, 1, 2, 3, 4, 5])
  let set_d: set.Set(Int) = set.from_list([6, 7, 8, 9, 10])
  metrics.jaccard_index(set_c, set_d)
  |> should.equal(0.0 /. 11.0)

  let set_e: set.Set(String) = set.from_list(["cat", "dog", "hippo", "monkey"])
  let set_f: set.Set(String) =
    set.from_list(["monkey", "rhino", "ostrich", "salmon"])
  metrics.jaccard_index(set_e, set_f)
  |> should.equal(1.0 /. 7.0)
}

pub fn sorensen_dice_coefficient_test() {
  metrics.sorensen_dice_coefficient(set.from_list([]), set.from_list([]))
  |> should.equal(0.0)

  let set_a: set.Set(Int) = set.from_list([0, 1, 2, 5, 6, 8, 9])
  let set_b: set.Set(Int) = set.from_list([0, 2, 3, 4, 5, 7, 9])
  metrics.sorensen_dice_coefficient(set_a, set_b)
  |> should.equal(2.0 *. 4.0 /. { 7.0 +. 7.0 })

  let set_c: set.Set(Int) = set.from_list([0, 1, 2, 3, 4, 5])
  let set_d: set.Set(Int) = set.from_list([6, 7, 8, 9, 10])
  metrics.sorensen_dice_coefficient(set_c, set_d)
  |> should.equal(2.0 *. 0.0 /. { 6.0 +. 5.0 })

  let set_e: set.Set(String) = set.from_list(["cat", "dog", "hippo", "monkey"])
  let set_f: set.Set(String) =
    set.from_list(["monkey", "rhino", "ostrich", "salmon", "spider"])
  metrics.sorensen_dice_coefficient(set_e, set_f)
  |> should.equal(2.0 *. 1.0 /. { 4.0 +. 5.0 })
}

pub fn overlap_coefficient_test() {
  metrics.overlap_coefficient(set.from_list([]), set.from_list([]))
  |> should.equal(0.0)

  let set_a: set.Set(Int) = set.from_list([0, 1, 2, 5, 6, 8, 9])
  let set_b: set.Set(Int) = set.from_list([0, 2, 3, 4, 5, 7, 9])
  metrics.overlap_coefficient(set_a, set_b)
  |> should.equal(4.0 /. 7.0)

  let set_c: set.Set(Int) = set.from_list([0, 1, 2, 3, 4, 5])
  let set_d: set.Set(Int) = set.from_list([6, 7, 8, 9, 10])
  metrics.overlap_coefficient(set_c, set_d)
  |> should.equal(0.0 /. 5.0)

  let set_e: set.Set(String) =
    set.from_list(["horse", "dog", "hippo", "monkey", "bird"])
  let set_f: set.Set(String) =
    set.from_list(["monkey", "bird", "ostrich", "salmon"])
  metrics.overlap_coefficient(set_e, set_f)
  |> should.equal(2.0 /. 4.0)
}

pub fn cosine_similarity_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Empty lists returns an error
  metrics.cosine_similarity([], [], option.None)
  |> should.be_error()

  // One empty list returns an error
  metrics.cosine_similarity([1.0, 2.0, 3.0], [], option.None)
  |> should.be_error()

  // One empty list returns an error
  metrics.cosine_similarity([], [1.0, 2.0, 3.0], option.None)
  |> should.be_error()

  // Different sized lists returns an error
  metrics.cosine_similarity([1.0, 2.0], [1.0, 2.0, 3.0, 4.0], option.None)
  |> should.be_error()

  // Two orthogonal vectors (represented by lists)
  metrics.cosine_similarity([-1.0, 1.0, 0.0], [1.0, 1.0, -1.0], option.None)
  |> should.equal(Ok(0.0))

  // Two identical (parallel) vectors (represented by lists)
  metrics.cosine_similarity([1.0, 2.0, 3.0], [1.0, 2.0, 3.0], option.None)
  |> should.equal(Ok(1.0))

  // Two parallel, but oppositely oriented vectors (represented by lists)
  metrics.cosine_similarity([-1.0, -2.0, -3.0], [1.0, 2.0, 3.0], option.None)
  |> should.equal(Ok(-1.0))

  // Try with arbitrary valid input 
  let assert Ok(result) =
    metrics.cosine_similarity([1.0, 2.0, 3.0], [4.0, 5.0, 6.0], option.None)
  result
  |> predicates.is_close(0.9746318461970762, 0.0, tol)
  |> should.be_true()

  // Try valid input with weights
  let assert Ok(result) =
    metrics.cosine_similarity(
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0],
      option.Some([1.0, 1.0, 1.0]),
    )
  result
  |> predicates.is_close(0.9746318461970762, 0.0, tol)
  |> should.be_true()

  // Try with different weights
  let assert Ok(result) =
    metrics.cosine_similarity(
      [1.0, 2.0, 3.0],
      [4.0, 5.0, 6.0],
      option.Some([1.0, 2.0, 3.0]),
    )
  result
  |> predicates.is_close(0.9855274566525745, 0.0, tol)
  |> should.be_true()

  // Try invalid input with weights (different sized lists returns an error)
  metrics.cosine_similarity(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([7.0, 8.0]),
  )
  |> should.be_error()

  // Try invalid input with weights that are negative
  metrics.cosine_similarity(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([-7.0, -8.0, -9.0]),
  )
  |> should.be_error()
}

pub fn chebyshev_distance_test() {
  // Empty lists returns an error
  metrics.chebyshev_distance([], [])
  |> should.be_error()

  // One empty list returns an error
  metrics.chebyshev_distance([1.0, 2.0, 3.0], [])
  |> should.be_error()

  // One empty list returns an error
  metrics.chebyshev_distance([], [1.0, 2.0, 3.0])
  |> should.be_error()

  // Different sized lists returns an error
  metrics.chebyshev_distance([1.0, 2.0], [1.0, 2.0, 3.0, 4.0])
  |> should.be_error()

  // Try different types of valid input
  metrics.chebyshev_distance([1.0, 0.0], [0.0, 2.0])
  |> should.equal(Ok(2.0))

  metrics.chebyshev_distance([1.0, 0.0], [2.0, 0.0])
  |> should.equal(Ok(1.0))

  metrics.chebyshev_distance([1.0, 0.0], [-2.0, 0.0])
  |> should.equal(Ok(3.0))

  metrics.chebyshev_distance([-5.0, -10.0, -3.0], [-1.0, -12.0, -3.0])
  |> should.equal(Ok(4.0))

  metrics.chebyshev_distance([1.0, 2.0, 3.0], [1.0, 2.0, 3.0])
  |> should.equal(Ok(0.0))
}

pub fn levenshtein_distance_test() {
  // Try different types of valid input...

  // Requires 5 insertions to transform the empty string into "hello"
  metrics.levenshtein_distance("", "hello")
  |> should.equal(5)
  // Requires 5 deletions to remove all characters from "hello" to match the empty string
  metrics.levenshtein_distance("hello", "")
  |> should.equal(5)

  // Requires 2 deletions to remove two 'b's and 1 substitution to change 'b' to 'a'
  metrics.levenshtein_distance("bbb", "a")
  |> should.equal(3)
  // Requires 2 insertions to add two 'b's and 1 substitution to change 'a' to 'b'
  metrics.levenshtein_distance("a", "bbb")
  |> should.equal(3)

  // No changes needed, since the strings are identical
  metrics.levenshtein_distance("hello", "hello")
  |> should.equal(0)

  // Requires 1 substitution to change 'a' to 'u'
  metrics.levenshtein_distance("cat", "cut")
  |> should.equal(1)

  // Requires 2 substitutions (k -> s, e -> i) and 1 insertion (g at the end)
  metrics.levenshtein_distance("kitten", "sitting")
  |> should.equal(3)

  // Some more complex cases, involving multiple insertions, deletions, and substitutions
  metrics.levenshtein_distance("gggtatccat", "cctaggtccct")
  |> should.equal(6)

  metrics.levenshtein_distance(
    "This is a longer string",
    "This is also a much longer string",
  )
  |> should.equal(10)
}

pub fn canberra_distance_test() {
  // Empty lists returns an error
  metrics.canberra_distance([], [], option.None)
  |> should.be_error()

  // One empty list returns an error
  metrics.canberra_distance([1.0, 2.0, 3.0], [], option.None)
  |> should.be_error()

  // One empty list returns an error
  metrics.canberra_distance([], [1.0, 2.0, 3.0], option.None)
  |> should.be_error()

  // Different sized lists returns an error
  metrics.canberra_distance([1.0, 2.0], [1.0, 2.0, 3.0, 4.0], option.None)
  |> should.be_error()

  // Try different types of valid input
  metrics.canberra_distance([0.0, 0.0], [0.0, 0.0], option.None)
  |> should.equal(Ok(0.0))

  metrics.canberra_distance([1.0, 2.0], [-2.0, -1.0], option.None)
  |> should.equal(Ok(2.0))

  metrics.canberra_distance([1.0, 0.0], [0.0, 2.0], option.None)
  |> should.equal(Ok(2.0))

  metrics.canberra_distance([1.0, 0.0], [2.0, 0.0], option.None)
  |> should.equal(Ok(1.0 /. 3.0))

  metrics.canberra_distance([1.0, 0.0], [0.0, 2.0], option.Some([1.0, 1.0]))
  |> should.equal(Ok(2.0))

  metrics.canberra_distance([1.0, 0.0], [0.0, 2.0], option.Some([1.0, 0.5]))
  |> should.equal(Ok(1.5))

  metrics.canberra_distance([1.0, 0.0], [0.0, 2.0], option.Some([0.5, 0.5]))
  |> should.equal(Ok(1.0))

  // Different sized lists (weights) returns an error
  metrics.canberra_distance(
    [1.0, 2.0, 3.0],
    [1.0, 2.0, 3.0],
    option.Some([1.0]),
  )
  |> should.be_error()

  // Try invalid input with weights that are negative
  metrics.canberra_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([-7.0, -8.0, -9.0]),
  )
  |> should.be_error()
}

pub fn braycurtis_distance_test() {
  // Empty lists returns an error
  metrics.braycurtis_distance([], [], option.None)
  |> should.be_error()

  // One empty list returns an error
  metrics.braycurtis_distance([1.0, 2.0, 3.0], [], option.None)
  |> should.be_error()

  // One empty list returns an error
  metrics.braycurtis_distance([], [1.0, 2.0, 3.0], option.None)
  |> should.be_error()

  // Different sized lists returns an error
  metrics.braycurtis_distance([1.0, 2.0], [1.0, 2.0, 3.0, 4.0], option.None)
  |> should.be_error()

  // Try different types of valid input
  metrics.braycurtis_distance([0.0, 0.0], [0.0, 0.0], option.None)
  |> should.equal(Ok(0.0))

  metrics.braycurtis_distance([1.0, 2.0], [-2.0, -1.0], option.None)
  |> should.equal(Ok(3.0))

  metrics.braycurtis_distance([1.0, 0.0], [0.0, 2.0], option.None)
  |> should.equal(Ok(1.0))

  metrics.braycurtis_distance([1.0, 2.0], [3.0, 4.0], option.None)
  |> should.equal(Ok(0.4))

  metrics.braycurtis_distance([1.0, 2.0], [3.0, 4.0], option.Some([1.0, 1.0]))
  |> should.equal(Ok(0.4))

  metrics.braycurtis_distance([1.0, 2.0], [3.0, 4.0], option.Some([0.5, 1.0]))
  |> should.equal(Ok(0.375))

  metrics.braycurtis_distance([1.0, 2.0], [3.0, 4.0], option.Some([0.25, 0.25]))
  |> should.equal(Ok(0.4))

  // Different sized lists (weights) returns an error
  metrics.braycurtis_distance(
    [1.0, 2.0, 3.0],
    [1.0, 2.0, 3.0],
    option.Some([1.0]),
  )
  |> should.be_error()

  // Try invalid input with weights that are negative
  metrics.braycurtis_distance(
    [1.0, 2.0, 3.0],
    [4.0, 5.0, 6.0],
    option.Some([-7.0, -8.0, -9.0]),
  )
  |> should.be_error()
}
