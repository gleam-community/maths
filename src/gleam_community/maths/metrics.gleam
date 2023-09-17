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
//// Metrics: A module offering functions for calculating distances and other types of metrics.
//// 
//// * **Distances**
////   * [`norm`](#norm)
////   * [`manhatten_distance`](#float_manhatten_distance)
////   * [`minkowski_distance`](#minkowski_distance)
////   * [`euclidean_distance`](#euclidean_distance)
//// * **Basic statistical measures**
////   * [`mean`](#mean)
////   * [`median`](#median)
////   * [`variance`](#variance)
////   * [`standard_deviation`](#standard_deviation)
//// 

import gleam_community/maths/elementary
import gleam_community/maths/piecewise
import gleam_community/maths/arithmetics
import gleam_community/maths/predicates
import gleam_community/maths/conversion
import gleam/list
import gleam/pair
import gleam/float

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
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///
///       [1.0, 1.0, 1.0]
///       |> metrics.norm(1.0)
///       |> predicates.is_close(3.0, 0.0, tol)
///       |> should.be_true()
///
///       [1.0, 1.0, 1.0]
///       |> metrics.norm(-1.0)
///       |> predicates.is_close(0.3333333333333333, 0.0, tol)
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
            let assert Ok(result) =
              elementary.power(piecewise.float_absolute_value(a), p)
            result +. acc
          },
        )
      let assert Ok(result) = elementary.power(agg, 1.0 /. p)
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
/// Calculcate the Manhatten distance between two lists (representing vectors):
///
/// \\[
/// \sum_{i=1}^n \left|x_i - y_i \right|
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the values in the respective input lists indexed by $$i, j$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///     
///       // Empty lists returns 0.0
///       metrics.float_manhatten_distance([], [])
///       |> should.equal(Ok(0.0))
///     
///       // Differing lengths returns error
///       metrics.manhatten_distance([], [1.0])
///       |> should.be_error()
///     
///       let assert Ok(result) = metrics.manhatten_distance([0.0, 0.0], [1.0, 2.0])
///       result
///       |> predicates.is_close(3.0, 0.0, tol)
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
/// Calculcate the Minkowski distance between two lists (representing vectors):
///
/// \\[
/// \left( \sum_{i=1}^n \left|x_i - y_i \right|^{p} \right)^{\frac{1}{p}}
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
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///     
///       // Empty lists returns 0.0
///       metrics.minkowski_distance([], [], 1.0)
///       |> should.equal(Ok(0.0))
///     
///       // Differing lengths returns error
///       metrics.minkowski_distance([], [1.0], 1.0)
///       |> should.be_error()
///     
///       // Test order < 1
///       metrics.minkowski_distance([0.0, 0.0], [0.0, 0.0], -1.0)
///       |> should.be_error()
///     
///       let assert Ok(result) = metrics.minkowski_distance([0.0, 0.0], [1.0, 2.0], 1.0)
///       result
///       |> predicates.is_close(3.0, 0.0, tol)
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
/// \left( \sum_{i=1}^n \left|x_i - y_i \right|^{2} \right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the values in the respective input lists indexed by $$i, j$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///     
///       // Empty lists returns 0.0
///       metrics.euclidean_distance([], [])
///       |> should.equal(Ok(0.0))
///     
///       // Differing lengths returns error
///       metrics.euclidean_distance([], [1.0])
///       |> should.be_error()
///     
///       let assert Ok(result) = metrics.euclidean_distance([0.0, 0.0], [1.0, 2.0])
///       result
///       |> predicates.is_close(2.23606797749979, 0.0, tol)
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
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the arithmetic mean of the elements in a list:
///
/// \\[
/// \bar{x} = \frac{1}{n}\sum_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the sample size (the length of the list) and 
/// $$x_i$$ is the sample point in the input list indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> metrics.mean()
///       |> should.be_error()
///
///       // Valid input returns a result
///       [1., 2., 3.]
///       |> metrics.mean()
///       |> should.equal(Ok(2.))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn mean(arr: List(Float)) -> Result(Float, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ ->
      arr
      |> arithmetics.float_sum()
      |> fn(a: Float) -> Float {
        a /. conversion.int_to_float(list.length(arr))
      }
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the median of the elements in a list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> metrics.median()
///       |> should.be_error()
///
///       // Valid input returns a result
///       [1., 2., 3.]
///       |> metrics.median()
///       |> should.equal(Ok(2.))
///     
///       [1., 2., 3., 4.]
///       |> metrics.median()
///       |> should.equal(Ok(2.5))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn median(arr: List(Float)) -> Result(Float, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      let count: Int = list.length(arr)
      let mid: Int = list.length(arr) / 2
      let sorted: List(Float) = list.sort(arr, float.compare)
      case predicates.is_odd(count) {
        // If there is an odd number of elements in the list, then the median
        // is just the middle value
        True -> {
          let assert Ok(val0) = list.at(sorted, mid)
          val0
          |> Ok
        }
        // If there is an even number of elements in the list, then the median
        // is the mean of the two middle values
        False -> {
          let assert Ok(val0) = list.at(sorted, mid - 1)
          let assert Ok(val1) = list.at(sorted, mid)
          [val0, val1]
          |> mean()
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the sample variance of the elements in a list:
/// \\[
/// s^{2} = \frac{1}{n - d} \sum_{i=1}^{n}(x_i - \bar{x})
/// \\]
///
/// In the formula, $$n$$ is the sample size (the length of the list) and 
/// $$x_i$$ is the sample point in the input list indexed by $$i$$. 
/// Furthermore, $$\bar{x}$$ is the sample mean and $$d$$ is the "Delta 
/// Degrees of Freedom", and is by default set to $$d = 0$$, which gives a biased
/// estimate of the sample variance. Setting $$d = 1$$ gives an unbiased estimate.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///
///     pub fn example () {
///       // Degrees of freedom
///       let ddof: Int = 1
///     
///       // An empty list returns an error
///       []
///       |> metrics.variance(ddof)
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [1., 2., 3.]
///       |> metrics.variance(ddof)
///       |> should.equal(Ok(1.))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn variance(arr: List(Float), ddof: Int) -> Result(Float, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ ->
      case ddof < 0 {
        True ->
          "Invalid input argument: ddof < 0. Valid input is ddof >= 0."
          |> Error
        False -> {
          let assert Ok(mean) = mean(arr)
          arr
          |> list.map(fn(a: Float) -> Float {
            let assert Ok(result) = elementary.power(a -. mean, 2.0)
            result
          })
          |> arithmetics.float_sum()
          |> fn(a: Float) -> Float {
            a /. {
              conversion.int_to_float(list.length(arr)) -. conversion.int_to_float(
                ddof,
              )
            }
          }
          |> Ok
        }
      }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the sample standard deviation of the elements in a list:
/// \\[
/// s = \left(\frac{1}{n - d} \sum_{i=1}^{n}(x_i - \bar{x})\right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, $$n$$ is the sample size (the length of the list) and 
/// $$x_i$$ is the sample point in the input list indexed by $$i$$. 
/// Furthermore, $$\bar{x}$$ is the sample mean and $$d$$ is the "Delta 
/// Degrees of Freedom", and is by default set to $$d = 0$$, which gives a biased
/// estimate of the sample standard deviation. Setting $$d = 1$$ gives an unbiased estimate.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///
///     pub fn example () {
///       // Degrees of freedom
///       let ddof: Int = 1
///     
///       // An empty list returns an error
///       []
///       |> metrics.standard_deviationddof)
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [1., 2., 3.]
///       |> metrics.standard_deviation(ddof)
///       |> should.equal(Ok(1.))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn standard_deviation(arr: List(Float), ddof: Int) -> Result(Float, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ ->
      case ddof < 0 {
        True ->
          "Invalid input argument: ddof < 0. Valid input is ddof >= 0."
          |> Error
        False -> {
          let assert Ok(variance) = variance(arr, ddof)
          // The computed variance will always be positive
          // So an error should never be returned 
          let assert Ok(stdev) = elementary.square_root(variance)
          stdev
          |> Ok
        }
      }
  }
}
