////<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.4/dist/katex.min.css" integrity="sha384-vKruj+a13U8yHIkAyGgK1J3ArTLzrFGBbBc0tDp4ad/EyewESeXE/Iv67Aj8gKZ0" crossorigin="anonymous">
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.4/dist/katex.min.js" integrity="sha384-PwRUT/YqbnEjkZO0zZxNqcxACrXe+j766U2amXcgMg5457rve2Y7I6ZJSm2A0mS4" crossorigin="anonymous"></script>
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.4/dist/contrib/auto-render.min.js" integrity="sha384-+VBxd3r6XgURycqtZ117nYw44OOcIax56Z4dCRWbxyPt0Koah1uHoK0o4+/RRE05" crossorigin="anonymous"></script>
////<script>
////    document.addEventListener("DOMContentLoaded", function() {
////        renderMathInElement(document.body, {
////          // customised options
////          // • auto-render specific keys, e.g.:
////          delimiters: [
////              {left: '$$', right: '$$', display: false},
////              {left: '\\[', right: '\\]', display: true}
////          ],
////          // • rendering keys, e.g.:
////          throwOnError : false
////        });
////    });
////</script>
////<style>
////    .katex { font-size: 1.1em; }
////</style>
////
//// A module containing mathematical functions applying to one or more lists of floats.
////
//// ---
////
//// * **Distances, sums, and products**
////   * [`sum`](#sum)
////   * [`product`](#product)
////   * [`cumulative_sum`](#cumulative_sum)
////   * [`cumulative_product`](#cumulative_product)
////   * [`norm`](#norm)
////   * [`minkowski_distance`](#minkowski_distance)
////   * [`euclidean_distance`](#euclidean_distance)
////   * [`manhatten_distance`](#manhatten_distance)
//// * **Ranges and intervals**
////   * [`arange`](#arange)
////   * [`linear_space`](#linear_space)
////   * [`logarithmic_space`](#logarithmic_space)
////   * [`geometric_space`](#geometric_space)
//// * **Misc. mathematical functions**
////   * [`maximum`](#maximum)
////   * [`minimum`](#minimum)
////   * [`extrema`](#extrema)
////   * [`arg_maximum`](#arg_maximum)
////   * [`arg_minimum`](#arg_minimum)
//// * **Tests**
////   * [`all_close`](#all_close)

import gleam/list
import gleam/int
import gleam/float
import gleam/pair
import gleam/option
import gleam_community/maths/float as floatx
import gleam_community/maths/int as intx
import gleam/io

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the $$p$$-norm of a list (representing a vector):
///
/// \\[
/// \left( \sum_{i=1}^n \left|x_i\right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i$$ is the value in the input list indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       assert Ok(tol) = floatx.power(-10.0, -6.0)
///
///       [1.0, 1.0, 1.0]
///       |> float_list.norm(1.0)
///       |> floatx.is_close(3.0, 0.0, tol)
///       |> should.be_true()
///
///       [1.0, 1.0, 1.0]
///       |> float_list.norm(-1.0)
///       |> floatx.is_close(0.3333333333333333, 0.0, tol)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn norm(arr: List(Float), p: Float) -> Float {
  case arr {
    [] -> 0.0
    _ -> {
      let agg: Float =
        arr
        |> list.fold(
          0.0,
          fn(acc: Float, a: Float) -> Float {
            assert Ok(result) = floatx.power(float.absolute_value(a), p)
            result +. acc
          },
        )
      assert Ok(result) = floatx.power(agg, 1.0 /. p)
      result
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the Minkowski distance between two lists (representing vectors):
///
/// \\[
/// \left( \sum_{i=1}^n \left|x_i - x_j \right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, $$p >= 1$$ is the order, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the values in the respective input lists indexed by $$i, j$$.
///
/// The Minkowski distance is a generalization of both the Euclidean distance ($$p=2$$) and the Manhattan distance ($$p = 1$$).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       assert Ok(tol) = floatx.power(-10.0, -6.0)
///     
///       // Empty lists returns 0.0
///       float_list.minkowski_distance([], [], 1.0)
///       |> should.equal(Ok(0.0))
///     
///       // Differing lengths returns error
///       float_list.minkowski_distance([], [1.0], 1.0)
///       |> should.be_error()
///     
///       // Test order < 1
///       float_list.minkowski_distance([0.0, 0.0], [0.0, 0.0], -1.0)
///       |> should.be_error()
///     
///       assert Ok(result) = float_list.minkowski_distance([0.0, 0.0], [1.0, 2.0], 1.0)
///       result
///       |> floatx.is_close(3.0, 0.0, tol)
///       |> should.be_true()  
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minkowski_distance(
  xarr: List(Float),
  yarr: List(Float),
  p: Float,
) -> Result(Float, String) {
  let xlen: Int = list.length(xarr)
  let ylen: Int = list.length(yarr)
  case xlen == ylen {
    False ->
      "Invalid input argument: length(xarr) != length(yarr). Valid input is when length(xarr) == length(yarr)."
      |> Error
    True ->
      case p <. 1.0 {
        True ->
          "Invalid input argument: p < 1. Valid input is p >= 1."
          |> Error
        False ->
          list.zip(xarr, yarr)
          |> list.map(fn(tuple: #(Float, Float)) -> Float {
            pair.first(tuple) -. pair.second(tuple)
          })
          |> norm(p)
          |> Ok
      }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the Euclidean distance between two lists (representing vectors):
///
/// \\[
/// \left( \sum_{i=1}^n \left|x_i - x_j \right|^{2} \right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the values in the respective input lists indexed by $$i, j$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       assert Ok(tol) = floatx.power(-10.0, -6.0)
///     
///       // Empty lists returns 0.0
///       float_list.euclidean_distance([], [], 1.0)
///       |> should.equal(Ok(0.0))
///     
///       // Differing lengths returns error
///       float_list.euclidean_distance([], [1.0], 1.0)
///       |> should.be_error()
///     
///       assert Ok(result) = float_list.euclidean_distance([0.0, 0.0], [1.0, 2.0])
///       result
///       |> floatx.is_close(2.23606797749979, 0.0, tol)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn euclidean_distance(
  xarr: List(Float),
  yarr: List(Float),
) -> Result(Float, String) {
  minkowski_distance(xarr, yarr, 2.0)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the Manhatten distance between two lists (representing vectors):
///
/// \\[
/// \sum_{i=1}^n \left|x_i - x_j \right|
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the values in the respective input lists indexed by $$i, j$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       assert Ok(tol) = floatx.power(-10.0, -6.0)
///     
///       // Empty lists returns 0.0
///       float_list.manhatten_distance([], [])
///       |> should.equal(Ok(0.0))
///     
///       // Differing lengths returns error
///       float_list.manhatten_distance([], [1.0])
///       |> should.be_error()
///     
///       assert Ok(result) = float_list.manhatten_distance([0.0, 0.0], [1.0, 2.0])
///       result
///       |> floatx.is_close(3.0, 0.0, tol)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn manhatten_distance(
  xarr: List(Float),
  yarr: List(Float),
) -> Result(Float, String) {
  minkowski_distance(xarr, yarr, 1.0)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generate a linearly spaced list of points over a specified interval. The endpoint of the interval can optionally be included/excluded.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       assert Ok(tol) = floatx.power(-10.0, -6.0)
///       assert Ok(linspace) = float_list.linear_space(10.0, 50.0, 5, True)
///       assert Ok(result) =
///         float_list.all_close(linspace, [10.0, 20.0, 30.0, 40.0, 50.0], 0.0, tol)
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // A negative number of points (-5) does not work
///       float_list.linear_space(10.0, 50.0, -5, True)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn linear_space(
  start: Float,
  stop: Float,
  num: Int,
  endpoint: Bool,
) -> Result(List(Float), String) {
  let direction: Float = case start <=. stop {
    True -> 1.0
    False -> -1.0
  }
  case num > 0 {
    True ->
      case endpoint {
        True -> {
          let increment: Float =
            float.absolute_value(start -. stop) /. intx.to_float(num - 1)
          list.range(0, num - 1)
          |> list.map(fn(i: Int) -> Float {
            start +. intx.to_float(i) *. increment *. direction
          })
          |> Ok
        }
        False -> {
          let increment: Float =
            float.absolute_value(start -. stop) /. intx.to_float(num)
          list.range(0, num - 1)
          |> list.map(fn(i: Int) -> Float {
            start +. intx.to_float(i) *. increment *. direction
          })
          |> Ok
        }
      }

    False ->
      "Invalid input: num < 0. Valid input is num > 0."
      |> Error
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generate a logarithmically spaced list of points over a specified interval. The endpoint of the interval can optionally be included/excluded.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       assert Ok(tol) = floatx.power(-10.0, -6.0)
///       assert Ok(logspace) = float_list.logarithmic_space(1.0, 3.0, 3, True)
///       assert Ok(result) =
///         float_list.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // A negative number of points (-3) does not work
///       float_list.logarithmic_space(1.0, 3.0, -3, False)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithmic_space(
  start: Float,
  stop: Float,
  num: Int,
  endpoint: Bool,
  base: Float,
) -> Result(List(Float), String) {
  case num > 0 {
    True -> {
      assert Ok(linspace) = linear_space(start, stop, num, endpoint)
      linspace
      |> list.map(fn(i: Float) -> Float {
        assert Ok(result) = floatx.power(base, i)
        result
      })
      |> Ok
    }
    False ->
      "Invalid input: num < 0. Valid input is num > 0."
      |> Error
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns a list of numbers spaced evenly on a log scale (a geometric progression). Each output point in the list is a constant multiple of the previous.
/// The function is similar to the [`logarithmic_space`](#logarithmic_space) function, but with endpoints specified directly.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       assert Ok(tol) = floatx.power(-10.0, -6.0)
///       assert Ok(logspace) = float_list.geometric_space(10.0, 1000.0, 3, True)
///       assert Ok(result) =
///         float_list.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // Input (start and stop can't be equal to 0.0)
///       float_list.geometric_space(0.0, 1000.0, 3, False)
///       |> should.be_error()
///     
///       float_list.geometric_space(-1000.0, 0.0, 3, False)
///       |> should.be_error()
///
///       // A negative number of points (-3) does not work
///       float_list.geometric_space(10.0, 1000.0, -3, False)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn geometric_space(
  start: Float,
  stop: Float,
  num: Int,
  endpoint: Bool,
) -> Result(List(Float), String) {
  case start == 0.0 || stop == 0.0 {
    True ->
      ""
      |> Error
    False ->
      case num > 0 {
        True -> {
          assert Ok(log_start) = floatx.logarithm_10(start)
          assert Ok(log_stop) = floatx.logarithm_10(stop)
          logarithmic_space(log_start, log_stop, num, endpoint, 10.0)
        }
        False ->
          "Invalid input: num < 0. Valid input is num > 0."
          |> Error
      }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns a list with evenly spaced values within a given interval based on a start, stop value and a given increment (step-length) between consecutive values. 
/// The list returned includes the given start value but excludes the stop value.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       float_list.arange(1.0, 5.0, 1.0)
///       |> should.equal([1.0, 2.0, 3.0, 4.0])
///       
///       // No points returned since
///       // start smaller than stop and positive step
///       float_list.arange(5.0, 1.0, 1.0)
///       |> should.equal([])
///       
///       // Points returned since
///       // start smaller than stop but negative step
///       float_list.arange(5.0, 1.0, -1.0)
///       |> should.equal([5.0, 4.0, 3.0, 2.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn arange(start: Float, stop: Float, step: Float) -> List(Float) {
  case start >=. stop && step >. 0.0 || start <=. stop && step <. 0.0 {
    True -> []
    False -> {
      let direction: Float = case start <=. stop {
        True -> 1.0
        False -> -1.0
      }
      let step_abs: Float = float.absolute_value(step)
      let num: Float = float.absolute_value(start -. stop) /. step_abs

      list.range(0, floatx.to_int(num) - 1)
      |> list.map(fn(i: Int) -> Float {
        start +. intx.to_float(i) *. step_abs *. direction
      })
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the sum of the elements in a list:
///
/// \\[
/// \sum_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i$$ is the value in the input list indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> float_list.sum()
///       |> should.equal(0.0)
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> float_list.sum()
///       |> should.equal(6.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sum(arr: List(Float)) -> Float {
  case arr {
    [] -> 0.0
    _ ->
      arr
      |> list.fold(0.0, fn(acc: Float, a: Float) -> Float { a +. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the product of the elements in a list:
///
/// \\[
/// \prod_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i$$ is the value in the input list indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty list returns 0.0
///       []
///       |> float_list.sum()
///       |> should.equal(0.0)
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> float_list.product()
///       |> should.equal(6.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn product(arr: List(Float)) -> Float {
  case arr {
    [] -> 0.0
    _ ->
      arr
      |> list.fold(1.0, fn(acc: Float, a: Float) -> Float { a *. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j x_i, \forall j \leq n
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i$$ is the value in the input list indexed by $$i$$.
/// Furthermore, $$v_j$$ is the $$j$$th element in the cumulative sum.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       []
///       |> float_list.cumulative_sum()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> float_list.cumulative_sum()
///       |> should.equal([1.0, 3.0, 6.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cumulative_sum(arr: List(Float)) -> List(Float) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(0.0, fn(acc: Float, a: Float) -> Float { a +. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j x_i, \forall j \leq n
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i$$ is the value in the input list indexed by $$i$$.
/// Furthermore, $$v_j$$ is the $$j$$th element in the cumulative product.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> float_list.cumulative_product()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> float_list.cumulative_product()
///       |> should.equal([1.0, 2.0, 6.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cumumlative_product(arr: List(Float)) -> List(Float) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(1.0, fn(acc: Float, a: Float) -> Float { a *. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the maximum value of a list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> float_list.maximum()
///       |> should.be_error()
///
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> float_list.maximum()
///       |> should.equal(Ok(4.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn maximum(arr: List(Float)) -> Result(Float, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(val0) = list.at(arr, 0)
      arr
      |> list.fold(
        val0,
        fn(acc: Float, a: Float) {
          case a >. acc {
            True -> a
            False -> acc
          }
        },
      )
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the minimum value of a list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> float_list.minimum()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> float_list.minimum()
///       |> should.equal(Ok(1.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minimum(arr: List(Float)) -> Result(Float, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(val0) = list.at(arr, 0)
      arr
      |> list.fold(
        val0,
        fn(acc: Float, a: Float) {
          case a <. acc {
            True -> a
            False -> acc
          }
        },
      )
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the indices of the maximum values in a list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> float_list.arg_maximum()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> float_list.arg_maximum()
///       |> should.equal(Ok([0, 1]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn arg_maximum(arr: List(Float)) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(max) =
        arr
        |> maximum()
      arr
      |> list.index_map(fn(index: Int, a: Float) -> Int {
        case a -. max {
          0.0 -> index
          _ -> -1
        }
      })
      |> list.filter(fn(index: Int) -> Bool {
        case index {
          -1 -> False
          _ -> True
        }
      })
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the indices of the minimum values in a list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> float_list.arg_minimum()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> float_list.arg_minimum()
///       |> should.equal(Ok([4]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn arg_minimum(arr: List(Float)) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(min) =
        arr
        |> minimum()
      arr
      |> list.index_map(fn(index: Int, a: Float) -> Int {
        case a -. min {
          0.0 -> index
          _ -> -1
        }
      })
      |> list.filter(fn(index: Int) -> Bool {
        case index {
          -1 -> False
          _ -> True
        }
      })
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the minimum value of a list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> float_list.extrema()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> float_list.extrema()
///       |> should.equal(Ok(#(1.0, 4.0)))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn extrema(arr: List(Float)) -> Result(#(Float, Float), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(val_max) = list.at(arr, 0)
      assert Ok(val_min) = list.at(arr, 0)
      arr
      |> list.fold(
        #(val_min, val_max),
        fn(acc: #(Float, Float), a: Float) {
          let first: Float = pair.first(acc)
          let second: Float = pair.second(acc)
          case a <. first, a >. second {
            True, True -> #(a, a)
            True, False -> #(a, second)
            False, True -> #(first, a)
            False, False -> #(first, second)
          }
        },
      )
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a list of values are close to or equivalent to a 
/// another list of reference values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/list
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///       let val: Float = 99.
///       let ref_val: Float = 100.
///       let xarr: List(Float) = list.repeat(val, 42)
///       let yarr: List(Float) = list.repeat(ref_val, 42)
///       // We set 'atol' and 'rtol' such that the values are equivalent
///       // if 'val' is within 1 percent of 'ref_val' +/- 0.1
///       let rtol: Float = 0.01
///       let atol: Float = 0.10
///       float_list.all_close(xarr, yarr, rtol, atol)
///       |> fn(zarr: Result(List(Bool), String)) -> Result(Bool, Nil) {
///         case zarr {
///           Ok(arr) ->
///             arr
///             |> list.all(fn(a: Bool) -> Bool { a })
///             |> Ok
///           _ -> Nil |> Error
///         }
///       }
///       |> should.equal(Ok(True))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn all_close(
  xarr: List(Float),
  yarr: List(Float),
  rtol: Float,
  atol: Float,
) -> Result(List(Bool), String) {
  let xlen: Int = list.length(xarr)
  let ylen: Int = list.length(yarr)
  case xlen == ylen {
    False ->
      "Invalid input argument: length(xarr) != length(yarr). Valid input is when length(xarr) == length(yarr)."
      |> Error
    True ->
      list.zip(xarr, yarr)
      |> list.map(fn(z: #(Float, Float)) -> Bool {
        floatx.is_close(pair.first(z), pair.second(z), rtol, atol)
      })
      |> Ok
  }
}
