import gleam/float
import gleam/set
import gleam_community/maths
import gleeunit/should

pub fn list_norm_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // An empty lists returns 0.0
  []
  |> maths.norm(1.0)
  |> should.equal(Ok(0.0))

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) =
    [1.0, 1.0, 1.0]
    |> maths.norm(1.0)
  result
  |> maths.is_close(3.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [1.0, 1.0, 1.0]
    |> maths.norm(-1.0)
  result
  |> maths.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -1.0, -1.0]
    |> maths.norm(-1.0)
  result
  |> maths.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -1.0, -1.0]
    |> maths.norm(1.0)
  result
  |> maths.is_close(3.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -2.0, -3.0]
    |> maths.norm(-10.0)
  result
  |> maths.is_close(0.9999007044905545, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -2.0, -3.0]
    |> maths.norm(-100.0)
  result
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [-1.0, -2.0, -3.0]
    |> maths.norm(2.0)
  result
  |> maths.is_close(3.7416573867739413, 0.0, tol)
  |> should.be_true()
}

pub fn list_norm_with_weights_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // An empty lists returns 0.0
  []
  |> maths.norm_with_weights(1.0)
  |> should.equal(Ok(0.0))

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) =
    [#(1.0, 1.0), #(1.0, 1.0), #(1.0, 1.0)]
    |> maths.norm_with_weights(1.0)
  result
  |> maths.is_close(3.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [#(1.0, 0.5), #(1.0, 0.5), #(1.0, 0.5)]
    |> maths.norm_with_weights(1.0)
  result
  |> maths.is_close(1.5, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [#(1.0, 0.5), #(2.0, 0.5), #(3.0, 0.5)]
    |> maths.norm_with_weights(2.0)
  result
  |> maths.is_close(2.6457513110645907, 0.0, tol)
  |> should.be_true()
}

pub fn list_manhattan_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Try with valid input (same as Minkowski distance with p = 1)
  let assert Ok(result) = maths.manhattan_distance([#(0.0, 1.0), #(0.0, 2.0)])
  result
  |> maths.is_close(3.0, 0.0, tol)
  |> should.be_true()

  maths.manhattan_distance([#(1.0, 4.0), #(2.0, 5.0), #(3.0, 6.0)])
  |> should.equal(Ok(9.0))

  maths.manhattan_distance([#(1.0, 2.0), #(2.0, 3.0)])
  |> should.equal(Ok(2.0))

  maths.manhattan_distance_with_weights([#(1.0, 2.0, 0.5), #(2.0, 3.0, 1.0)])
  |> should.equal(Ok(1.5))

  maths.manhattan_distance_with_weights([
    #(1.0, 4.0, 1.0),
    #(2.0, 5.0, 1.0),
    #(3.0, 6.0, 1.0),
  ])
  |> should.equal(Ok(9.0))

  maths.manhattan_distance_with_weights([
    #(1.0, 4.0, 1.0),
    #(2.0, 5.0, 2.0),
    #(3.0, 6.0, 3.0),
  ])
  |> should.equal(Ok(18.0))

  maths.manhattan_distance_with_weights([
    #(1.0, 4.0, -7.0),
    #(2.0, 5.0, -8.0),
    #(3.0, 6.0, -9.0),
  ])
  |> should.be_error()
}

pub fn list_minkowski_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Test order < 1
  maths.minkowski_distance([#(0.0, 0.0), #(0.0, 0.0)], -1.0)
  |> should.be_error()

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) =
    maths.minkowski_distance([#(1.0, 1.0), #(1.0, 1.0)], 1.0)
  result
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.minkowski_distance([#(0.0, 1.0), #(0.0, 1.0)], 10.0)
  result
  |> maths.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.minkowski_distance([#(0.0, 1.0), #(0.0, 1.0)], 100.0)
  result
  |> maths.is_close(1.0069555500567189, 0.0, tol)
  |> should.be_true()

  // Euclidean distance (p = 2)
  let assert Ok(result) =
    maths.minkowski_distance([#(0.0, 1.0), #(0.0, 2.0)], 2.0)
  result
  |> maths.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()

  // Manhattan distance (p = 1)
  let assert Ok(result) =
    maths.minkowski_distance([#(0.0, 1.0), #(0.0, 2.0)], 1.0)
  result
  |> maths.is_close(3.0, 0.0, tol)
  |> should.be_true()

  // Try different valid input
  let assert Ok(result) =
    maths.minkowski_distance([#(1.0, 4.0), #(2.0, 5.0), #(3.0, 6.0)], 4.0)
  result
  |> maths.is_close(3.9482220388574776, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.minkowski_distance_with_weights(
      [#(1.0, 4.0, 1.0), #(2.0, 5.0, 1.0), #(3.0, 6.0, 1.0)],
      4.0,
    )
  result
  |> maths.is_close(3.9482220388574776, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.minkowski_distance_with_weights(
      [#(1.0, 4.0, 1.0), #(2.0, 5.0, 2.0), #(3.0, 6.0, 3.0)],
      4.0,
    )
  result
  |> maths.is_close(4.6952537402198615, 0.0, tol)
  |> should.be_true()

  // Try invalid input with weights that are negative
  maths.minkowski_distance_with_weights(
    [#(1.0, 4.0, -7.0), #(2.0, 5.0, -8.0), #(3.0, 6.0, -9.0)],
    2.0,
  )
  |> should.be_error()
}

pub fn list_euclidean_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Empty lists returns an error
  maths.euclidean_distance([])
  |> should.be_error()

  // Try with valid input (same as Minkowski distance with p = 2)
  let assert Ok(result) = maths.euclidean_distance([#(0.0, 1.0), #(0.0, 2.0)])
  result
  |> maths.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()

  // Try different valid input
  let assert Ok(result) =
    maths.euclidean_distance([#(1.0, 4.0), #(2.0, 5.0), #(3.0, 6.0)])
  result
  |> maths.is_close(5.196152422706632, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.euclidean_distance_with_weights([
      #(1.0, 4.0, 1.0),
      #(2.0, 5.0, 1.0),
      #(3.0, 6.0, 1.0),
    ])
  result
  |> maths.is_close(5.196152422706632, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.euclidean_distance_with_weights([
      #(1.0, 4.0, 1.0),
      #(2.0, 5.0, 2.0),
      #(3.0, 6.0, 3.0),
    ])
  result
  |> maths.is_close(7.3484692283495345, 0.0, tol)
  |> should.be_true()

  // Try invalid input with weights that are negative
  maths.euclidean_distance_with_weights([
    #(1.0, 4.0, -7.0),
    #(2.0, 5.0, -8.0),
    #(3.0, 6.0, -9.0),
  ])
  |> should.be_error()
}

pub fn mean_test() {
  // An empty list returns an error
  []
  |> maths.mean()
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.mean()
  |> should.equal(Ok(2.0))

  [-1.0, -2.0, -3.0]
  |> maths.mean()
  |> should.equal(Ok(-2.0))
}

pub fn median_test() {
  // An empty list returns an error
  []
  |> maths.median()
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.median()
  |> should.equal(Ok(2.0))

  [1.0, 2.0, 3.0, 4.0]
  |> maths.median()
  |> should.equal(Ok(2.5))
}

pub fn variance_test() {
  // Degrees of freedom
  let ddof = 1

  // An empty list returns an error
  []
  |> maths.variance(ddof)
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.variance(ddof)
  |> should.equal(Ok(1.0))
}

pub fn standard_deviation_test() {
  // Degrees of freedom
  let ddof = 1

  // An empty list returns an error
  []
  |> maths.standard_deviation(ddof)
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.standard_deviation(ddof)
  |> should.equal(Ok(1.0))
}

pub fn jaccard_index_test() {
  maths.jaccard_index(set.from_list([]), set.from_list([]))
  |> should.equal(0.0)

  let set_a = set.from_list([0, 1, 2, 5, 6, 8, 9])
  let set_b = set.from_list([0, 2, 3, 4, 5, 7, 9])
  maths.jaccard_index(set_a, set_b)
  |> should.equal(4.0 /. 10.0)

  let set_c = set.from_list([0, 1, 2, 3, 4, 5])
  let set_d = set.from_list([6, 7, 8, 9, 10])
  maths.jaccard_index(set_c, set_d)
  |> should.equal(0.0 /. 11.0)

  let set_e = set.from_list(["cat", "dog", "hippo", "monkey"])
  let set_f = set.from_list(["monkey", "rhino", "ostrich", "salmon"])
  maths.jaccard_index(set_e, set_f)
  |> should.equal(1.0 /. 7.0)
}

pub fn sorensen_dice_coefficient_test() {
  maths.sorensen_dice_coefficient(set.from_list([]), set.from_list([]))
  |> should.equal(0.0)

  let set_a = set.from_list([0, 1, 2, 5, 6, 8, 9])
  let set_b = set.from_list([0, 2, 3, 4, 5, 7, 9])
  maths.sorensen_dice_coefficient(set_a, set_b)
  |> should.equal(2.0 *. 4.0 /. { 7.0 +. 7.0 })

  let set_c = set.from_list([0, 1, 2, 3, 4, 5])
  let set_d = set.from_list([6, 7, 8, 9, 10])
  maths.sorensen_dice_coefficient(set_c, set_d)
  |> should.equal(2.0 *. 0.0 /. { 6.0 +. 5.0 })

  let set_e = set.from_list(["cat", "dog", "hippo", "monkey"])
  let set_f = set.from_list(["monkey", "rhino", "ostrich", "salmon", "spider"])
  maths.sorensen_dice_coefficient(set_e, set_f)
  |> should.equal(2.0 *. 1.0 /. { 4.0 +. 5.0 })
}

pub fn overlap_coefficient_test() {
  maths.overlap_coefficient(set.from_list([]), set.from_list([]))
  |> should.equal(0.0)

  let set_a = set.from_list([0, 1, 2, 5, 6, 8, 9])
  let set_b = set.from_list([0, 2, 3, 4, 5, 7, 9])
  maths.overlap_coefficient(set_a, set_b)
  |> should.equal(4.0 /. 7.0)

  let set_c = set.from_list([0, 1, 2, 3, 4, 5])
  let set_d = set.from_list([6, 7, 8, 9, 10])
  maths.overlap_coefficient(set_c, set_d)
  |> should.equal(0.0 /. 5.0)

  let set_e = set.from_list(["horse", "dog", "hippo", "monkey", "bird"])
  let set_f = set.from_list(["monkey", "bird", "ostrich", "salmon"])
  maths.overlap_coefficient(set_e, set_f)
  |> should.equal(2.0 /. 4.0)
}

pub fn cosine_similarity_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Two orthogonal vectors (represented by lists)
  maths.cosine_similarity([#(-1.0, 1.0), #(1.0, 1.0), #(0.0, -1.0)])
  |> should.equal(Ok(0.0))

  // Two identical (parallel) vectors (represented by lists)
  maths.cosine_similarity([#(1.0, 1.0), #(2.0, 2.0), #(3.0, 3.0)])
  |> should.equal(Ok(1.0))

  // Two parallel, but oppositely oriented vectors (represented by lists)
  maths.cosine_similarity([#(-1.0, 1.0), #(-2.0, 2.0), #(-3.0, 3.0)])
  |> should.equal(Ok(-1.0))

  // Try with arbitrary valid input
  let assert Ok(result) =
    maths.cosine_similarity([#(1.0, 4.0), #(2.0, 5.0), #(3.0, 6.0)])
  result
  |> maths.is_close(0.9746318461970762, 0.0, tol)
  |> should.be_true()

  // Try valid input with weights
  let assert Ok(result) =
    maths.cosine_similarity_with_weights([
      #(1.0, 4.0, 1.0),
      #(2.0, 5.0, 1.0),
      #(3.0, 6.0, 1.0),
    ])
  result
  |> maths.is_close(0.9746318461970762, 0.0, tol)
  |> should.be_true()

  // Try with different weights
  let assert Ok(result) =
    maths.cosine_similarity_with_weights([
      #(1.0, 4.0, 1.0),
      #(2.0, 5.0, 2.0),
      #(3.0, 6.0, 3.0),
    ])
  result
  |> maths.is_close(0.9855274566525745, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.cosine_similarity_with_weights([
      #(1.0, 1.0, 2.0),
      #(2.0, 2.0, 3.0),
      #(3.0, 3.0, 4.0),
    ])
  result
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    maths.cosine_similarity_with_weights([
      #(-1.0, 1.0, 1.0),
      #(-2.0, 2.0, 0.5),
      #(-3.0, 3.0, 0.33),
    ])
  result
  |> maths.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  // Try invalid input with weights that are negative
  maths.cosine_similarity_with_weights([
    #(1.0, 4.0, -7.0),
    #(2.0, 5.0, -8.0),
    #(3.0, 6.0, -9.0),
  ])
  |> should.be_error()
}

pub fn chebyshev_distance_test() {
  // Empty lists returns an error
  maths.chebyshev_distance([])
  |> should.be_error()

  // Try different types of valid input
  maths.chebyshev_distance([#(1.0, 0.0), #(0.0, 2.0)])
  |> should.equal(Ok(2.0))

  maths.chebyshev_distance([#(1.0, 2.0), #(0.0, 0.0)])
  |> should.equal(Ok(1.0))

  maths.chebyshev_distance([#(1.0, -2.0), #(0.0, 0.0)])
  |> should.equal(Ok(3.0))

  maths.chebyshev_distance([#(-5.0, -1.0), #(-10.0, -12.0), #(-3.0, -3.0)])
  |> should.equal(Ok(4.0))

  maths.chebyshev_distance([#(1.0, 1.0), #(2.0, 2.0), #(3.0, 3.0)])
  |> should.equal(Ok(0.0))

  maths.chebyshev_distance_with_weights([
    #(-5.0, -1.0, 0.5),
    #(-10.0, -12.0, 1.0),
    #(-3.0, -3.0, 1.0),
  ])
  |> should.equal(Ok(2.0))
}

pub fn canberra_distance_test() {
  // Empty lists returns an error
  maths.canberra_distance([])
  |> should.be_error()

  // Try different types of valid input
  maths.canberra_distance([#(0.0, 0.0), #(0.0, 0.0)])
  |> should.equal(Ok(0.0))

  maths.canberra_distance([#(1.0, -2.0), #(2.0, -1.0)])
  |> should.equal(Ok(2.0))

  maths.canberra_distance([#(1.0, 0.0), #(0.0, 2.0)])
  |> should.equal(Ok(2.0))

  maths.canberra_distance([#(1.0, 2.0), #(0.0, 0.0)])
  |> should.equal(Ok(1.0 /. 3.0))

  maths.canberra_distance_with_weights([#(1.0, 0.0, 1.0), #(0.0, 2.0, 1.0)])
  |> should.equal(Ok(2.0))

  maths.canberra_distance_with_weights([#(1.0, 0.0, 1.0), #(0.0, 2.0, 0.5)])
  |> should.equal(Ok(1.5))

  maths.canberra_distance_with_weights([#(1.0, 0.0, 0.5), #(0.0, 2.0, 0.5)])
  |> should.equal(Ok(1.0))

  // Try invalid input with weights that are negative
  maths.canberra_distance_with_weights([
    #(1.0, 4.0, -7.0),
    #(2.0, 5.0, -8.0),
    #(3.0, 6.0, -9.0),
  ])
  |> should.be_error()
}

pub fn braycurtis_distance_test() {
  // Empty lists returns an error
  maths.braycurtis_distance([])
  |> should.be_error()

  // Try different types of valid input
  maths.braycurtis_distance([#(0.0, 0.0), #(0.0, 0.0)])
  |> should.equal(Ok(0.0))
  maths.braycurtis_distance([#(1.0, -2.0), #(2.0, -1.0)])
  |> should.equal(Ok(3.0))

  maths.braycurtis_distance([#(1.0, 0.0), #(0.0, 2.0)])
  |> should.equal(Ok(1.0))

  maths.braycurtis_distance([#(1.0, 3.0), #(2.0, 4.0)])
  |> should.equal(Ok(0.4))

  maths.braycurtis_distance_with_weights([#(1.0, 3.0, 1.0), #(2.0, 4.0, 1.0)])
  |> should.equal(Ok(0.4))

  maths.braycurtis_distance_with_weights([#(1.0, 3.0, 0.5), #(2.0, 4.0, 1.0)])
  |> should.equal(Ok(0.375))

  maths.braycurtis_distance_with_weights([#(1.0, 3.0, 0.25), #(2.0, 4.0, 0.25)])
  |> should.equal(Ok(0.4))
  // Try invalid input with weights that are negative
  maths.braycurtis_distance_with_weights([
    #(1.0, 4.0, -7.0),
    #(2.0, 5.0, -8.0),
    #(3.0, 6.0, -9.0),
  ])
  |> should.be_error()
}
