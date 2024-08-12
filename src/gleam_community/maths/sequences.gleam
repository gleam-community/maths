////<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.css" integrity="sha384-GvrOXuhMATgEsSwCs4smul74iXGOixntILdUW9XmUC6+HX0sLNAK3q71HotJqlAn" crossorigin="anonymous">
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.js" integrity="sha384-cpW21h6RZv/phavutF+AuVYrr+dA8xD9zs6FwLpaCct6O9ctzYFfFr4dgmgccOTx" crossorigin="anonymous"></script>
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/contrib/auto-render.min.js" integrity="sha384-+VBxd3r6XgURycqtZ117nYw44OOcIax56Z4dCRWbxyPt0Koah1uHoK0o4+/RRE05" crossorigin="anonymous"></script>
////<script>
////    document.addEventListener("DOMContentLoaded", function() {
////        renderMathInElement(document.body, {
////          // customised options
////          // • auto-render specific keys, e.g.:
////          delimiters: [
////              {left: '$$', right: '$$', display: false},
////            //   {left: '$', right: '$', display: false},
////            //   {left: '\\(', right: '\\)', display: false},
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
//// ---
//// 
//// Sequences: A module containing functions for generating various types of 
//// sequences, ranges and intervals.
//// 
//// * **Ranges and intervals**
////   * [`arange`](#arange)
////   * [`linear_space`](#linear_space)
////   * [`logarithmic_space`](#logarithmic_space)
////   * [`geometric_space`](#geometric_space)

import gleam_community/maths/elementary
import gleam_community/maths/piecewise
import gleam_community/maths/conversion
import gleam/list

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns a list with evenly spaced values within a given interval 
/// based on a start, stop value and a given increment (step-length) between 
/// consecutive values. The list returned includes the given start value but 
/// excludes the stop value.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/sequences
///
///     pub fn example () {
///       sequences.arange(1.0, 5.0, 1.0)
///       |> should.equal([1.0, 2.0, 3.0, 4.0])
///       
///       // No points returned since
///       // start smaller than stop and positive step
///       sequences.arange(5.0, 1.0, 1.0)
///       |> should.equal([])
///       
///       // Points returned since
///       // start smaller than stop but negative step
///       sequences.arange(5.0, 1.0, -1.0)
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
      let step_abs: Float = piecewise.float_absolute_value(step)
      let num: Float = piecewise.float_absolute_value(start -. stop) /. step_abs

      list.range(0, conversion.float_to_int(num) - 1)
      |> list.map(fn(i: Int) -> Float {
        start +. conversion.int_to_float(i) *. step_abs *. direction
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
/// Generate a linearly spaced list of points over a specified interval. The 
/// endpoint of the interval can optionally be included/excluded.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/sequences
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///       let assert Ok(linspace) = sequences.linear_space(10.0, 50.0, 5, True)
///       let assert Ok(result) =
///         predicates.all_close(linspace, [10.0, 20.0, 30.0, 40.0, 50.0], 0.0, tol)
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // A negative number of points (-5) does not work
///       sequences.linear_space(10.0, 50.0, -5, True)
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
            piecewise.float_absolute_value(start -. stop)
            /. conversion.int_to_float(num - 1)
          list.range(0, num - 1)
          |> list.map(fn(i: Int) -> Float {
            start +. conversion.int_to_float(i) *. increment *. direction
          })
          |> Ok
        }
        False -> {
          let increment: Float =
            piecewise.float_absolute_value(start -. stop)
            /. conversion.int_to_float(num)
          list.range(0, num - 1)
          |> list.map(fn(i: Int) -> Float {
            start +. conversion.int_to_float(i) *. increment *. direction
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
/// Generate a logarithmically spaced list of points over a specified interval. The 
/// endpoint of the interval can optionally be included/excluded.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/sequences
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///       let assert Ok(logspace) = sequences.logarithmic_space(1.0, 3.0, 3, True, 10.0)
///       let assert Ok(result) =
///         predicates.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // A negative number of points (-3) does not work
///       sequences.logarithmic_space(1.0, 3.0, -3, False, 10.0)
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
      let assert Ok(linspace) = linear_space(start, stop, num, endpoint)
      linspace
      |> list.map(fn(i: Float) -> Float {
        let assert Ok(result) = elementary.power(base, i)
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
/// The function returns a list of numbers spaced evenly on a log scale (a 
/// geometric progression). Each point in the list is a constant multiple of the 
/// previous. The function is similar to the 
/// [`logarithmic_space`](#logarithmic_space) function, but with endpoints 
/// specified directly.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/sequences
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///       let assert Ok(logspace) = sequences.geometric_space(10.0, 1000.0, 3, True)
///       let assert Ok(result) =
///         predicates.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // Input (start and stop can't be equal to 0.0)
///       sequences.geometric_space(0.0, 1000.0, 3, False)
///       |> should.be_error()
///     
///       sequences.geometric_space(-1000.0, 0.0, 3, False)
///       |> should.be_error()
///
///       // A negative number of points (-3) does not work
///       sequences.geometric_space(10.0, 1000.0, -3, False)
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
      "Invalid input: Neither 'start' nor 'stop' can be zero, as they must be non-zero for logarithmic calculations."
      |> Error
    False ->
      case num > 0 {
        True -> {
          let assert Ok(log_start) = elementary.logarithm_10(start)
          let assert Ok(log_stop) = elementary.logarithm_10(stop)
          logarithmic_space(log_start, log_stop, num, endpoint, 10.0)
        }
        False ->
          "Invalid input: num < 0. Valid input is num > 0."
          |> Error
      }
  }
}
