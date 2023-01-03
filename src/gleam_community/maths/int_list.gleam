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
//// A module containing several different kinds of mathematical functions 
//// applying to lists of real numbers.
////
//// Function naming has been adopted from <a href="https://en.wikipedia.org/wiki/C_mathematical_functions"> C mathematical function</a>.
//// 
//// ---
////
//// * **Miscellaneous functions**
////   * [`allclose`](#allclose)
////   * [`amax`](#amax)
////   * [`amin`](#amin)
////   * [`argmax`](#argmax)
////   * [`argmin`](#argmin)
////   * [`allclose`](#allclose)
////   * [`trim`](#trim)

import gleam/list
import gleam/int
import gleam/float
import gleam/pair
import gleam_community/maths/int as intx

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     import gleam_stats/stats
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> stats.argmin()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4., 4., 3., 2., 1.]
///       |> stats.argmin()
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
pub fn argmin(arr: List(Float)) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(min) =
        arr
        |> amin()
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
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     import gleam_stats/stats
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> stats.argmax()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4., 4., 3., 2., 1.]
///       |> stats.argmax()
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
pub fn argmax(arr: List(Float)) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(max) =
        arr
        |> amax()
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
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     import gleam_stats/stats
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> stats.amax()
///       |> should.be_error()
///
///       // Valid input returns a result
///       [4., 4., 3., 2., 1.]
///       |> stats.amax()
///       |> should.equal(Ok(4.))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn amax(arr: List(Float)) -> Result(Float, String) {
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
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     import gleam_stats/stats
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> stats.amin()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4., 4., 3., 2., 1.]
///       |> stats.amin()
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
pub fn amin(arr: List(Float)) -> Result(Float, String) {
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
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     import gleam_stats/stats
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> stats.amin()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4., 4., 3., 2., 1.]
///       |> stats.amin()
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
pub fn extrema(arr: List(Float)) -> Result(#(Float, Float), String) {
  todo
  // case arr {
  //   [] ->
  //     "Invalid input argument: The list is empty."
  //     |> Error
  //   _ -> {
  //     assert Ok(val0) = list.at(arr, 0)
  //     arr
  //     |> list.fold(
  //       val0,
  //       fn(acc: Float, a: Float) {
  //         case a <. acc {
  //           True -> a
  //           False -> acc
  //         }
  //       },
  //     )
  //     |> Ok
  //   }
  // }
}
