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
//// A module containing general utility functions applying to lists.
////
//// ---
////
//// * **Miscellaneous functions**
////   * [`trim`](#trim)

import gleam/list
import gleam/int
import gleam/float
import gleam/set
import gleam/io

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Trim a list to a certain size given min/max indices. The min/max indices are inclusive. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/list as listx
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> listx.trim(0, 0)
///       |> should.be_error()
///     
///       // Trim the list to only the middle part of list
///       [1., 2., 3., 4., 5., 6.]
///       |> listx.trim(1, 4)
///       |> should.equal(Ok([2., 3., 4., 5.]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn trim(arr: List(a), min: Int, max: Int) -> Result(List(a), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ ->
      case min >= 0 && max < list.length(arr) {
        False ->
          "Invalid input argument: min < 0 or max < length(arr). Valid input is min > 0 and max < length(arr)."
          |> Error
        True ->
          arr
          |> list.drop(min)
          |> list.take(max - min + 1)
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
/// Generate all $$k$$-combinations based on a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/list
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn combination(arr: List(a), k: Int) -> List(a) {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generate all permutations based on a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/list
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn permutation(arr: List(a)) -> List(a) {
  todo
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generate a list containing all combinations of pairs of elements coming from two given lists.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/list
///     import gleam_community/maths/float_list
///
///     pub fn example () {
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cartesian_product(xarr: List(a), yarr: List(a)) -> List(#(a, a)) {
  let xset: set.Set(a) =
    xarr
    |> set.from_list()
  let yset: set.Set(a) =
    yarr
    |> set.from_list()
  xset
  |> set.fold(
    set.new(),
    fn(accumulator0: set.Set(#(a, a)), member0: a) -> set.Set(#(a, a)) {
      set.fold(
        yset,
        accumulator0,
        fn(accumulator1: set.Set(#(a, a)), member1: a) -> set.Set(#(a, a)) {
          io.debug(#(member0, member1))
          set.insert(accumulator1, #(member0, member1))
        },
      )
    },
  )
  |> set.to_list()
}
