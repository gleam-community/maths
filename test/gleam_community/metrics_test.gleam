import gleam/float
import gleam/int
import gleam/list
import gleam/set
import gleam_community/maths
import gleeunit/should

fn norm_test_cases() {
  // Tuples of #(list, norm, expected result)
  [
    // An empty list will always return 0.0
    #([], 1.0, 0.0),
    #([1.0, 1.0, 1.0], 1.0, 3.0),
    // Check the special case: 
    // The pseudo-norm when p = 0 (we count the number of non-zero elements in the given list)
    #([1.0, 1.0, 1.0], 0.0, 3.0),
    #([1.0, 1.0, 1.0], -1.0, 0.3333333333333333),
    #([-1.0, -1.0, -1.0], -1.0, 0.3333333333333333),
    // Check if we internally correctly remember to take the absolute
    // value of each of the list elements
    #([-1.0, -1.0, -1.0], 1.0, 3.0),
    #([-1.0, -1.0, -1.0], 0.5, 9.0),
    #([0.0, 0.0, 0.0], 1.0, 0.0),
    // Check if we internally handle division by zero appropriately 
    #([0.0], -1.0, 0.0),
    #([1.0, 2.0, 3.0, 0.0], -1.0, 0.0),
    #([-1.0, -2.0, -3.0], -10.0, 0.9999007044905545),
    #([-1.0, -2.0, -3.0], -100.0, 1.0),
    // Test the Euclidean norm (p = 2)
    #([-1.0, -2.0, -3.0], 2.0, 3.7416573867739413),
  ]
}

pub fn list_norm_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  norm_test_cases()
  |> list.map(fn(tuple) {
    let #(arr, p, expected) = tuple
    let assert Ok(result) = maths.norm(arr, p)
    result |> maths.is_close(expected, 0.0, tol) |> should.be_true()
  })
}

pub fn list_norm_with_weights_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Check that the weighted version of the norm function aligns with the
  // non-weighted version by re-using the test cases for the non-weighted 
  // version by associating a weight of 1.0 to each elemet of the input lists
  norm_test_cases()
  |> list.map(fn(tuple) {
    let #(arr, p, expected) = tuple
    let new_arr = list.map(arr, fn(element) { #(element, 1.0) })
    let assert Ok(result) = maths.norm_with_weights(new_arr, p)
    result |> maths.is_close(expected, 0.0, tol)
  })

  // Check that the function agrees, at some additional arbitrary input points
  // with known function values
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

pub fn moment_test() {
  // An empty list returns an error
  []
  |> maths.moment(0)
  |> should.be_error()

  [1.0, 2.0, 3.0]
  |> maths.moment(-1)
  |> should.be_error()

  [2.0]
  |> maths.moment(0)
  |> should.equal(Ok(1.0))

  [2.0]
  |> maths.moment(1)
  |> should.equal(Ok(0.0))

  [2.0]
  |> maths.moment(2)
  |> should.equal(Ok(0.0))

  // 0th moment about the mean is 1. per definition
  [0.0, 1.0, 2.0, 3.0, 4.0]
  |> maths.moment(0)
  |> should.equal(Ok(1.0))

  // 1st moment about the mean is 0. per definition
  [0.0, 1.0, 2.0, 3.0, 4.0]
  |> maths.moment(1)
  |> should.equal(Ok(0.0))

  // 2nd moment about the mean
  [0.0, 1.0, 2.0, 3.0, 4.0]
  |> maths.moment(2)
  |> should.equal(Ok(2.0))
}

pub fn mean_test() {
  // An empty list returns an error
  []
  |> maths.mean()
  |> should.be_error()

  // Valid input returns a result

  [5.0]
  |> maths.mean()
  |> should.equal(Ok(5.0))

  [1.0, 2.0, 3.0]
  |> maths.mean()
  |> should.equal(Ok(2.0))

  [-1.0, -2.0, -3.0]
  |> maths.mean()
  |> should.equal(Ok(-2.0))
}

pub fn harmonic_mean_test() {
  // An empty list returns an error
  []
  |> maths.harmonic_mean()
  |> should.be_error()

  [1.0, 2.0, 0.0]
  |> maths.harmonic_mean()
  |> should.equal(Ok(0.0))

  // List with negative numbers returns an error
  [-1.0, -3.0, -6.0]
  |> maths.harmonic_mean()
  |> should.be_error()

  // Valid input returns a result
  [4.0]
  |> maths.harmonic_mean()
  |> should.equal(Ok(4.0))

  [1.0, 3.0, 6.0]
  |> maths.harmonic_mean()
  |> should.equal(Ok(2.0))
}

pub fn geometric_mean_test() {
  // An empty list returns an error
  []
  |> maths.geometric_mean()
  |> should.be_error()

  // List with negative numbers returns an error
  [-1.0, -3.0, -6.0]
  |> maths.geometric_mean()
  |> should.be_error()

  // Valid input returns a result
  [5.0]
  |> maths.geometric_mean()
  |> should.equal(Ok(5.0))

  [1.0, 2.0, 0.0]
  |> maths.geometric_mean()
  |> should.equal(Ok(0.0))

  [1.0, 3.0, 9.0]
  |> maths.geometric_mean()
  |> should.equal(Ok(3.0))
}

pub fn median_test() {
  // An empty list returns an error
  []
  |> maths.median()
  |> should.be_error()

  // A single-element list returns the element itself
  [42.0]
  |> maths.median()
  |> should.equal(Ok(42.0))

  // A two-element list returns the average of the two elements
  [10.0, 20.0]
  |> maths.median()
  |> should.equal(Ok(15.0))

  // An odd-length list returns the middle element
  [1.0, 3.0, 5.0]
  |> maths.median()
  |> should.equal(Ok(3.0))

  // An even-length list returns the average of the middle two elements
  [1.0, 2.0, 3.0, 4.0]
  |> maths.median()
  |> should.equal(Ok(2.5))

  // Make sure an unsorted list is sorted before calculating the median
  [9.0, 1.0, 4.0, 2.0, 8.0]
  |> maths.median()
  |> should.equal(Ok(4.0))

  [8.0, 2.0, 4.0, 1.0, 9.0]
  |> maths.median()
  |> should.equal(Ok(4.0))

  [4.0, 8.0, 9.0, 2.0, 1.0]
  |> maths.median()
  |> should.equal(Ok(4.0))
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

pub fn kurtosis_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // An empty list returns an error
  []
  |> maths.kurtosis()
  |> should.be_error()

  // To calculate kurtosis at least four values are needed, so
  // test that we receive an error with list of size 1, 2, 3, 4. 
  [1.0]
  |> maths.kurtosis()
  |> should.be_error()

  [1.0, 2.0]
  |> maths.kurtosis()
  |> should.be_error()

  [1.0, 2.0, 3.0]
  |> maths.kurtosis()
  |> should.be_error()

  [1.0, 2.0, 3.0, 4.0]
  |> maths.kurtosis()
  |> should.equal(Ok(-1.36))

  // Try with a homogeneous list (variance is zero, so kurtosis is undefined)
  [1.0, 1.0, 1.0, 1.0]
  |> maths.kurtosis()
  |> should.be_error()

  // Try with another non-homogeneous list
  let assert Ok(result) =
    [1.0, 1.0, 1.0, 2.0]
    |> maths.kurtosis()
  result
  |> maths.is_close(-0.666666666666666, 0.0, tol)
  |> should.be_true()

  // Try with a larger input list 
  let assert Ok(result) =
    [6.0, 7.0, 5.0, 7.0, 5.0, 4.0, 4.0, 6.0, 1.0, 3.0, 2.0, 8.0]
    |> maths.kurtosis()
  result
  |> maths.is_close(-0.8548263591730101, 0.0, tol)
  |> should.be_true()
}

pub fn skewness_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // An empty list returns an error
  []
  |> maths.skewness()
  |> should.be_error()

  // To calculate skewness at least three values are needed, so
  // test that we receive an error with list of size 1, 2, 3. 
  [1.0]
  |> maths.skewness()
  |> should.be_error()

  [1.0, 2.0]
  |> maths.skewness()
  |> should.be_error()

  // No skewness (zero skewness)
  [1.0, 2.0, 3.0]
  |> maths.skewness()
  |> should.equal(Ok(0.0))

  [1.0, 2.0, 3.0, 4.0]
  |> maths.skewness()
  |> should.equal(Ok(0.0))

  [1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 2.0, 3.0, 3.0, 4.0]
  |> maths.skewness()
  |> should.equal(Ok(0.6))

  // Try with a homogeneous list (variance is zero, so skewness is undefined)
  [1.0, 1.0, 1.0, 1.0]
  |> maths.skewness()
  |> should.be_error()

  // Try with another non-homogeneous list
  let assert Ok(result) =
    [1.0, 1.0, 1.0, 2.0]
    |> maths.skewness()
  result
  |> maths.is_close(1.1547005383792515, 0.0, tol)
  |> should.be_true()

  // Try with a larger input list 
  let assert Ok(result) =
    [6.0, 7.0, 5.0, 7.0, 5.0, 4.0, 4.0, 6.0, 1.0, 3.0, 2.0, 8.0]
    |> maths.skewness()
  result
  |> maths.is_close(-0.3078992452957464, 0.0, tol)
  |> should.be_true()
}

pub fn percentile_test() {
  // An empty list returns an error
  []
  |> maths.percentile(40)
  |> should.be_error()

  // Percentile 0 (minimum value)
  [15.0, 20.0, 35.0, 40.0, 50.0]
  |> maths.percentile(0)
  |> should.equal(Ok(15.0))

  // Calculate 40th percentile 
  [15.0, 20.0, 35.0, 40.0, 50.0]
  |> maths.percentile(40)
  |> should.equal(Ok(29.0))

  // Percentile 100 (maximum value)
  [15.0, 20.0, 35.0, 40.0, 50.0]
  |> maths.percentile(100)
  |> should.equal(Ok(50.0))

  // Percentile 40 (interpolated value)
  [15.0, 20.0, 35.0, 40.0, 50.0]
  |> maths.percentile(40)
  |> should.equal(Ok(29.0))

  // Percentile for a single-element list (always returns the element)
  [25.0]
  |> maths.percentile(0)
  |> should.equal(Ok(25.0))

  [25.0]
  |> maths.percentile(50)
  |> should.equal(Ok(25.0))

  [25.0]
  |> maths.percentile(100)
  |> should.equal(Ok(25.0))

  // Percentile 50 (median) for an even-length list
  [10.0, 20.0, 30.0, 40.0]
  |> maths.percentile(50)
  // Interpolates between 20.0 and 30.0
  |> should.equal(Ok(25.0))

  // Percentile 50 (median) for an odd-length list
  [10.0, 20.0, 30.0, 40.0, 50.0]
  |> maths.percentile(50)
  // Middle value
  |> should.equal(Ok(30.0))

  // Percentile 25 (lower quartile)
  [10.0, 20.0, 30.0, 40.0, 50.0]
  |> maths.percentile(25)
  |> should.equal(Ok(20.0))

  // Percentile 75 (upper quartile)
  [10.0, 20.0, 30.0, 40.0, 50.0]
  |> maths.percentile(75)
  |> should.equal(Ok(40.0))

  // Percentile for a two-element list (interpolation)
  [10.0, 20.0]
  |> maths.percentile(50)
  // Interpolates between 10.0 and 20.0
  |> should.equal(Ok(15.0))

  // Percentile outside valid range (negative percentile)
  [10.0, 20.0, 30.0]
  |> maths.percentile(-10)
  |> should.be_error()

  // Percentile outside valid range (greater than 100)
  [10.0, 20.0, 30.0]
  |> maths.percentile(110)
  |> should.be_error()

  // Percentile 0 and 100 for an unsorted list (valid result after sorting)
  [50.0, 20.0, 40.0, 10.0, 30.0]
  |> maths.percentile(0)
  // Minimum after sorting
  |> should.equal(Ok(10.0))

  [50.0, 20.0, 40.0, 10.0, 30.0]
  |> maths.percentile(100)
  // Maximum after sorting
  |> should.equal(Ok(50.0))
}

pub fn zscore_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // An empty list returns an error
  []
  // Use degrees of freedom = 1
  |> maths.zscore(1)
  |> should.be_error()

  [1.0, 2.0, 3.0]
  // Use degrees of freedom = 1
  |> maths.zscore(1)
  |> should.equal(Ok([-1.0, 0.0, 1.0]))

  // A single-element list should return an error
  [42.0]
  |> maths.zscore(1)
  |> should.be_error()

  // A typical case with multiple values
  [1.0, 2.0, 3.0]
  |> maths.zscore(1)
  |> should.equal(Ok([-1.0, 0.0, 1.0]))

  // Degrees of freedom = 0 (population standard deviation)
  let assert Ok(zscores) =
    [1.0, 2.0, 3.0]
    |> maths.zscore(0)

  let assert Ok(result) =
    maths.all_close(
      list.zip(zscores, [-1.224744871391589, 0.0, 1.224744871391589]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Handling negative degrees of freedom (invalid input)
  [1.0, 2.0, 3.0]
  |> maths.zscore(-1)
  |> should.be_error()

  // A list with all identical values should return an error 
  // (stdev = 0, division by zero not allowed)
  [5.0, 5.0, 5.0]
  |> maths.zscore(1)
  |> should.be_error()

  // A list with negative and positive values
  [-2.0, 0.0, 2.0]
  |> maths.zscore(1)
  |> should.equal(Ok([-1.0, 0.0, 1.0]))

  // A list with fractional values
  [1.5, 2.5, 3.5]
  |> maths.zscore(1)
  |> should.equal(Ok([-1.0, 0.0, 1.0]))
}

pub fn iqr_test() {
  // An empty list returns an error
  []
  |> maths.interquartile_range()
  |> should.be_error()

  // A single-element list returns an error
  [42.0]
  |> maths.interquartile_range()
  |> should.be_error()

  // Try a two-element list
  [10.0, 20.0]
  |> maths.interquartile_range()
  // Q1 = 10.0, Q3 = 20.0, IQR = Q3 - Q1 = 10.0
  |> should.equal(Ok(10.0))

  // A valid input with an odd number of elements
  [1.0, 2.0, 3.0, 4.0, 5.0]
  |> maths.interquartile_range()
  // Q1 = 2.0, Q3 = 5.0, IQR = Q3 - Q1 = 3.0
  |> should.equal(Ok(3.0))

  // // A valid input with an even number of elements
  [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
  |> maths.interquartile_range()
  // Q1 = 2.5, Q3 = 5.5, IQR = Q3 - Q1 = 3.0
  |> should.equal(Ok(3.0))

  // Make sure an unsorted list is sorted before calculating the IQR
  [9.0, 1.0, 4.0, 2.0, 8.0, 3.0, 7.0]
  |> maths.interquartile_range()
  // Sorted: [1.0, 2.0, 3.0, 4.0, 7.0, 8.0, 9.0], IQR = 8.0 - 2.0 = 6.0
  |> should.equal(Ok(6.0))

  // A list with duplicates still computes the correct IQR
  [1.0, 2.0, 2.0, 3.0, 3.0, 4.0, 5.0]
  |> maths.interquartile_range()
  // Q1 = 2.0, Q3 = 4.0, IQR = Q3 - Q1 = 2.0
  |> should.equal(Ok(2.0))

  // A list with all identical elements should return IQR = 0.0
  [5.0, 5.0, 5.0, 5.0, 5.0]
  |> maths.interquartile_range()
  // Q1 = 5.0, Q3 = 5.0, IQR = Q3 - Q1 = 0.0
  |> should.equal(Ok(0.0))
}

pub fn correlation_test() {
  // An empty list returns an error
  maths.correlation([])
  |> should.be_error()

  // Lists with fewer than 2 elements return an error
  maths.correlation([#(1.0, 1.0)])
  |> should.be_error()

  // Perfect positive correlation
  let xarr =
    list.range(0, 100)
    |> list.map(fn(x) { int.to_float(x) })
  let yarr =
    list.range(0, 100)
    |> list.map(fn(y) { int.to_float(y) })
  list.zip(xarr, yarr)
  |> maths.correlation()
  |> should.equal(Ok(1.0))

  // Perfect negative correlation
  let xarr =
    list.range(0, 100)
    |> list.map(fn(x) { -1.0 *. int.to_float(x) })
  let yarr =
    list.range(0, 100)
    |> list.map(fn(y) { int.to_float(y) })
  list.zip(xarr, yarr)
  |> maths.correlation()
  |> should.equal(Ok(-1.0))

  // No correlation (independent variables)
  let xarr = [1.0, 2.0, 3.0, 4.0]
  let yarr = [5.0, 5.0, 5.0, 5.0]
  list.zip(xarr, yarr)
  |> maths.correlation()
  |> should.equal(Ok(0.0))
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

  // An empty list returns an error
  maths.cosine_similarity([])
  |> should.be_error()

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

  // An empty list returns an error
  maths.cosine_similarity_with_weights([])
  |> should.be_error()

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
  // An empty list returns an error
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
  // An empty list returns an error
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
  // An empty list returns an error
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
