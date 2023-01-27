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
  let atol: Float = 0.10
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
  assert Ok(tol) = floatx.power(-10.0, -6.0)

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
  assert Ok(tol) = floatx.power(-10.0, -6.0)

  // Empty lists returns 0.0
  float_list.minkowski_distance([], [], 1.0)
  |> should.equal(Ok(0.0))

  // Differing lenghths returns error
  float_list.minkowski_distance([], [1.0], 1.0)
  |> should.be_error()

  // Test order < 1
  float_list.minkowski_distance([0.0, 0.0], [0.0, 0.0], -1.0)
  |> should.be_error()

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  assert Ok(result) = float_list.minkowski_distance([1.0, 1.0], [1.0, 1.0], 1.0)
  result
  |> floatx.is_close(0.0, 0.0, tol)
  |> should.be_true()

  assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0)
  result
  |> floatx.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 1.0], 100.0)
  result
  |> floatx.is_close(1.0069555500567189, 0.0, tol)
  |> should.be_true()

  assert Ok(result) =
    float_list.minkowski_distance([0.0, 0.0], [1.0, 1.0], 10.0)
  result
  |> floatx.is_close(1.0717734625362931, 0.0, tol)
  |> should.be_true()

  assert Ok(result) = float_list.minkowski_distance([0.0, 0.0], [1.0, 2.0], 2.0)
  result
  |> floatx.is_close(2.23606797749979, 0.0, tol)
  |> should.be_true()
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
