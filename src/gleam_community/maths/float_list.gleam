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
////   * [`norm`](#norm)
////   * [`minkowski`](#minkowski)
////   * [`euclidean`](#euclidean)
////   * [`manhatten`](#manhatten)
////   * [`root_mean_squared_error`](#root_mean_squared_error)
////   * [`mean_squared_error`](#mean_squared_error)
////   * [`cumulative_sum`](#cumulative_sum)
////   * [`cumulative_product`](#cumulative_product)
//// * **Ranges and intervals**
////   * [`linear_space`](#linear_space)
////   * [`logarithm_space`](#logarithm_space)
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

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn norm(xarr: List(Float), p: Int) -> Float {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minkowski(xarr: List(Float), yarr: List(Float), p: Int) -> Float {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn euclidean(xarr: List(Float), yarr: List(Float)) -> Float {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn manhatten(xarr: List(Float), yarr: List(Float)) -> Float {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn mean_squared_error(xarr: List(Float), yarr: List(Float)) -> Float {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn root_mean_squared_error(xarr: List(Float), yarr: List(Float)) -> Float {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Return evenly spaced numbers over a specified interval.
/// Returns num evenly spaced samples, calculated over the interval [start, stop].
/// The endpoint of the interval can optionally be excluded.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
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
  endpoint: option.Option(Bool),
) -> List(Float) {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Return numbers spaced evenly on a logarrithmic scale.
/// In linear space, the sequence starts at base ** start (base to the power of start) and ends with base ** stop.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithm_space(
  start: Float,
  stop: Float,
  num: Int,
  endpoint: option.Option(Bool),
  base: Int,
) -> List(Float) {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Return numbers spaced evenly on a log scale (a geometric progression).
/// This is similar to logspace, but with endpoints specified directly. Each output sample is a constant multiple of the previous.
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///
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
  endpoint: option.Option(Bool),
) -> List(Float) {
  todo
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
///       |> should.equal(0.)
///
///       // Valid input returns a result
///       [1., 2., 3.]
///       |> float_list.sum()
///       |> should.equal(6.)
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
///       // An empty list returns an error
///       []
///       |> float_list.sum()
///       |> should.equal(0.)
///
///       // Valid input returns a result
///       [1., 2., 3.]
///       |> float_list.product()
///       |> should.equal(6.)
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
      |> list.fold(0.0, fn(acc: Float, a: Float) -> Float { a *. acc })
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
  todo
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
///       // An empty list returns an error
///       []
///       |> float_list.sum()
///       |> should.equal(0.)
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
  todo
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
          0. -> index
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
          0. -> index
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
