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
//// Piecewise: A module containing functions that have different definitions depending on conditions or intervals of their domain.
//// 
//// * **Rounding functions**
////   * [`ceiling`](#ceiling)
////   * [`floor`](#floor)
////   * [`truncate`](#truncate)
////   * [`round`](#round)
//// * **Sign and absolute value functions**
////   * [`float_absolute_value`](#float_absolute_value)
////   * [`int_absolute_value`](#int_absolute_value)
////   * [`float_absolute_difference`](#float_absolute_difference)
////   * [`int_absolute_difference`](#int_absolute_difference)
////   * [`float_sign`](#float_sign)
////   * [`int_sign`](#int_sign)
////   * [`float_copy_sign`](#float_copy_sign)
////   * [`int_copy_sign`](#float_copy_sign)
////   * [`float_flip_sign`](#float_flip_sign)
////   * [`int_flip_sign`](#int_flip_sign)
//// * **Misc. mathematical functions**
////   * [`minimum`](#minimum)
////   * [`maximum`](#maximum)
////   * [`minmax`](#minmax)
////   * [`list_minimum`](#list_minimum)
////   * [`list_maximum`](#list_maximum)
////   * [`extrema`](#extrema)
////   * [`arg_minimum`](#arg_minimum)
////   * [`arg_maximum`](#arg_maximum)
////

import gleam/option
import gleam/list
import gleam/order
import gleam/pair
import gleam/int
import gleam_community/maths/conversion
import gleam_community/maths/elementary

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The ceiling function rounds a given input value $$x \in \mathbb{R}$$ to the nearest integer value (at the specified digit) that is larger than or equal to the input $$x$$. 
///
/// Note: The ceiling function is used as an alias for the rounding function [`round`](#round) with rounding mode `RoundUp`.
///
/// <details>
///     <summary>Details</summary>
///
///   For example, $$12.0654$$ is rounded to:
///   - $$13.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.1$$ for 1 digit after the decimal point (`digits = 1`)
///   - $$12.07$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.066$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   For example, $$12.0654$$ is rounded to:
///   - $$20.0$$ for 1 digit places before the decimal point (`digit = -1`)
///   - $$100.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$1000.0$$ for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.ceiling(12.0654, option.Some(1))
///       |> should.equal(Ok(12.1))
///
///       piecewise.ceiling(12.0654, option.Some(2))
///       |> should.equal(Ok(12.07))
///
///       piecewise.ceiling(12.0654, option.Some(3))
///       |> should.equal(Ok(12.066))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn ceiling(x: Float, digits: option.Option(Int)) -> Result(Float, String) {
  round(x, digits, option.Some(RoundUp))
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The floor function rounds input $$x \in \mathbb{R}$$ to the nearest integer value (at the specified digit) that is less than or equal to the input $$x$$.
///
/// Note: The floor function is used as an alias for the rounding function [`round`](#round) with rounding mode `RoundDown`.
///
/// <details>
///     <summary>Details</summary>
///
///   For example, $$12.0654$$ is rounded to:
///   - $$12.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.0$$ for 1 digits after the decimal point (`digits = 1`)
///   - $$12.06$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.065$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$10.0$$ for 1 digit before the decimal point (`digits = -1`)
///   - $$0.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$0.0$$ for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.floor(12.0654, option.Some(1))
///       |> should.equal(Ok(12.0))
///
///       piecewise.floor(12.0654, option.Some(2))
///       |> should.equal(Ok(12.06))
///
///       piecewise.floor(12.0654, option.Some(3))
///       |> should.equal(Ok(12.065))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn floor(x: Float, digits: option.Option(Int)) -> Result(Float, String) {
  round(x, digits, option.Some(RoundDown))
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The truncate function rounds a given input $$x \in \mathbb{R}$$ to the nearest integer value (at the specified digit) that is less than or equal to the absolute value of the input $$x$$.
///
/// Note: The truncate function is used as an alias for the rounding function [`round`](#round) with rounding mode `RoundToZero`.
///
/// <details>
///     <summary>Details</summary>
///
///   For example, $$12.0654$$ is rounded to:
///   - $$12.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.0$$ for 1 digits after the decimal point (`digits = 1`)
///   - $$12.06$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.065$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$10.0$$ for 1 digit before the decimal point (`digits = -1`)
///   - $$0.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$0.0$$ for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.truncate(12.0654, option.Some(1))
///       |> should.equal(Ok(12.0))
///
///       piecewise.truncate(12.0654, option.Some(2))
///       |> should.equal(Ok(12.0))
///
///       piecewise.truncate(12.0654, option.Some(3))
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
pub fn truncate(x: Float, digits: option.Option(Int)) -> Result(Float, String) {
  round(x, digits, option.Some(RoundToZero))
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a float to a specific number of digits (after the decimal place or before if negative) using a specified rounding mode.
///
/// Valid rounding modes include:
/// - `RoundNearest` (default): The input $$x$$ is rounded to the nearest integer value (at the specified digit) with ties (fractional values of 0.5) being rounded to the nearest even integer.
/// - `RoundTiesAway`: The input $$x$$ is rounded to the nearest integer value (at the specified digit) with ties (fractional values of 0.5) being rounded away from zero (C/C++ rounding behavior).
/// - `RoundTiesUp`: The input $$x$$ is rounded to the nearest integer value (at the specified digit) with ties (fractional values of 0.5) being rounded towards $$+\infty$$ (Java/JavaScript rounding behaviour).
/// - `RoundToZero`: The input $$x$$ is rounded to the nearest integer value (at the specified digit) that is less than or equal to the absolute value of the input $$x$$. An alias for this rounding mode is [`truncate`](#truncate).
/// - `RoundDown`: The input $$x$$ is rounded to the nearest integer value (at the specified digit) that is less than or equal to the input $$x$$. An alias for this rounding mode is [`floor`](#floor).
/// - `RoundUp`: The input $$x$$ is rounded to the nearest integer value (at the specified digit) that is larger than or equal to the input $$x$$. An alias for this rounding mode is [`ceiling`](#ceiling).
///
/// <details>
/// <summary>Details</summary>
///
///   The `RoundNearest` rounding mode, rounds $$12.0654$$ to:
///   - $$12.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.1$$ for 1 digit after the decimal point (`digits = 1`)
///   - $$12.07$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.065$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$10.0$$ for 1 digit before the decimal point (`digits = -1`)
///   - $$0.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$0.0$$ for 3 digits before the decimal point (`digits = -3`)
///
///   The `RoundTiesAway` rounding mode, rounds $$12.0654$$ to:
///   - $$12.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.1$$ for 1 digit after the decimal point (`digits = 1`)
///   - $$12.07$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.065$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$10.0$$ for 1 digit before the decimal point (`digits = -1`)
///   - $$0.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$0.0$$ for 3 digits before the decimal point (`digits = -3`)
///
///   The `RoundTiesUp` rounding mode, rounds $$12.0654$$ to:
///   - $$12.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.1$$ for 1 digits after the decimal point (`digits = 1`)
///   - $$12.07$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.065$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$10.0$$ for 1 digit before the decimal point (`digits = -1`)
///   - $$0.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$0.0$$ for 3 digits before the decimal point (`digits = -3`)
///
///   The `RoundToZero` rounding mode, rounds $$12.0654$$ to:
///   - $$12.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.0$$ for 1 digit after the decimal point (`digits = 1`)
///   - $$12.06$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.065$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$10.0$$ for 1 digit before the decimal point (`digits = -1`)
///   - $$0.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$0.0$$ for 3 digits before the decimal point (`digits = -3`)
///
///   The `RoundDown` rounding mode, rounds $$12.0654$$ to:
///   - $$12.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.0$$ for 1 digits after the decimal point (`digits = 1`)
///   - $$12.06$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.065$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$10.0$$ for 1 digit before the decimal point (`digits = -1`)
///   - $$0.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$0.0$$ for 3 digits before the decimal point (`digits = -3`)
///
///   The `RoundUp` rounding mode, rounds $$12.0654$$ to:
///   - $$13.0$$ for 0 digits after the decimal point (`digits = 0`)
///   - $$12.1$$ for 1 digit after the decimal point (`digits = 1`)
///   - $$12.07$$ for 2 digits after the decimal point (`digits = 2`)
///   - $$12.066$$ for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative number refers to the digits before the decimal point.
///   - $$20.0$$ for 1 digit places before the decimal point (`digit = -1`)
///   - $$100.0$$ for 2 digits before the decimal point (`digits = -2`)
///   - $$1000.0$$ for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       // The default number of digits is 0 if None is provided
///       piecewise.round(12.0654, option.None, option.Some(piecewise.RoundNearest))
///       |> should.equal(Ok(12.0))
///
///       // The default rounding mode is "RoundNearest" if None is provided 
///       piecewise.round(12.0654, option.None, option.None)
///       |> should.equal(Ok(12.0))
///
///       // Try different rounding modes
///       piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundNearest))
///       |> should.equal(Ok(12.07))
///
///       piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundTiesAway))
///       |> should.equal(Ok(12.07))
///
///       piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundTiesUp))
///       |> should.equal(Ok(12.07))
///
///       piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundToZero))
///       |> should.equal(Ok(12.06))
///
///       piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundDown))
///       |> should.equal(Ok(12.06))
///
///       piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundUp))
///       |> should.equal(Ok(12.07))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round(
  x: Float,
  digits: option.Option(Int),
  mode: option.Option(RoundingMode),
) -> Result(Float, String) {
  case digits {
    option.Some(a) -> {
      let assert Ok(p) = elementary.power(10.0, conversion.int_to_float(a))
      // Round the given input x using at the specified digit
      do_round(p, x, mode)
    }
    // Round the given input x using at the default digit
    option.None -> do_round(1.0, x, mode)
  }
}

pub type RoundingMode {
  RoundNearest
  RoundTiesAway
  RoundTiesUp
  RoundToZero
  RoundDown
  RoundUp
}

fn do_round(
  p: Float,
  x: Float,
  mode: option.Option(RoundingMode),
) -> Result(Float, String) {
  case mode {
    // Determine the rounding mode
    option.Some(RoundNearest) ->
      round_to_nearest(p, x)
      |> Ok
    option.Some(RoundTiesAway) ->
      round_ties_away(p, x)
      |> Ok
    option.Some(RoundTiesUp) ->
      round_ties_up(p, x)
      |> Ok
    option.Some(RoundToZero) ->
      round_to_zero(p, x)
      |> Ok
    option.Some(RoundDown) ->
      round_down(p, x)
      |> Ok
    option.Some(RoundUp) ->
      round_up(p, x)
      |> Ok
    // Otherwise, use the default rounding mode
    option.None ->
      round_to_nearest(p, x)
      |> Ok
  }
}

fn round_to_nearest(p: Float, x: Float) -> Float {
  let xabs: Float = float_absolute_value(x) *. p
  let xabs_truncated: Float = truncate_float(xabs)
  let remainder: Float = xabs -. xabs_truncated
  case remainder {
    _ if remainder >. 0.5 -> float_sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ if remainder == 0.5 -> {
      let assert Ok(is_even) = int.modulo(conversion.float_to_int(xabs), 2)
      case is_even == 0 {
        True -> float_sign(x) *. xabs_truncated /. p
        False -> float_sign(x) *. truncate_float(xabs +. 1.0) /. p
      }
    }
    _ -> float_sign(x) *. xabs_truncated /. p
  }
}

fn round_ties_away(p: Float, x: Float) -> Float {
  let xabs: Float = float_absolute_value(x) *. p
  let remainder: Float = xabs -. truncate_float(xabs)
  case remainder {
    _ if remainder >=. 0.5 -> float_sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ -> float_sign(x) *. truncate_float(xabs) /. p
  }
}

fn round_ties_up(p: Float, x: Float) -> Float {
  let xabs: Float = float_absolute_value(x) *. p
  let xabs_truncated: Float = truncate_float(xabs)
  let remainder: Float = xabs -. xabs_truncated
  case remainder {
    _ if remainder >=. 0.5 && x >=. 0.0 ->
      float_sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ -> float_sign(x) *. xabs_truncated /. p
  }
}

// Rounding mode: ToZero / Truncate
fn round_to_zero(p: Float, x: Float) -> Float {
  truncate_float(x *. p) /. p
}

fn truncate_float(x: Float) -> Float {
  do_truncate_float(x)
}

@external(erlang, "erlang", "trunc")
@external(javascript, "../../maths.mjs", "truncate")
fn do_truncate_float(a: Float) -> Float

// Rounding mode: Down / Floor
fn round_down(p: Float, x: Float) -> Float {
  do_floor(x *. p) /. p
}

@external(erlang, "math", "floor")
@external(javascript, "../../maths.mjs", "floor")
fn do_floor(a: Float) -> Float

// Rounding mode: Up / Ceiling
fn round_up(p: Float, x: Float) -> Float {
  do_ceiling(x *. p) /. p
}

@external(erlang, "math", "ceil")
@external(javascript, "../../maths.mjs", "ceiling")
fn do_ceiling(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The absolute value:
///
/// \\[
///  \forall x \in \mathbb{R}, \\; |x|  \in \mathbb{R}_{+}. 
/// \\]
///
/// The function takes an input $$x$$ and returns a positive float value.
///
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_absolute_value(x: Float) -> Float {
  case x >. 0.0 {
    True -> x
    False -> -1.0 *. x
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The absolute value:
///
/// \\[
///  \forall x \in \mathbb{Z}, \\; |x|  \in \mathbb{Z}_{+}. 
/// \\]
///
/// The function takes an input $$x$$ and returns a positive integer value.
///
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_absolute_value(x: Int) -> Int {
  case x > 0 {
    True -> x
    False -> -1 * x
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The absolute difference:
///
/// \\[
///  \forall x, y \in \mathbb{R}, \\; |x - y|  \in \mathbb{R}_{+}. 
/// \\]
///
/// The function takes two inputs $$x$$ and $$y$$ and returns a positive float
/// value which is the the absolute difference of the inputs.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.float_absolute_difference(-10.0, 10.0)
///       |> should.equal(20.0)
///
///       piecewise.float_absolute_difference(0.0, -2.0)
///       |> should.equal(2.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_absolute_difference(a: Float, b: Float) -> Float {
  a -. b
  |> float_absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The absolute difference:
///
/// \\[
///  \forall x, y \in \mathbb{Z}, \\; |x - y|  \in \mathbb{Z}_{+}. 
/// \\]
///
/// The function takes two inputs $$x$$ and $$y$$ and returns a positive integer
/// value which is the the absolute difference of the inputs.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.absolute_difference(-10, 10)
///       |> should.equal(20)
///
///       piecewise.absolute_difference(0, -2)
///       |> should.equal(2)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_absolute_difference(a: Int, b: Int) -> Int {
  a - b
  |> int_absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes an input $$x \in \mathbb{R}$$ and returns the sign of
/// the input, indicating whether it is positive (+1.0), negative (-1.0), or 
/// zero (0.0).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_sign(x: Float) -> Float {
  do_float_sign(x)
}

@target(erlang)
fn do_float_sign(x: Float) -> Float {
  case x <. 0.0 {
    True -> -1.0
    False ->
      case x == 0.0 {
        True -> 0.0
        False -> 1.0
      }
  }
}

@target(javascript)
@external(javascript, "../../maths.mjs", "sign")
fn do_float_sign(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes an input $$x \in \mathbb{Z}$$ and returns the sign of
/// the input, indicating whether it is positive (+1), negative (-1), or zero
/// (0).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_sign(x: Int) -> Int {
  do_int_sign(x)
}

@target(erlang)
fn do_int_sign(x: Int) -> Int {
  case x < 0 {
    True -> -1
    False ->
      case x == 0 {
        True -> 0
        False -> 1
      }
  }
}

@target(javascript)
@external(javascript, "../../maths.mjs", "sign")
fn do_int_sign(a: Int) -> Int

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes two arguments $$x, y \in \mathbb{R}$$ and returns $$x$$ 
/// such that it has the same sign as $$y$$.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_copy_sign(x: Float, y: Float) -> Float {
  case float_sign(x) == float_sign(y) {
    // x and y have the same sign, just return x
    True -> x
    // x and y have different signs:
    // - x is positive and y is negative, then flip sign of x
    // - x is negative and y is positive, then flip sign of x
    False -> float_flip_sign(x)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes two arguments $$x, y \in \mathbb{Z}$$ and returns $$x$$ 
/// such that it has the same sign as $$y$$.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_copy_sign(x: Int, y: Int) -> Int {
  case int_sign(x) == int_sign(y) {
    // x and y have the same sign, just return x
    True -> x
    // x and y have different signs:
    // - x is positive and y is negative, then flip sign of x
    // - x is negative and y is positive, then flip sign of x
    False -> int_flip_sign(x)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function flips the sign of a given input value $$x \in \mathbb{R}$$.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_flip_sign(x: Float) -> Float {
  -1.0 *. x
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function flips the sign of a given input value $$x \in \mathbb{Z}$$.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_flip_sign(x: Int) -> Int {
  -1 * x
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The minimum function takes two arguments $$x, y$$ along with a function
/// for comparing $$x, y$$. The function returns the smallest of the two given
/// values.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/float
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.minimum(2.0, 1.5, float.compare)
///       |> should.equal(1.5)
///
///       piecewise.minimum(1.5, 2.0, float.compare)
///       |> should.equal(1.5)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minimum(x: a, y: a, compare: fn(a, a) -> order.Order) -> a {
  case compare(x, y) {
    order.Lt -> x
    order.Eq -> x
    order.Gt -> y
  }
}

/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The maximum function takes two arguments $$x, y$$ along with a function
/// for comparing $$x, y$$. The function returns the largest of the two given
/// values.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/float
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.maximum(2.0, 1.5, float.compare)
///       |> should.equal(1.5)
///
///       piecewise.maximum(1.5, 2.0, float.compare)
///       |> should.equal(1.5)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn maximum(x: a, y: a, compare: fn(a, a) -> order.Order) -> a {
  case compare(x, y) {
    order.Lt -> y
    order.Eq -> y
    order.Gt -> x
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The minmax function takes two arguments $$x, y$$ along with a function
/// for comparing $$x, y$$. The function returns a tuple with the smallest 
/// value first and largest second.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/float
///     import gleam_community/maths/piecewise
///
///     pub fn example() {
///       piecewise.minmax(2.0, 1.5, float.compare)
///       |> should.equal(#(1.5, 2.0))
///
///       piecewise.minmax(1.5, 2.0, float.compare)
///       |> should.equal(#(1.5, 2.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minmax(x: a, y: a, compare: fn(a, a) -> order.Order) -> #(a, a) {
  #(minimum(x, y, compare), maximum(x, y, compare))
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the minimum value of a given list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/int
///     import gleam_community/maths/piecewise
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> piecewise.list_minimum(int.compare)
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4, 4, 3, 2, 1]
///       |> piecewise.list_minimum(int.compare)
///       |> should.equal(Ok(1))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
pub fn list_minimum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(a, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      let assert Ok(val0) = list.at(arr, 0)
      arr
      |> list.fold(val0, fn(acc: a, element: a) {
        case compare(element, acc) {
          order.Lt -> element
          _ -> acc
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
/// Returns the maximum value of a given list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/float
///     import gleam_community/maths/piecewise
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> piecewise.list_maximum(float.compare)
///       |> should.be_error()
///
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> piecewise.list_maximum(float.compare)
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
pub fn list_maximum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(a, String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      let assert Ok(val0) = list.at(arr, 0)
      arr
      |> list.fold(val0, fn(acc: a, element: a) {
        case compare(acc, element) {
          order.Lt -> element
          _ -> acc
        }
      })
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the indices of the minimum values in a given list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/float
///     import gleam_community/maths/piecewise
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> piecewise.arg_minimum(float.compare)
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> piecewise.arg_minimum(float.compare)
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
pub fn arg_minimum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      let assert Ok(min) =
        arr
        |> list_minimum(compare)
      arr
      |> list.index_map(fn(element: a, index: Int) -> Int {
        case compare(element, min) {
          order.Eq -> index
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
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the indices of the maximum values in a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/float
///     import gleam_community/maths/piecewise
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> piecewise.arg_maximum(float.compare)
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> piecewise.arg_maximum(float.compare)
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
pub fn arg_maximum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(List(Int), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      let assert Ok(max) =
        arr
        |> list_maximum(compare)
      arr
      |> list.index_map(fn(element: a, index: Int) -> Int {
        case compare(element, max) {
          order.Eq -> index
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
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns a tuple consisting of the minimum and maximum values of a given list. 
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/float
///     import gleam_community/maths/piecewise
///
///     pub fn example () {
///       // An empty lists returns an error
///       []
///       |> piecewise.extrema(float.compare)
///       |> should.be_error()
///     
///       // Valid input returns a result
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> piecewise.extrema(float.compare)
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
pub fn extrema(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(#(a, a), String) {
  case arr {
    [] ->
      "Invalid input argument: The list is empty."
      |> Error
    _ -> {
      let assert Ok(val_max) = list.at(arr, 0)
      let assert Ok(val_min) = list.at(arr, 0)
      arr
      |> list.fold(#(val_min, val_max), fn(acc: #(a, a), element: a) {
        let first: a = pair.first(acc)
        let second: a = pair.second(acc)
        case compare(element, first), compare(second, element) {
          order.Lt, order.Lt -> #(element, element)
          order.Lt, _ -> #(element, second)
          _, order.Lt -> #(first, element)
          _, _ -> #(first, second)
        }
      })
      |> Ok
    }
  }
}
