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
//// A module containing mathematical functions applying to one or more lists of integers.
////
//// ---
////
//// * **Distances, sums and products**
////   * [`sum`](#sum)
////   * [`product`](#product)
////   * [`norm`](#norm)
////   * [`cumulative_sum`](#cumulative_sum)
////   * [`cumulative_product`](#cumulative_product)
//// * **Misc. mathematical functions**
////   * [`maximum`](#maximum)
////   * [`minimum`](#minimum)
////   * [`extrema`](#extrema)
////   * [`arg_maximum`](#arg_maximum)
////   * [`arg_minimum`](#arg_minimum)

import gleam/list
import gleam/int
import gleam/float
import gleam/pair
import gleam_community/maths/int as intx

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
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> int_list.arg_minimum()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4, 4, 3, 2, 1]
///       |> stats.arg_minimum()
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
pub fn arg_minimum(arr: List(Int)) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(min) =
        arr
        |> minimum()
      arr
      |> list.index_map(fn(index: Int, a: Int) -> Int {
        case a - min {
          0 -> index
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
/// Returns the indices of the maximum values in a list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> int_list.arg_maximum()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4, 4, 3, 2, 1]
///       |> int_list.arg_maximum()
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
pub fn arg_maximum(arr: List(Int)) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(max) =
        arr
        |> maximum()
      arr
      |> list.index_map(fn(index: Int, a: Int) -> Int {
        case a - max {
          0 -> index
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
/// Returns the maximum value of a list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> int_list.maximum()
///       |> should.be_error()
///
///       // Valid input returns a result
///       [4, 4, 3, 2, 1]
///       |> int_list.maximum()
///       |> should.equal(Ok(4))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn maximum(arr: List(Int)) -> Result(Int, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(val0) = list.at(arr, 0)
      arr
      |> list.fold(
        val0,
        fn(acc: Int, a: Int) {
          case a > acc {
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
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> int_list.minimum()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4, 4, 3, 2, 1]
///       |> int_list.minimum()
///       |> should.equal(Ok(1))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minimum(arr: List(Int)) -> Result(Int, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      assert Ok(val0) = list.at(arr, 0)
      arr
      |> list.fold(
        val0,
        fn(acc: Int, a: Int) {
          case a < acc {
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
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> int_list.extrema()
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4, 4, 3, 2, 1]
///       |> int_list.extrema()
///       |> should.equal(Ok(#(1, 4)))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn extrema(arr: List(Int)) -> Result(#(Int, Int), String) {
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
        fn(acc: #(Int, Int), a: Int) {
          let first: Int = pair.first(acc)
          let second: Int = pair.second(acc)
          case a < first, a > second {
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
