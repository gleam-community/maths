////<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css" integrity="sha384-nB0miv6/jRmo5UMMR1wu3Gz6NLsoTkbqJghGIsx//Rlm+ZU03BU6SQNC66uf4l5+" crossorigin="anonymous">
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js" integrity="sha384-7zkQWkzuo3B5mTepMUcHkMB5jZaolc2xDwL6VFqjFALcbeS9Ggm/Yr2r3Dy4lfFg" crossorigin="anonymous"></script>
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js" integrity="sha384-43gviWU0YVjaDtb/GhzOouOXtZMP/7XUzwPTstBeZFe/+rCMvRwr4yROQP43s0Xk" crossorigin="anonymous"></script>
////<script>
////    document.addEventListener("DOMContentLoaded", function() {
////        renderMathInElement(document.body, {
////          // customised options
////          // • auto-render specific keys, e.g.:
////          delimiters: [
////              {left: '$$', right: '$$', display: false},
////              {left: '$', right: '$', display: false},
////              {left: '\\(', right: '\\)', display: false},
////              {left: '\\[', right: '\\]', display: true}
////          ],
////          // • rendering keys, e.g.:
////          throwOnError : true
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
////

import gleam/iterator
import gleam_community/maths/conversion
import gleam_community/maths/elementary
import gleam_community/maths/piecewise

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns an iterator generating evenly spaced values within a given interval.
/// based on a start value but excludes the stop value. The spacing between values is determined
/// by the step size provided. The function supports both positive and negative step values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths/sequences
///
///     pub fn example () {
///       sequences.arange(1.0, 5.0, 1.0)
///       |> iterator.to_list()
///       |> should.equal([1.0, 2.0, 3.0, 4.0])
///
///       // No points returned since
///       // start is smaller than stop and the step is positive
///       sequences.arange(5.0, 1.0, 1.0)
///       |> iterator.to_list()
///       |> should.equal([])
///
///       // Points returned since
///       // start smaller than stop but negative step
///       sequences.arange(5.0, 1.0, -1.0)
///       |> iterator.to_list()
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
pub fn arange(
  start: Float,
  stop: Float,
  step: Float,
) -> iterator.Iterator(Float) {
  case start >=. stop && step >. 0.0 || start <=. stop && step <. 0.0 {
    True -> iterator.empty()
    False -> {
      let direction = case start <=. stop {
        True -> {
          1.0
        }
        False -> {
          -1.0
        }
      }
      let step_abs = piecewise.float_absolute_value(step)
      let num =
        piecewise.float_absolute_value(start -. stop) /. step_abs
        |> conversion.float_to_int()

      iterator.range(0, num - 1)
      |> iterator.map(fn(i) {
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
/// The function returns an iterator for generating linearly spaced points over a specified
/// interval. The endpoint of the interval can optionally be included/excluded. The number of
/// points and whether the endpoint is included determine the spacing between values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/sequences
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(10.0, -6.0)
///       let assert Ok(linspace) = sequences.linear_space(10.0, 20.0, 5, True)
///       let assert Ok(result) =
///         predicates.all_close(
///           linspace |> iterator.to_list(),
///           [10.0, 12.5, 15.0, 17.5, 20.0],
///           0.0,
///           tol,
///         )
///
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
) -> Result(iterator.Iterator(Float), String) {
  let direction = case start <=. stop {
    True -> 1.0
    False -> -1.0
  }

  let increment = case endpoint {
    True -> {
      piecewise.float_absolute_value(start -. stop)
      /. conversion.int_to_float(num - 1)
    }
    False -> {
      piecewise.float_absolute_value(start -. stop)
      /. conversion.int_to_float(num)
    }
  }
  case num > 0 {
    True -> {
      iterator.range(0, num - 1)
      |> iterator.map(fn(i) {
        start +. conversion.int_to_float(i) *. increment *. direction
      })
      |> Ok
    }
    False ->
      "Invalid input: num < 1. Valid input is num >= 1."
      |> Error
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns an iterator of logarithmically spaced points over a specified interval.
/// The endpoint of the interval can optionally be included/excluded. The number of points, base,
/// and whether the endpoint is included determine the spacing between values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/sequences
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(10.0, -6.0)
///       let assert Ok(logspace) = sequences.logarithmic_space(1.0, 3.0, 3, True, 10.0)
///       let assert Ok(result) =
///         predicates.all_close(
///           logspace |> iterator.to_list(),
///           [10.0, 100.0, 1000.0],
///           0.0,
///           tol,
///         )
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
) -> Result(iterator.Iterator(Float), String) {
  case num > 0 {
    True -> {
      let assert Ok(linspace) = linear_space(start, stop, num, endpoint)
      linspace
      |> iterator.map(fn(i) {
        let assert Ok(result) = elementary.power(base, i)
        result
      })
      |> Ok
    }
    False ->
      "Invalid input: num < 1. Valid input is num >= 1."
      |> Error
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns an iterator of numbers spaced evenly on a log scale (a geometric
/// progression). Each point in the list is a constant multiple of the previous. The function is
/// similar to the [`logarithmic_space`](#logarithmic_space) function, but with endpoints
/// specified directly.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/sequences
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(10.0, -6.0)
///       let assert Ok(logspace) = sequences.geometric_space(10.0, 1000.0, 3, True)
///       let assert Ok(result) =
///         predicates.all_close(
///           logspace |> iterator.to_list(),
///           [10.0, 100.0, 1000.0],
///           0.0,
///           tol,
///         )
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
) -> Result(iterator.Iterator(Float), String) {
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
          "Invalid input: num < 1. Valid input is num >= 1."
          |> Error
      }
  }
}
