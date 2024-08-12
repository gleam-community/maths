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
//// Conversion: A module containing various functions for converting between types and quantities.
//// 
//// * **Misc. functions**
////   * [`float_to_int`](#float_to_int)
////   * [`int_to_float`](#int_to_float)
////   * [`degrees_to_radians`](#degrees_to_radians)
////   * [`radians_to_degrees`](#radians_to_degrees)

import gleam/int

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that produces a number of type `Float` from an `Int`.
/// 
/// Note: The function is equivalent to the `int.to_float` function in the Gleam stdlib.
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/conversion
///
///     pub fn example() {
///       conversion.int_to_float(-1)
///       |> should.equal(-1.0)
///     
///       conversion.int_to_float(1)
///       |> should.equal(1.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_to_float(x: Int) -> Float {
  int.to_float(x)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns the integral part of a given floating point value.
/// That is, everything after the decimal point of a given floating point value is discarded and only the integer value before the decimal point is returned. 
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/conversion
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       conversion.float_to_int(12.0654)
///       |> should.equal(12)
///       
///       // Note: Making the following function call is equivalent
///       // but instead of returning a value of type 'Int' a value
///       // of type 'Float' is returned.
///       piecewise.round(12.0654, option.Some(0), option.Some(piecewise.RoundToZero))
///       |> should.equal(Ok(12.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_to_int(x: Float) -> Int {
  do_to_int(x)
}

@external(erlang, "erlang", "trunc")
@external(javascript, "../../maths.mjs", "truncate")
fn do_to_int(a: Float) -> Int

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Convert a value in degrees to a value measured in radians.
/// That is, $$1 \text{ degrees } = \frac{\pi}{180} \text{ radians }$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/conversion
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       conversion.degrees_to_radians(360.)
///       |> should.equal(2. *. elementary.pi())
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn degrees_to_radians(x: Float) -> Float {
  x *. do_pi() /. 180.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Convert a value in degrees to a value measured in radians.
/// That is, $$1 \text{ radians } = \frac{180}{\pi} \text{ degrees }$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/conversion
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       conversion.radians_to_degrees(0.0)
///       |> should.equal(0.0)
///
///       conversion.radians_to_degrees(2. *. elementary.pi())
///       |> should.equal(360.)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn radians_to_degrees(x: Float) -> Float {
  x *. 180.0 /. do_pi()
}

@external(erlang, "math", "pi")
@external(javascript, "../../maths.mjs", "pi")
fn do_pi() -> Float
