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
////   * [`trim`](#trim)

import gleam/list
import gleam/int
import gleam/float

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Trim a list to a certain size given min/max indices. The min/max indices 
/// are inclusive. 
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
///       |> stats.trim(0, 0)
///       |> should.be_error()
///     
///       // Trim the list to only the middle part of list
///       [1., 2., 3., 4., 5., 6.]
///       |> stats.trim(1, 4)
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
