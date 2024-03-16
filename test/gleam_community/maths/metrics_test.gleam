import gleam_community/maths/elementary
import gleam_community/maths/metrics
import gleam_community/maths/predicates
import gleeunit/should
import gleam/set

pub fn float_list_norm_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // An empty lists returns 0.0
  []
  |> metrics.norm(1.0)
  |> should.equal(0.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  [1.0, 1.0, 1.0]
  |> metrics.norm(1.0)
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()

  [1.0, 1.0, 1.0]
  |> metrics.norm(-1.0)
  |> predicates.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  [-1.0, -1.0, -1.0]
  |> metrics.norm(-1.0)
  |> predicates.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  [-1.0, -1.0, -1.0]
  |> metrics.norm(1.0)
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()

  [-1.0, -2.0, -3.0]
  |> metrics.norm(-10.0)
  |> predicates.is_close(0.9999007044905545, 0.0, tol)
  |> should.be_true()

  [-1.0, -2.0, -3.0]
  |> metrics.norm(-100.0)
  |> predicates.is_close(1.0, 0.0, tol)
  |> should.be_true()

  [-1.0, -2.0, -3.0]
  |> metrics.norm(2.0)
  |> predicates.is_close(3.7416573867739413, 0.0, tol)
  |> should.be_true()
}

pub fn float_list_manhatten_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Empty lists returns 0.0
  metrics.manhatten_distance([], [])
  |> should.equal(Ok(0.0))

  // Differing lengths returns error
  metrics.manhatten_distance([], [1.0])
  |> should.be_error()

  // Manhatten distance (p = 1)
  let assert Ok(result) = metrics.manhatten_distance([0.0, 0.0], [1.0, 2.0])
  result
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()
}

// pub fn int_list_manhatten_test() {
//   // Empty lists returns 0
//   metrics.int_manhatten_distance([], [])
//   |> should.equal(Ok(0))

//   // Differing lengths returns error
//   metrics.int_manhatten_distance([], [1])
//   |> should.be_error()

//   let assert Ok(result) = metrics.int_manhatten_distance([0, 0], [1, 2])
//   result
//   |> should.equal(3)
// }

pub fn float_list_minkowski_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Empty lists returns 0.0
  metrics.minkowski_distance([], [], 1.0)
  |> should.equal(Ok(0.0))

  // Differing lengths returns error
  metrics.minkowski_distance([], [1.0], 1.0)
  |> should.be_error()

  // Test order < 1
  metrics.minkowski_distance([0.0, 0.0], [0.0, 0.0], -1.0)
  |> should.be_error()

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) =
    metrics.minkowski_distance([1.0, 1.0], [1.0, 1.0], 1.0)
  result
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0)
  result
  |> predicates.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 1.0], 100.0)
  result
  |> predicates.is_close(1.0069555500567189, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0)
  result
  |> predicates.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  // Euclidean distance (p = 2)
  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 2.0], 2.0)
  result
  |> predicates.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()

  // Manhatten distance (p = 1)
  let assert Ok(result) =
    metrics.minkowski_distance([0.0, 0.0], [1.0, 2.0], 1.0)
  result
  |> predicates.is_close(3.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_list_euclidean_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Empty lists returns 0.0
  metrics.euclidean_distance([], [])
  |> should.equal(Ok(0.0))

  // Differing lengths returns error
  metrics.euclidean_distance([], [1.0])
  |> should.be_error()

  // Euclidean distance (p = 2)
  let assert Ok(result) = metrics.euclidean_distance([0.0, 0.0], [1.0, 2.0])
  result
  |> predicates.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()
}

pub fn example_mean_test() {
  // An empty list returns an error
  []
  |> metrics.mean()
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> metrics.mean()
  |> should.equal(Ok(2.0))
}

pub fn example_median_test() {
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

pub fn example_variance_test() {
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

pub fn example_standard_deviation_test() {
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

pub fn example_jaccard_index_test() {
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

pub fn example_overlap_coefficient_test() {
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
    set.from_list(["cat", "dog", "hippo", "monkey", "rhino"])
  let set_f: set.Set(String) =
    set.from_list(["monkey", "rhino", "ostrich", "salmon"])
  metrics.overlap_coefficient(set_e, set_f)
  |> should.equal(2.0 /. 4.0)
}
