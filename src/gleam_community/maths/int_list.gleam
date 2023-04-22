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
////   * [`cumulative_sum`](#cumulative_sum)
////   * [`cumulative_product`](#cumulative_product)
////   * [`manhatten_distance`](#manhatten_distance)
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
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // Empty lists returns 0
///       int_list.manhatten_distance([], [])
///       |> should.equal(Ok(0))
///     
///       // Differing lengths returns error
///       int_list.manhatten_distance([], [1])
///       |> should.be_error()
///     
///       let assert Ok(result) = int_list.manhatten_distance([0, 0], [1, 2])
///       result
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
pub fn manhatten_distance(
  xarr: List(Int),
  yarr: List(Int),
) -> Result(Int, String) {
  let xlen: Int = list.length(xarr)
  let ylen: Int = list.length(yarr)
  case xlen == ylen {
    False ->
      "Invalid input argument: length(xarr) != length(yarr). Valid input is when length(xarr) == length(yarr)."
      |> Error
    True ->
      list.zip(xarr, yarr)
      |> list.map(fn(tuple: #(Int, Int)) -> Int {
        int.absolute_value(pair.first(tuple) - pair.second(tuple))
      })
      |> sum()
      |> Ok
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
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty list returns 0
///       []
///       |> int_list.sum()
///       |> should.equal(0)
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> int_list.sum()
///       |> should.equal(6)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sum(arr: List(Int)) -> Int {
  case arr {
    [] -> 0
    _ ->
      arr
      |> list.fold(0, fn(acc: Int, a: Int) -> Int { a + acc })
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
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty list returns 0
///       []
///       |> int_list.product()
///       |> should.equal(0)
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> int_list.product()
///       |> should.equal(6)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn product(arr: List(Int)) -> Int {
  case arr {
    [] -> 1
    _ ->
      arr
      |> list.fold(1, fn(acc: Int, a: Int) -> Int { a * acc })
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
/// v_j = \sum_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative sum of $$n$$ elements.
/// That is, $$n$$ is the length of the list and $$x_i$$ is the value in the input list indexed by $$i$$. 
/// The value $$v_j$$ is thus the sum of the $$1$$ to $$j$$ first elements in the given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       []
///       |> int_list.cumulative_sum()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> int_list.cumulative_sum()
///       |> should.equal([1, 3, 6])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cumulative_sum(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(0, fn(acc: Int, a: Int) -> Int { a + acc })
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
/// v_j = \prod_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative product of $$n$$ elements.
/// That is, $$n$$ is the length of the list and $$x_i$$ is the value in the input list indexed by $$i$$. 
/// The value $$v_j$$ is thus the product of the $$1$$ to $$j$$ first elements in the given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int_list
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> int_list.cumulative_product()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> int_list.cumulative_product()
///       |> should.equal([1, 2, 6])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cumulative_product(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(1, fn(acc: Int, a: Int) -> Int { a * acc })
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
///       |> int_list.arg_minimum()
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
      let assert Ok(min) =
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
      let assert Ok(max) =
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
      let assert Ok(val0) = list.at(arr, 0)
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
      let assert Ok(val0) = list.at(arr, 0)
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
/// Returns a tuple consisting of the minimum and maximum value of a list. 
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
      let assert Ok(val_max) = list.at(arr, 0)
      let assert Ok(val_min) = list.at(arr, 0)
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
