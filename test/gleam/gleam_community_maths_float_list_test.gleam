import gleam/int
import gleam/list
import gleam/pair
import gleam_community/maths/float_list
import gleam_community/maths/float as floatx
import gleeunit
import gleeunit/should
import gleam/io

pub fn main() {
  gleeunit.main()
}

pub fn float_list_all_close_test() {
  let val: Float = 99.0
  let ref_val: Float = 100.0
  let xarr: List(Float) = list.repeat(val, 42)
  let yarr: List(Float) = list.repeat(ref_val, 42)
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol: Float = 0.01
  let atol: Float = 0.1
  float_list.all_close(xarr, yarr, rtol, atol)
  |> fn(zarr: Result(List(Bool), String)) -> Result(Bool, Nil) {
    case zarr {
      Ok(arr) ->
        arr
        |> list.all(fn(a: Bool) -> Bool { a })
        |> Ok
      _ ->
        Nil
        |> Error
    }
  }
  |> should.equal(Ok(True))
}

pub fn float_list_norm_test() {
  let assert Ok(tol) = floatx.power(-10.0, -6.0)

  // An empty lists returns 0.0
  []
  |> float_list.norm(1.0)
  |> should.equal(0.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  [1.0, 1.0, 1.0]
  |> float_list.norm(1.0)
  |> floatx.is_close(3.0, 0.0, tol)
  |> should.be_true()

  [1.0, 1.0, 1.0]
  |> float_list.norm(-1.0)
  |> floatx.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  [-1.0, -1.0, -1.0]
  |> float_list.norm(-1.0)
  |> floatx.is_close(0.3333333333333333, 0.0, tol)
  |> should.be_true()

  [-1.0, -1.0, -1.0]
  |> float_list.norm(1.0)
  |> floatx.is_close(3.0, 0.0, tol)
  |> should.be_true()

  [-1.0, -2.0, -3.0]
  |> float_list.norm(-10.0)
  |> floatx.is_close(0.9999007044905545, 0.0, tol)
  |> should.be_true()

  [-1.0, -2.0, -3.0]
  |> float_list.norm(-100.0)
  |> floatx.is_close(1.0, 0.0, tol)
  |> should.be_true()

  [-1.0, -2.0, -3.0]
  |> float_list.norm(2.0)
  |> floatx.is_close(3.7416573867739413, 0.0, tol)
  |> should.be_true()
}

pub fn float_list_minkowski_test() {
  let assert Ok(tol) = floatx.power(-10.0, -6.0)

  // Empty lists returns 0.0
  float_list.minkowski_distance([], [], 1.0)
  |> should.equal(Ok(0.0))

  // Differing lengths returns error
  float_list.minkowski_distance([], [1.0], 1.0)
  |> should.be_error()

  // Test order < 1
  float_list.minkowski_distance([0.0, 0.0], [0.0, 0.0], -1.0)
  |> should.be_error()

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(result) =
    float_list.minkowski_distance([1.0, 1.0], [1.0, 1.0], 1.0)
  result
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0)
  result
  |> floatx.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 1.0], 100.0)
  result
  |> floatx.is_close(1.0069555500567189, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0)
  result
  |> floatx.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  // Euclidean distance (p = 2)
  let assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 2.0], 2.0)
  result
  |> floatx.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()

  // Manhatten distance (p = 1)
  let assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 2.0], 1.0)
  result
  |> floatx.is_close(3.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_list_euclidean_test() {
  let assert Ok(tol) = floatx.power(-10.0, -6.0)

  // Empty lists returns 0.0
  float_list.euclidean_distance([], [])
  |> should.equal(Ok(0.0))

  // Differing lengths returns error
  float_list.euclidean_distance([], [1.0])
  |> should.be_error()

  // Euclidean distance (p = 2)
  let assert Ok(result) = float_list.euclidean_distance([0.0, 0.0], [1.0, 2.0])
  result
  |> floatx.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()
}

pub fn float_list_manhatten_test() {
  let assert Ok(tol) = floatx.power(-10.0, -6.0)

  // Empty lists returns 0.0
  float_list.manhatten_distance([], [])
  |> should.equal(Ok(0.0))

  // Differing lengths returns error
  float_list.manhatten_distance([], [1.0])
  |> should.be_error()

  // Manhatten distance (p = 1)
  let assert Ok(result) = float_list.manhatten_distance([0.0, 0.0], [1.0, 2.0])
  result
  |> floatx.is_close(3.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_list_linear_space_test() {
  let assert Ok(tol) = floatx.power(-10.0, -6.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  let assert Ok(linspace) = float_list.linear_space(10.0, 50.0, 5, True)
  let assert Ok(result) =
    float_list.all_close(linspace, [10.0, 20.0, 30.0, 40.0, 50.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = float_list.linear_space(10.0, 20.0, 5, True)
  let assert Ok(result) =
    float_list.all_close(linspace, [10.0, 12.5, 15.0, 17.5, 20.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  // ----> Without endpoint included
  let assert Ok(linspace) = float_list.linear_space(10.0, 50.0, 5, False)
  let assert Ok(result) =
    float_list.all_close(linspace, [10.0, 18.0, 26.0, 34.0, 42.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = float_list.linear_space(10.0, 20.0, 5, False)
  let assert Ok(result) =
    float_list.all_close(linspace, [10.0, 12.0, 14.0, 16.0, 18.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  let assert Ok(linspace) = float_list.linear_space(10.0, -50.0, 5, False)
  let assert Ok(result) =
    float_list.all_close(linspace, [10.0, -2.0, -14.0, -26.0, -38.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = float_list.linear_space(10.0, -20.0, 5, True)
  let assert Ok(result) =
    float_list.all_close(linspace, [10.0, 2.5, -5.0, -12.5, -20.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative start
  let assert Ok(linspace) = float_list.linear_space(-10.0, 50.0, 5, False)
  let assert Ok(result) =
    float_list.all_close(linspace, [-10.0, 2.0, 14.0, 26.0, 38.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = float_list.linear_space(-10.0, 20.0, 5, True)
  let assert Ok(result) =
    float_list.all_close(linspace, [-10.0, -2.5, 5.0, 12.5, 20.0], 0.0, tol)

  // A negative number of points does not work (-5)
  float_list.linear_space(10.0, 50.0, -5, True)
  |> should.be_error()
}

pub fn float_list_logarithmic_space_test() {
  let assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop, base
  let assert Ok(logspace) =
    float_list.logarithmic_space(1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    float_list.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, stop, negative base
  let assert Ok(logspace) =
    float_list.logarithmic_space(1.0, 3.0, 3, True, -10.0)
  let assert Ok(result) =
    float_list.all_close(logspace, [-10.0, 100.0, -1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop, base 
  let assert Ok(logspace) =
    float_list.logarithmic_space(1.0, -3.0, 3, True, -10.0)
  let assert Ok(result) =
    float_list.all_close(logspace, [-10.0, -0.1, -0.001], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, base, negative stop  
  let assert Ok(logspace) =
    float_list.logarithmic_space(1.0, -3.0, 3, True, 10.0)
  let assert Ok(result) =
    float_list.all_close(logspace, [10.0, 0.1, 0.001], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, base, negative start
  let assert Ok(logspace) =
    float_list.logarithmic_space(-1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    float_list.all_close(logspace, [0.1, 10.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop, base
  let assert Ok(logspace) =
    float_list.logarithmic_space(1.0, 3.0, 3, False, 10.0)
  let assert Ok(result) =
    float_list.all_close(logspace, [10.0, 46.41588834, 215.443469], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // A negative number of points does not work (-3)
  float_list.logarithmic_space(1.0, 3.0, -3, True, 10.0)
  |> should.be_error()
}

pub fn float_list_geometric_space_test() {
  let assert Ok(tol) = floatx.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = float_list.geometric_space(10.0, 1000.0, 3, True)
  let assert Ok(result) =
    float_list.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop  
  let assert Ok(logspace) = float_list.geometric_space(10.0, 0.001, 3, True)
  let assert Ok(result) =
    float_list.all_close(logspace, [10.0, 0.1, 0.001], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, negative start
  let assert Ok(logspace) = float_list.geometric_space(0.1, 1000.0, 3, True)
  let assert Ok(result) =
    float_list.all_close(logspace, [0.1, 10.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = float_list.geometric_space(10.0, 1000.0, 3, False)
  let assert Ok(result) =
    float_list.all_close(logspace, [10.0, 46.41588834, 215.443469], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Test invalid input (start and stop can't be equal to 0.0)
  float_list.geometric_space(0.0, 1000.0, 3, False)
  |> should.be_error()

  float_list.geometric_space(-1000.0, 0.0, 3, False)
  |> should.be_error()

  // A negative number of points does not work
  float_list.geometric_space(-1000.0, 0.0, -3, False)
  |> should.be_error()
}

pub fn float_list_arange_test() {
  // Positive start, stop, step
  float_list.arange(1.0, 5.0, 1.0)
  |> should.equal([1.0, 2.0, 3.0, 4.0])

  float_list.arange(1.0, 5.0, 0.5)
  |> should.equal([1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5])

  float_list.arange(1.0, 2.0, 0.25)
  |> should.equal([1.0, 1.25, 1.5, 1.75])

  // Reverse (switch start/stop largest/smallest value)
  float_list.arange(5.0, 1.0, 1.0)
  |> should.equal([])

  // Reverse negative step
  float_list.arange(5.0, 1.0, -1.0)
  |> should.equal([5.0, 4.0, 3.0, 2.0])

  // Positive start, negative stop, step
  float_list.arange(5.0, -1.0, -1.0)
  |> should.equal([5.0, 4.0, 3.0, 2.0, 1.0, 0.0])

  // Negative start, stop, step
  float_list.arange(-5.0, -1.0, -1.0)
  |> should.equal([])

  // Negative start, stop, positive step
  float_list.arange(-5.0, -1.0, 1.0)
  |> should.equal([-5.0, -4.0, -3.0, -2.0])
}

pub fn float_list_maximum_test() {
  // An empty lists returns an error
  []
  |> float_list.maximum()
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> float_list.maximum()
  |> should.equal(Ok(4.0))
}

pub fn float_list_minimum_test() {
  // An empty lists returns an error
  []
  |> float_list.minimum()
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> float_list.minimum()
  |> should.equal(Ok(1.0))
}

pub fn float_list_arg_maximum_test() {
  // An empty lists returns an error
  []
  |> float_list.arg_maximum()
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> float_list.arg_maximum()
  |> should.equal(Ok([0, 1]))
}

pub fn float_list_arg_minimum_test() {
  // An empty lists returns an error
  []
  |> float_list.arg_minimum()
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> float_list.arg_minimum()
  |> should.equal(Ok([4]))
}

pub fn float_list_extrema_test() {
  // An empty lists returns an error
  []
  |> float_list.extrema()
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> float_list.extrema()
  |> should.equal(Ok(#(1.0, 4.0)))
}

pub fn float_list_sum_test() {
  // An empty list returns 0
  []
  |> float_list.sum()
  |> should.equal(0.0)

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> float_list.sum()
  |> should.equal(6.0)

  [-2.0, 4.0, 6.0]
  |> float_list.sum()
  |> should.equal(8.0)
}

pub fn float_list_cumulative_sum_test() {
  // An empty lists returns an empty list
  []
  |> float_list.cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> float_list.cumulative_sum()
  |> should.equal([1.0, 3.0, 6.0])

  [-2.0, 4.0, 6.0]
  |> float_list.cumulative_sum()
  |> should.equal([-2.0, 2.0, 8.0])
}

pub fn float_list_product_test() {
  // An empty list returns 0
  []
  |> float_list.product()
  |> should.equal(1.0)

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> float_list.product()
  |> should.equal(6.0)

  [-2.0, 4.0, 6.0]
  |> float_list.product()
  |> should.equal(-48.0)
}

pub fn float_list_cumulative_product_test() {
  // An empty lists returns an empty list
  []
  |> float_list.cumumlative_product()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> float_list.cumumlative_product()
  |> should.equal([1.0, 2.0, 6.0])

  [-2.0, 4.0, 6.0]
  |> float_list.cumumlative_product()
  |> should.equal([-2.0, -8.0, -48.0])
}
