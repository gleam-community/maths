////<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.10/dist/katex.min.css" integrity="sha384-wcIxkf4k558AjM3Yz3BBFQUbk/zgIYC2R0QpeeYb+TwlBVMrlgLqwRjRtGZiK7ww" crossorigin="anonymous">
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.10/dist/katex.min.js" integrity="sha384-hIoBPJpTUs74ddyc4bFZSM1TVlQDA60VBbJS0oA934VSz82sBx1X7kSx2ATBDIyd" crossorigin="anonymous"></script>
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.10/dist/contrib/auto-render.min.js" integrity="sha384-43gviWU0YVjaDtb/GhzOouOXtZMP/7XUzwPTstBeZFe/+rCMvRwr4yROQP43s0Xk" crossorigin="anonymous"></script>
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
//// Metrics: A module offering functions for calculating distances and other 
//// types of metrics.
//// 
//// * **Distance measures**
////   * [`norm`](#norm)
////   * [`manhattan_distance`](#manhattan_distance)
////   * [`euclidean_distance`](#euclidean_distance)
////   * [`chebyshev_distance`](#chebyshev_distance)
////   * [`minkowski_distance`](#minkowski_distance)
////   * [`cosine_similarity`](#cosine_similarity)
////   * [`canberra_distance`](#canberra_distance)
////   * [`braycurtis_distance`](#braycurtis_distance)
//// * **Set & string similarity measures**
////   * [`jaccard_index`](#jaccard_index)
////   * [`sorensen_dice_coefficient`](#sorensen_dice_coefficient)
////   * [`tversky_index`](#tversky_index)
////   * [`overlap_coefficient`](#overlap_coefficient)
////   * [`levenshtein_distance`](#levenshtein_distance)
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
import gleam/set
import gleam/float
import gleam/int
import gleam/string
import gleam/option

/// Utility function that checks all lists have the expected length and contents
/// The function is primarily used by all distance measures taking 'List(Float)'
/// as input
fn validate_lists(
  xarr: List(Float),
  yarr: List(Float),
  weights: option.Option(List(Float)),
) -> Result(Bool, String) {
  case xarr, yarr {
    [], _ ->
      "Invalid input argument: The list xarr is empty."
      |> Error
    _, [] ->
      "Invalid input argument: The list yarr is empty."
      |> Error
    _, _ -> {
      let xarr_length: Int = list.length(xarr)
      let yarr_length: Int = list.length(yarr)
      case xarr_length == yarr_length, weights {
        False, _ ->
          "Invalid input argument: length(xarr) != length(yarr). Valid input is when length(xarr) == length(yarr)."
          |> Error
        True, option.None -> {
          True
          |> Ok
        }
        True, option.Some(warr) -> {
          let warr_length: Int = list.length(warr)
          case xarr_length == warr_length {
            True -> {
              validate_weights(warr)
            }
            False ->
              "Invalid input argument: length(weights) != length(xarr) and length(weights) != length(yarr). Valid input is when length(weights) == length(xarr) == length(yarr)."
              |> Error
          }
        }
      }
    }
  }
}

fn validate_weights(warr: List(Float)) -> Result(Bool, String) {
  // Check that all the given weights are positive
  let assert Ok(minimum) = piecewise.list_minimum(warr, float.compare)
  case minimum >=. 0.0 {
    False ->
      "Invalid input argument: One or more weights are negative. Valid input is when all weights are >= 0."
      |> Error
    True ->
      True
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) $$p$$-norm of a list (representing a vector):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_{i}\right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i$$ is the value in 
/// the input list indexed by $$i$$, while $$w_i \in \mathbb{R}_{+}$$ is
/// a corresponding positive weight ($$w_i = 1.0\\;\forall i=1...n$$ by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///     
///       let assert Ok(result) =
///         [1.0, 1.0, 1.0]
///         |> metrics.norm(1.0, option.None)
///       result
///       |> predicates.is_close(3.0, 0.0, tol)
///       |> should.be_true()
///     
///       let assert Ok(result) =
///         [1.0, 1.0, 1.0]
///         |> metrics.norm(-1.0, option.None)
///       result
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
pub fn norm(
  arr: List(Float),
  p: Float,
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  case arr, weights {
    [], _ ->
      0.0
      |> Ok
    _, option.None -> {
      let aggregate: Float =
        arr
        |> list.fold(0.0, fn(accumulator: Float, element: Float) -> Float {
          let assert Ok(result) =
            piecewise.float_absolute_value(element)
            |> elementary.power(p)
          result +. accumulator
        })
      let assert Ok(result) = elementary.power(aggregate, 1.0 /. p)
      result
      |> Ok
    }
    _, option.Some(warr) -> {
      let arr_length: Int = list.length(arr)
      let warr_length: Int = list.length(warr)
      case arr_length == warr_length {
        True -> {
          case validate_weights(warr) {
            Ok(_) -> {
              let tuples: List(#(Float, Float)) = list.zip(arr, warr)
              let aggregate: Float =
                tuples
                |> list.fold(
                  0.0,
                  fn(accumulator: Float, tuple: #(Float, Float)) -> Float {
                    let first_element: Float = pair.first(tuple)
                    let second_element: Float = pair.second(tuple)
                    let assert Ok(result) =
                      elementary.power(
                        piecewise.float_absolute_value(first_element),
                        p,
                      )
                    second_element *. result +. accumulator
                  },
                )
              let assert Ok(result) = elementary.power(aggregate, 1.0 /. p)
              result
              |> Ok
            }
            Error(msg) ->
              msg
              |> Error
          }
        }
        False -> {
          "Invalid input argument: length(weights) != length(arr). Valid input is when length(weights) == length(arr)."
          |> Error
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Manhattan distance between two lists (representing 
/// vectors):
///
/// \\[
/// \sum_{i=1}^n w_{i} \left|x_i - y_i \right|
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the 
/// values in the respective input lists indexed by $$i$$, while the
/// $$w_i \in \mathbb{R}_{+}$$ are corresponding positive weights 
/// ($$w_i = 1.0\\;\forall i=1...n$$ by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///     
///       // Empty lists returns an error
///       metrics.manhattan_distance([], [], option.None)
///       |> should.be_error()
///     
///       // Differing lengths returns error
///       metrics.manhattan_distance([], [1.0], option.None)
///       |> should.be_error()
///     
///       let assert Ok(result) =
///         metrics.manhattan_distance([0.0, 0.0], [1.0, 2.0], option.None)
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
pub fn manhattan_distance(
  xarr: List(Float),
  yarr: List(Float),
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  minkowski_distance(xarr, yarr, 1.0, weights)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Minkowski distance between two lists (representing
/// vectors):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_i - y_i \right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, $$p >= 1$$ is the order, $$n$$ is the length of the two lists 
/// and $$x_i, y_i$$ are the values in the respective input lists indexed by $$i$$.
/// The $$w_i \in \mathbb{R}_{+}$$ are corresponding positive weights 
/// ($$w_i = 1.0\\;\forall i=1...n$$ by default).
///
/// The Minkowski distance is a generalization of both the Euclidean distance 
/// ($$p=2$$) and the Manhattan distance ($$p = 1$$).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///     
///       // Empty lists returns an error
///       metrics.minkowski_distance([], [], 1.0, option.None)
///       |> should.be_error()
///     
///       // Differing lengths returns error
///       metrics.minkowski_distance([], [1.0], 1.0, option.None)
///       |> should.be_error()
///     
///       // Test order < 1
///       metrics.minkowski_distance([0.0, 0.0], [0.0, 0.0], -1.0, option.None)
///       |> should.be_error()
///     
///       let assert Ok(result) =
///         metrics.minkowski_distance([0.0, 0.0], [1.0, 2.0], 1.0, option.None)
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
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  case validate_lists(xarr, yarr, weights) {
    Error(msg) ->
      msg
      |> Error
    Ok(_) -> {
      case p <. 1.0 {
        True ->
          "Invalid input argument: p < 1. Valid input is p >= 1."
          |> Error
        False -> {
          let differences: List(Float) =
            list.zip(xarr, yarr)
            |> list.map(fn(tuple: #(Float, Float)) -> Float {
              pair.first(tuple) -. pair.second(tuple)
            })

          let assert Ok(result) = norm(differences, p, weights)
          result
          |> Ok
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Euclidean distance between two lists (representing 
/// vectors):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_i - y_i \right|^{2} \right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the
/// values in the respective input lists indexed by $$i$$, while the
/// $$w_i \in \mathbb{R}_{+}$$ are corresponding positive weights 
/// ($$w_i = 1.0\\;\forall i=1...n$$ by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       let assert Ok(tol) = elementary.power(-10.0, -6.0)
///     
///       // Empty lists returns an error
///       metrics.euclidean_distance([], [], option.None)
///       |> should.be_error()
///     
///       // Differing lengths returns an error
///       metrics.euclidean_distance([], [1.0], option.None)
///       |> should.be_error()
///     
///       let assert Ok(result) =
///         metrics.euclidean_distance([0.0, 0.0], [1.0, 2.0], option.None)
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
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  minkowski_distance(xarr, yarr, 2.0, weights)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the Chebyshev distance between two lists (representing vectors):
///
/// \\[
/// \text{max}_{i=1}^n \left|x_i - y_i \right|
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i, y_i$$ are the 
/// values in the respective input lists indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/elementary
///     import gleam_community/maths/metrics
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       // Empty lists returns an error
///       metrics.chebyshev_distance([], [])
///       |> should.be_error()
///     
///       // Differing lengths returns error
///       metrics.chebyshev_distance([], [1.0])
///       |> should.be_error()
///     
///       metrics.chebyshev_distance([-5.0, -10.0, -3.0], [-1.0, -12.0, -3.0])
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
pub fn chebyshev_distance(
  xarr: List(Float),
  yarr: List(Float),
) -> Result(Float, String) {
  case validate_lists(xarr, yarr, option.None) {
    Error(msg) ->
      msg
      |> Error
    Ok(_) -> {
      list.zip(xarr, yarr)
      |> list.map(fn(tuple: #(Float, Float)) -> Float {
        { pair.first(tuple) -. pair.second(tuple) }
        |> piecewise.float_absolute_value()
      })
      |> piecewise.list_maximum(float.compare)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the arithmetic mean of the elements in a list:
///
/// \\[
/// \bar{x} = \frac{1}{n}\sum_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the sample size (the length of the list) and $$x_i$$
/// is the sample point in the input list indexed by $$i$$.
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
      |> arithmetics.float_sum(option.None)
      |> fn(a: Float) -> Float {
        a /. conversion.int_to_float(list.length(arr))
      }
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the median of the elements in a list.
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
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the sample variance of the elements in a list:
/// 
/// \\[
/// s^{2} = \frac{1}{n - d} \sum_{i=1}^{n}(x_i - \bar{x})
/// \\]
///
/// In the formula, $$n$$ is the sample size (the length of the list) and $$x_i$$ 
/// is the sample point in the input list indexed by $$i$$. 
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
          |> arithmetics.float_sum(option.None)
          |> fn(a: Float) -> Float {
            a
            /. {
              conversion.int_to_float(list.length(arr))
              -. conversion.int_to_float(ddof)
            }
          }
          |> Ok
        }
      }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the sample standard deviation of the elements in a list:
/// \\[
/// s = \left(\frac{1}{n - d} \sum_{i=1}^{n}(x_i - \bar{x})\right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, $$n$$ is the sample size (the length of the list) and $$x_i$$ 
/// is the sample point in the input list indexed by $$i$$. 
/// Furthermore, $$\bar{x}$$ is the sample mean and $$d$$ is the "Delta 
/// Degrees of Freedom", and is by default set to $$d = 0$$, which gives a biased
/// estimate of the sample standard deviation. Setting $$d = 1$$ gives an unbiased 
/// estimate.
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

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The Jaccard index measures similarity between two sets of elements. 
/// Mathematically, the Jaccard index is defined as:
/// 
/// \\[
/// \frac{|X \cap Y|}{|X \cup Y|} \\; \in \\; \left[0, 1\right]
/// \\]
/// 
/// where:
///
/// - $$X$$ and $$Y$$ are two sets being compared,
/// - $$|X \cap Y|$$ represents the size of the intersection of the two sets
/// - $$|X \cup Y|$$ denotes the size of the union of the two sets
/// 
/// The value of the Jaccard index ranges from 0 to 1, where 0 indicates that the 
/// two sets share no elements and 1 indicates that the sets are identical. The 
/// Jaccard index is a special case of the  [Tversky index](#tversky_index) (with
/// $$\alpha=\beta=1$$).
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///     import gleam/set
///
///     pub fn example () {
///       let xset: set.Set(String) = set.from_list(["cat", "dog", "hippo", "monkey"])
///       let yset: set.Set(String) =
///         set.from_list(["monkey", "rhino", "ostrich", "salmon"])
///       metrics.jaccard_index(xset, yset)
///       |> should.equal(1.0 /. 7.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn jaccard_index(xset: set.Set(a), yset: set.Set(a)) -> Float {
  let assert Ok(result) = tversky_index(xset, yset, 1.0, 1.0)
  result
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The Sørensen-Dice coefficient measures the similarity between two sets of 
/// elements. Mathematically, the coefficient is defined as:
/// 
/// \\[
/// \frac{2 |X \cap Y|}{|X| + |Y|} \\; \in \\; \left[0, 1\right]
/// \\]
/// 
/// where:
/// - $$X$$ and $$Y$$ are two sets being compared
/// - $$|X \cap Y|$$ is the size of the intersection of the two sets (i.e., the 
/// number of elements common to both sets)
/// - $$|X|$$ and $$|Y|$$ are the sizes of the sets $$X$$ and $$Y$$, respectively
/// 
/// The coefficient ranges from 0 to 1, where 0 indicates no similarity (the sets
/// share no elements) and 1 indicates perfect similarity (the sets are identical).
/// The higher the coefficient, the greater the similarity between the two sets. 
/// The Sørensen-Dice coefficient is a special case of the 
/// [Tversky index](#tversky_index) (with $$\alpha=\beta=0.5$$).
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///     import gleam/set
///
///     pub fn example () {
///       let xset: set.Set(String) = set.from_list(["cat", "dog", "hippo", "monkey"])
///       let yset: set.Set(String) =
///         set.from_list(["monkey", "rhino", "ostrich", "salmon", "spider"])
///       metrics.sorensen_dice_coefficient(xset, yset)
///       |> should.equal(2.0 *. 1.0 /. { 4.0 +. 5.0 })
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sorensen_dice_coefficient(xset: set.Set(a), yset: set.Set(a)) -> Float {
  let assert Ok(result) = tversky_index(xset, yset, 0.5, 0.5)
  result
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
/// 
/// The Tversky index is a generalization of the Jaccard index and Sørensen-Dice 
/// coefficient, which adds flexibility through two parameters, $$\alpha$$ and 
/// $$\beta$$, allowing for asymmetric similarity measures between sets. The 
/// Tversky index is defined as:
/// 
/// \\[
/// \frac{|X \cap Y|}{|X \cap Y| + \alpha|X - Y| + \beta|Y - X|}
/// \\]
/// 
/// where:
/// 
/// - $$X$$ and $$Y$$ are the sets being compared
/// - $$|X - Y|$$ and $$|Y - X|$$ are the sizes of the relative complements of 
/// $$Y$$ in $$X$$ and $$X$$ in $$Y$$, respectively,
/// - $$\alpha$$ and $$\beta$$ are parameters that weigh the relative importance
/// of the elements unique to $$X$$ and $$Y$$
/// 
/// The Tversky index reduces to the Jaccard index when $$\alpha = \beta = 1$$ and
/// to the Sørensen-Dice coefficient when $$\alpha = \beta = 0.5$$. In general, the
/// Tversky index can take on any non-negative value, including 0. The index equals
/// 0 when there is no intersection between the two sets, indicating no similarity. 
/// However, unlike similarity measures bounded strictly between 0 and 1, the 
/// Tversky index does not have a strict upper limit of 1 when $$\alpha \neq \beta$$.
///  
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///     import gleam/set
///
///     pub fn example () {
///       let yset: set.Set(String) = set.from_list(["cat", "dog", "hippo", "monkey"])
///       let xset: set.Set(String) =
///         set.from_list(["monkey", "rhino", "ostrich", "salmon"])
///       // Test Jaccard index (alpha = beta = 1)
///       metrics.tversky_index(xset, yset, 1.0, 1.0)
///       |> should.equal(1.0 /. 7.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tversky_index(
  xset: set.Set(a),
  yset: set.Set(a),
  alpha: Float,
  beta: Float,
) -> Result(Float, String) {
  case alpha >=. 0.0, beta >=. 0.0 {
    True, True -> {
      let intersection: Float =
        set.intersection(xset, yset)
        |> set.size()
        |> conversion.int_to_float()
      let difference1: Float =
        set.difference(xset, yset)
        |> set.size()
        |> conversion.int_to_float()
      let difference2: Float =
        set.difference(yset, xset)
        |> set.size()
        |> conversion.int_to_float()
      intersection
      /. { intersection +. alpha *. difference1 +. beta *. difference2 }
      |> Ok
    }
    False, True -> {
      "Invalid input argument: alpha < 0. Valid input is alpha >= 0."
      |> Error
    }
    True, False -> {
      "Invalid input argument: beta < 0. Valid input is beta >= 0."
      |> Error
    }
    _, _ -> {
      "Invalid input argument: alpha < 0 and beta < 0. Valid input is alpha >= 0 and beta >= 0."
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
/// The Overlap coefficient, also known as the Szymkiewicz–Simpson coefficient, is
/// a measure of similarity between two sets that focuses on the size of the 
/// intersection relative to the smaller of the two sets. It is defined 
/// mathematically as:
///
/// \\[
/// \frac{|X \cap Y|}{\min(|X|, |Y|)} \\; \in \\; \left[0, 1\right]
/// \\]
///
/// where:
///
/// - $$X$$ and $$Y$$ are the sets being compared
/// - $$|X \cap Y|$$ is the size of the intersection of the sets
/// - $$\min(|X|, |Y|)$$ is the size of the smaller set among $$X$$ and $$Y$$
///
/// The coefficient ranges from 0 to 1, where 0 indicates no overlap and 1 
/// indicates that the smaller set is a suyset of the larger set. This 
/// measure is especially useful in situations where the similarity in terms
/// of the proportion of overlap is more relevant than the difference in sizes 
/// between the two sets.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///     import gleam/set
///
///     pub fn example () {
///       let set_a: set.Set(String) =
///         set.from_list(["horse", "dog", "hippo", "monkey", "bird"])
///       let set_b: set.Set(String) =
///         set.from_list(["monkey", "bird", "ostrich", "salmon"])
///       metrics.overlap_coefficient(set_a, set_b)
///       |> should.equal(2.0 /. 4.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn overlap_coefficient(xset: set.Set(a), yset: set.Set(a)) -> Float {
  let intersection: Float =
    set.intersection(xset, yset)
    |> set.size()
    |> conversion.int_to_float()
  let minsize: Float =
    piecewise.minimum(set.size(xset), set.size(yset), int.compare)
    |> conversion.int_to_float()
  intersection /. minsize
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
/// 
/// Calculate the (weighted) cosine similarity between two lists (representing
/// vectors):
///
/// \\[
/// \frac{\sum_{i=1}^n w_{i} \cdot x_i \cdot y_i}
/// {\left(\sum_{i=1}^n w_{i} \cdot x_i^2\right)^{\frac{1}{2}}
/// \cdot 
/// \left(\sum_{i=1}^n w_{i} \cdot y_i^2\right)^{\frac{1}{2}}} 
/// \\; \in \\; \left[-1, 1\right]
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists and $$x_i$$, $$y_i$$ are
/// the values in the respective input lists indexed by $$i$$, while the
/// $$w_i \in \mathbb{R}_{+}$$ are corresponding positive weights 
/// ($$w_i = 1.0\\;\forall i=1...n$$ by default). 
/// 
/// The cosine similarity provides a value between -1 and 1, where 1 means the 
/// vectors are in the same direction, -1 means they are in exactly opposite 
/// directions, and 0 indicates orthogonality. 
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/metrics
///
///     pub fn example() {
///       // Two orthogonal vectors
///       metrics.cosine_similarity([-1.0, 1.0, 0.0], [1.0, 1.0, -1.0], option.None)
///       |> should.equal(Ok(0.0))
///     
///       // Two identical (parallel) vectors
///       metrics.cosine_similarity([1.0, 2.0, 3.0], [1.0, 2.0, 3.0], option.None)
///       |> should.equal(Ok(1.0))
///     
///       // Two parallel, but oppositely oriented vectors
///       metrics.cosine_similarity([-1.0, -2.0, -3.0], [1.0, 2.0, 3.0], option.None)
///       |> should.equal(Ok(-1.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cosine_similarity(
  xarr: List(Float),
  yarr: List(Float),
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  case validate_lists(xarr, yarr, weights) {
    Error(msg) ->
      msg
      |> Error
    Ok(_) -> {
      let zipped_arr: List(#(Float, Float)) = list.zip(xarr, yarr)

      let numerator_elements: List(Float) =
        zipped_arr
        |> list.map(fn(tuple: #(Float, Float)) -> Float {
          pair.first(tuple) *. pair.second(tuple)
        })

      case weights {
        option.None -> {
          let numerator: Float =
            numerator_elements
            |> arithmetics.float_sum(option.None)

          let assert Ok(xarr_norm) = norm(xarr, 2.0, option.None)
          let assert Ok(yarr_norm) = norm(yarr, 2.0, option.None)
          let denominator: Float = {
            xarr_norm *. yarr_norm
          }
          numerator /. denominator
          |> Ok
        }
        _ -> {
          let numerator: Float =
            numerator_elements
            |> arithmetics.float_sum(weights)

          let assert Ok(xarr_norm) = norm(xarr, 2.0, weights)
          let assert Ok(yarr_norm) = norm(yarr, 2.0, weights)
          let denominator: Float = {
            xarr_norm *. yarr_norm
          }
          numerator /. denominator
          |> Ok
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
/// 
/// Calculate the Levenshtein distance between two strings, i.e., measure the 
/// difference between two strings (essentially sequences). It is defined as 
/// the minimum number of single-character edits required to change one string
/// into the other, using operations:
/// - insertions
/// - deletions
/// - substitutions
/// 
/// Note: The implementation is primarily based on the Elixir implementation 
/// [levenshtein](https://hex.pm/packages/levenshtein).
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/metrics
///
///     pub fn example () {
///       metrics.levenshtein_distance("hello", "hello")
///       |> should.equal(0)
///       
///       metrics.levenshtein_distance("cat", "cut")
///       |> should.equal(1)
///       
///       metrics.levenshtein_distance("kitten", "sitting")
///       |> should.equal(3)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
///
pub fn levenshtein_distance(xstring: String, ystring: String) -> Int {
  case xstring, ystring {
    xstring, ystring if xstring == ystring -> {
      0
    }
    xstring, ystring if xstring == "" -> {
      string.length(ystring)
    }
    xstring, ystring if ystring == "" -> {
      string.length(xstring)
    }
    _, _ -> {
      let xstring_graphemes = string.to_graphemes(xstring)
      let ystring_graphemes = string.to_graphemes(ystring)
      let ystring_length = list.length(ystring_graphemes)
      let distance_list = list.range(0, ystring_length)

      do_edit_distance(xstring_graphemes, ystring_graphemes, distance_list, 1)
    }
  }
}

fn do_edit_distance(
  xstring: List(String),
  ystring: List(String),
  distance_list: List(Int),
  step: Int,
) -> Int {
  case xstring {
    // Safe as 'distance_list' is never empty
    [] -> {
      let assert Ok(last) = list.last(distance_list)
      last
    }
    [xstring_head, ..xstring_tail] -> {
      let new_distance_list =
        distance_list_helper(ystring, distance_list, xstring_head, [step], step)
      do_edit_distance(xstring_tail, ystring, new_distance_list, step + 1)
    }
  }
}

fn distance_list_helper(
  ystring: List(String),
  distance_list: List(Int),
  grapheme: String,
  new_distance_list: List(Int),
  last_distance: Int,
) -> List(Int) {
  case ystring {
    [] -> list.reverse(new_distance_list)
    [ystring_head, ..ystring_tail] -> {
      let assert [distance_list_head, ..distance_list_tail] = distance_list
      let difference = case ystring_head == grapheme {
        True -> {
          0
        }
        False -> {
          1
        }
      }
      let assert [first, ..] = distance_list_tail
      let min =
        last_distance + 1
        |> piecewise.minimum(first + 1, int.compare)
        |> piecewise.minimum(distance_list_head + difference, int.compare)
      distance_list_helper(
        ystring_tail,
        distance_list_tail,
        grapheme,
        [min, ..new_distance_list],
        min,
      )
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
/// 
/// Calculate the (weighted) Canberra distance between two lists:
///
/// \\[
/// \sum_{i=1}^n w_{i}\frac{\left| x_i - y_i \right|}
/// {\left| x_i \right| + \left| y_i \right|}
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists, and $$x_i, y_i$$ are the 
/// values in the respective input lists indexed by $$i$$, while the 
/// $$w_i \in \mathbb{R}_{+}$$ are corresponding positive weights 
/// ($$w_i = 1.0\\;\forall i=1...n$$ by default). 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/metrics
///
///     pub fn example() {
///       // Empty lists returns an error
///       metrics.canberra_distance([], [], option.None)
///       |> should.be_error()
///     
///       // Different sized lists returns an error
///       metrics.canberra_distance([1.0, 2.0], [1.0, 2.0, 3.0, 4.0], option.None)
///       |> should.be_error()
///     
///       // Valid inputs
///       metrics.canberra_distance([1.0, 2.0], [-2.0, -1.0], option.None)
///       |> should.equal(Ok(2.0))
///     
///       metrics.canberra_distance([1.0, 0.0], [0.0, 2.0], option.Some([1.0, 0.5]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
///
pub fn canberra_distance(
  xarr: List(Float),
  yarr: List(Float),
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  case validate_lists(xarr, yarr, weights) {
    Error(msg) ->
      msg
      |> Error
    Ok(_) -> {
      let arr: List(Float) =
        list.zip(xarr, yarr)
        |> list.map(canberra_distance_helper)

      case weights {
        option.None -> {
          arr
          |> arithmetics.float_sum(option.None)
          |> Ok
        }
        _ -> {
          arr
          |> arithmetics.float_sum(weights)
          |> Ok
        }
      }
    }
  }
}

fn canberra_distance_helper(tuple: #(Float, Float)) -> Float {
  let numerator: Float =
    piecewise.float_absolute_value({ pair.first(tuple) -. pair.second(tuple) })
  let denominator: Float = {
    piecewise.float_absolute_value(pair.first(tuple))
    +. piecewise.float_absolute_value(pair.second(tuple))
  }
  numerator /. denominator
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
/// 
/// Calculate the (weighted) Bray-Curtis distance between two lists:
///
/// \\[
/// \frac{\sum_{i=1}^n w_{i} \left| x_i - y_i \right|}
/// {\sum_{i=1}^n w_{i}\left| x_i + y_i \right|}
/// \\]
///
/// In the formula, $$n$$ is the length of the two lists, and $$x_i, y_i$$ are the values 
/// in the respective input lists indexed by $$i$$, while the 
/// $$w_i \in \mathbb{R}_{+}$$ are corresponding positive weights 
/// ($$w_i = 1.0\\;\forall i=1...n$$ by default).
/// 
/// The Bray-Curtis distance is in the range $$[0, 1]$$ if all entries $$x_i, y_i$$ are
/// positive.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/metrics
///
///     pub fn example() {
///       // Empty lists returns an error
///       metrics.braycurtis_distance([], [], option.None)
///       |> should.be_error()
///     
///       // Different sized lists returns an error
///       metrics.braycurtis_distance([1.0, 2.0], [1.0, 2.0, 3.0, 4.0], option.None)
///       |> should.be_error()
///     
///       // Valid inputs
///       metrics.braycurtis_distance([1.0, 0.0], [0.0, 2.0], option.None)
///       |> should.equal(Ok(1.0))
///     
///       metrics.braycurtis_distance([1.0, 2.0], [3.0, 4.0], option.Some([0.5, 1.0]))
///       |> should.equal(Ok(0.375))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
///
pub fn braycurtis_distance(
  xarr: List(Float),
  yarr: List(Float),
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  case validate_lists(xarr, yarr, weights) {
    Error(msg) ->
      msg
      |> Error
    Ok(_) -> {
      let zipped_arr: List(#(Float, Float)) = list.zip(xarr, yarr)
      let numerator_elements: List(Float) =
        zipped_arr
        |> list.map(fn(tuple: #(Float, Float)) -> Float {
          piecewise.float_absolute_value({
            pair.first(tuple) -. pair.second(tuple)
          })
        })
      let denominator_elements: List(Float) =
        zipped_arr
        |> list.map(fn(tuple: #(Float, Float)) -> Float {
          piecewise.float_absolute_value({
            pair.first(tuple) +. pair.second(tuple)
          })
        })

      case weights {
        option.None -> {
          let numerator =
            numerator_elements
            |> arithmetics.float_sum(option.None)
          let denominator =
            denominator_elements
            |> arithmetics.float_sum(option.None)
          { numerator /. denominator }
          |> Ok
        }
        _ -> {
          let numerator =
            numerator_elements
            |> arithmetics.float_sum(weights)
          let denominator =
            denominator_elements
            |> arithmetics.float_sum(weights)
          { numerator /. denominator }
          |> Ok
        }
      }
    }
  }
}
