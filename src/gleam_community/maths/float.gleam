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
//// A module containing mathematical functions and constants that apply to floats.
////
//// ---
////
//// * **Rounding functions**
////   * [`ceiling`](#ceiling)
////   * [`floor`](#floor)
////   * [`truncate`](#truncate)
////   * [`round`](#round)
//// * **Sign and absolute value functions**
////   * [`absolute_difference`](#absolute_difference)
////   * [`sign`](#sign)
////   * [`copy_sign`](#copy_sign)
////   * [`flip_sign`](#flip_sign)
//// * **Powers, logs and roots**
////   * [`exponential`](#exponential)
////   * [`natural_logarithm`](#natural_logarithm)
////   * [`logarithm`](#logarithm)
////   * [`logarithm_2`](#logarithm_2)
////   * [`logarithm_10`](#logarithm_10)
////   * [`power`](#power)
////   * [`square_root`](#square_root)
////   * [`cube_root`](#cube_root)
////   * [`nth_root`](#nth_root)
////   * [`hypotenuse`](#hypotentuse)
//// * **Trigonometric and hyperbolic functions**
////   * [`acos`](#acos)
////   * [`acosh`](#acosh)
////   * [`asin`](#asin)
////   * [`asinh`](#asinh)
////   * [`atan`](#atan)
////   * [`atan2`](#atan2)
////   * [`atanh`](#atanh)
////   * [`cos`](#cos)
////   * [`cosh`](#cosh)
////   * [`sin`](#sin)
////   * [`sinh`](#sinh)
////   * [`tan`](#tan)
////   * [`tanh`](#tanh)
////   * [`to_radian`](#to_radian)
////   * [`to_degree`](#to_degree)
//// * **Misc. mathematical functions**
////   * [`minimum`](#minimum)
////   * [`maximum`](#maximum)
////   * [`minmax`](#minmax)
//// * **Special mathematical functions**
////   * [`beta`](#beta)
////   * [`error`](#erf)
////   * [`gamma`](#gamma)
////   * [`incomplete_gamma`](#incomplete_gamma)
//// * **Mathematical constants**
////   * [`pi`](#pi)
////   * [`tau`](#tau)
////   * [`e`](#e)
//// * **Tests**
////   * [`is_close`](#is_close)
//// * **Misc. functions**
////   * [`to_int`](#to_int)

import gleam/list
import gleam/int
import gleam/float
import gleam/io
import gleam/option

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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.ceiling(12.0654, option.Some(1))
///       |> should.equal(Ok(12.1))
///
///       floatx.ceiling(12.0654, option.Some(2))
///       |> should.equal(Ok(12.07))
///
///       floatx.ceiling(12.0654, option.Some(3))
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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.floor(12.0654, option.Some(1))
///       |> should.equal(Ok(12.0))
///
///       floatx.floor(12.0654, option.Some(2))
///       |> should.equal(Ok(12.06))
///
///       floatx.floor(12.0654, option.Some(3))
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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.truncate(12.0654, option.Some(1))
///       |> should.equal(Ok(12.0))
///
///       floatx.truncate(12.0654, option.Some(2))
///       |> should.equal(Ok(12.0))
///
///       floatx.truncate(12.0654, option.Some(3))
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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       // The default number of digits is 0 if None is provided
///       floatx.round(12.0654, option.None, option.Some(floatx.RoundNearest))
///       |> should.equal(Ok(12.0))
///
///       // The default rounding mode is "RoundNearest" if None is provided 
///       floatx.round(12.0654, option.None, option.None)
///       |> should.equal(Ok(12.0))
///
///       // Try different rounding modes
///       floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundNearest))
///       |> should.equal(Ok(12.07))
///
///       floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundTiesAway))
///       |> should.equal(Ok(12.07))
///
///       floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundTiesUp))
///       |> should.equal(Ok(12.07))
///
///       floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundToZero))
///       |> should.equal(Ok(12.06))
///
///       floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundDown))
///       |> should.equal(Ok(12.06))
///
///       floatx.round(12.0654, option.Some(2), option.Some(floatx.RoundUp))
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
      assert Ok(p) = power(10.0, int.to_float(a))
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
    // Otherwise, use the Default rounding mode
    option.None ->
      round_to_nearest(p, x)
      |> Ok
  }
}

fn round_to_nearest(p: Float, x: Float) -> Float {
  let xabs: Float = float.absolute_value(x) *. p
  let xabs_truncated: Float = truncate_float(xabs)
  let remainder: Float = xabs -. xabs_truncated
  case remainder {
    _ if remainder >. 0.5 -> sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ if remainder == 0.5 -> {
      assert Ok(is_even) = int.modulo(to_int(xabs), 2)
      case is_even == 0 {
        True -> sign(x) *. xabs_truncated /. p
        False -> sign(x) *. truncate_float(xabs +. 1.0) /. p
      }
    }
    _ -> sign(x) *. xabs_truncated /. p
  }
}

fn round_ties_away(p: Float, x: Float) -> Float {
  let xabs: Float = float.absolute_value(x) *. p
  let remainder: Float = xabs -. truncate_float(xabs)
  case remainder {
    _ if remainder >=. 0.5 -> sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ -> sign(x) *. truncate_float(xabs) /. p
  }
}

fn round_ties_up(p: Float, x: Float) -> Float {
  let xabs: Float = float.absolute_value(x) *. p
  let xabs_truncated: Float = truncate_float(xabs)
  let remainder: Float = xabs -. xabs_truncated
  case remainder {
    _ if remainder >=. 0.5 && x >=. 0.0 ->
      sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ -> sign(x) *. xabs_truncated /. p
  }
}

// Rounding mode: ToZero / Truncate
fn round_to_zero(p: Float, x: Float) -> Float {
  truncate_float(x *. p) /. p
}

fn truncate_float(x: Float) -> Float {
  do_truncate_float(x)
}

if erlang {
  external fn do_truncate_float(Float) -> Float =
    "erlang" "trunc"
}

if javascript {
  external fn do_truncate_float(Float) -> Float =
    "../../maths.mjs" "truncate"
}

// Rounding mode: Down / Floor
fn round_down(p: Float, x: Float) -> Float {
  do_floor(x *. p) /. p
}

if erlang {
  external fn do_floor(Float) -> Float =
    "math" "floor"
}

if javascript {
  external fn do_floor(Float) -> Float =
    "../../maths.mjs" "floor"
}

// Rounding mode: Up / Ceiling
fn round_up(p: Float, x: Float) -> Float {
  do_ceiling(x *. p) /. p
}

if erlang {
  external fn do_ceiling(Float) -> Float =
    "math" "ceil"
}

if javascript {
  external fn do_ceiling(Float) -> Float =
    "../../maths.mjs" "ceiling"
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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.to_int(12.0654)
///       |> should.equal(12)
///       
///       // Note: Making the following function call is equivalent
///       // but instead of returning a value of type 'Int' a value
///       // of type 'Float' is returned.
///       floatx.round(12.0654, option.Some(0), option.Some(floatx.RoundToZero))
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
pub fn to_int(x: Float) -> Int {
  do_to_int(x)
}

if erlang {
  external fn do_to_int(Float) -> Int =
    "erlang" "trunc"
}

if javascript {
  external fn do_to_int(Float) -> Int =
    "../../maths.mjs" "truncate"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse cosine function:
///
/// \\[
/// \forall x \in \[-1, 1\],   \\; \cos^{-1}{(x)} = y \in \[0, \pi \]
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\[-1, 1\]$$ as input and returns a
/// numeric value $$y$$ that lies in the range $$\[0, \pi \]$$ (an angle in radians).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.acos(1.0)
///       |> should.equal(Ok(0.0))
///
///       floatx.acos(1.1)
///       |> should.be_error()
///
///       floatx.acos(-1.1)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn acos(x: Float) -> Result(Float, String) {
  case x >=. -1.0 && x <=. 1.0 {
    True ->
      do_acos(x)
      |> Ok
    False ->
      "Invalid input argument: x >= -1 or x <= 1. Valid input is -1. <= x <= 1."
      |> Error
  }
}

if erlang {
  external fn do_acos(Float) -> Float =
    "math" "acos"
}

if javascript {
  external fn do_acos(Float) -> Float =
    "../../maths.mjs" "acos"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse hyperbolic cosine function:
///
/// \\[
/// \forall x \in [1, +\infty\),   \\; \cosh^{-1}{(x)} = y \in \[0, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\[1, +\infty\)$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\[0, +\infty\)$$ (an angle in radians).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.acosh(1.0)
///       |> should.equal(Ok(0.0))
///
///       floatx.acosh(0.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn acosh(x: Float) -> Result(Float, String) {
  case x >=. 1.0 {
    True ->
      do_acosh(x)
      |> Ok
    False ->
      "Invalid input argument: x < 1. Valid input is x >= 1."
      |> Error
  }
}

if erlang {
  external fn do_acosh(Float) -> Float =
    "math" "acosh"
}

if javascript {
  external fn do_acosh(Float) -> Float =
    "../../maths.mjs" "acosh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse sine function:
///
/// \\[
/// \forall x \in \[-1, 1\],   \\; \sin^{-1}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\[-1, 1\]$$ as input and returns a numeric
/// value $$y$$ that lies in the range $$\[-\frac{\pi}{2}, \frac{\pi}{2}\]$$ (an angle in radians).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.asin(0.0)
///       |> should.equal(Ok(0.0))
///
///       floatx.asin(1.1)
///       |> should.be_error()
///
///       floatx.asin(-1.1)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn asin(x: Float) -> Result(Float, String) {
  case x >=. -1.0 && x <=. 1.0 {
    True ->
      do_asin(x)
      |> Ok
    False ->
      "Invalid input argument: x >= -1 or x <= 1. Valid input is -1. <= x <= 1."
      |> Error
  }
}

if erlang {
  external fn do_asin(Float) -> Float =
    "math" "asin"
}

if javascript {
  external fn do_asin(Float) -> Float =
    "../../maths.mjs" "asin"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse hyperbolic sine function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; \sinh^{-1}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, +\infty\)$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\(-\infty, +\infty\)$$ (an angle in radians).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.asinh(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn asinh(x: Float) -> Float {
  do_asinh(x)
}

if erlang {
  external fn do_asinh(Float) -> Float =
    "math" "asinh"
}

if javascript {
  external fn do_asinh(Float) -> Float =
    "../../maths.mjs" "asinh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse tangent function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; \tan^{-1}{(x)} = y \in \[-\frac{\pi}{2}, \frac{\pi}{2}\]
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, +\infty\)$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\[-\frac{\pi}{2}, \frac{\pi}{2}\]$$ (an angle in radians).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.atan(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn atan(x: Float) -> Float {
  do_atan(x)
}

if erlang {
  external fn do_atan(Float) -> Float =
    "math" "atan"
}

if javascript {
  external fn do_atan(Float) -> Float =
    "../../maths.mjs" "atan"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse 2-argument tangent function:
///
/// \\[
/// \text{atan2}(y, x) =
/// \begin{cases}
///  \tan^{-1}(\frac y x) &\text{if } x > 0, \\\\
///  \tan^{-1}(\frac y x) + \pi &\text{if } x < 0 \text{ and } y \ge 0, \\\\
///  \tan^{-1}(\frac y x) - \pi &\text{if } x < 0 \text{ and } y < 0, \\\\
///  +\frac{\pi}{2} &\text{if } x = 0 \text{ and } y > 0, \\\\
///  -\frac{\pi}{2} &\text{if } x = 0 \text{ and } y < 0, \\\\
///  \text{undefined} &\text{if } x = 0 \text{ and } y = 0.
/// \end{cases}
/// \\]
///
/// The function returns the angle in radians from the x-axis to the line containing the
/// origin $$\(0, 0\)$$ and a point given as input with coordinates $$\(x, y\)$$. The numeric value
/// returned by $$\text{atan2}(y, x)$$ is in the range $$\[-\pi, \pi\]$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.atan2(0.0, 0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn atan2(y: Float, x: Float) -> Float {
  do_atan2(y, x)
}

if erlang {
  external fn do_atan2(Float, Float) -> Float =
    "math" "atan2"
}

if javascript {
  external fn do_atan2(Float, Float) -> Float =
    "../../maths.mjs" "atan2"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse hyperbolic tangent function:
///
/// \\[
/// \forall x \in \(-1, 1\),   \\; \tanh^{-1}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-1, 1\)$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\(-\infty, \infty\)$$ (an angle in radians).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.atanh(0.0)
///       |> should.equal(Ok(0.0))
///
///       floatx.atanh(1.0)
///       |> should.be_error()
///
///       floatx.atanh(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn atanh(x: Float) -> Result(Float, String) {
  case x >. -1.0 && x <. 1.0 {
    True ->
      do_atanh(x)
      |> Ok
    False ->
      "Invalid input argument: x > -1 or x < 1. Valid input is -1. < x < 1."
      |> Error
  }
}

if erlang {
  external fn do_atanh(Float) -> Float =
    "math" "atanh"
}

if javascript {
  external fn do_atanh(Float) -> Float =
    "../../maths.mjs" "atanh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The cosine function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \cos{(x)} = y \in \[-1, 1\]
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, \infty\)$$ (an angle in radians)
/// as input and returns a numeric value $$y$$ that lies in the range $$\[-1, 1\]$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.cos(0.0)
///       |> should.equal(1.0)
///
///       floatx.cos(floatx.pi())
///       |> should.equal(-1.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cos(x: Float) -> Float {
  do_cos(x)
}

if erlang {
  external fn do_cos(Float) -> Float =
    "math" "cos"
}

if javascript {
  external fn do_cos(Float) -> Float =
    "../../maths.mjs" "cos"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The hyperbolic cosine function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; \cosh{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, \infty\)$$ as input (an angle in radians)
/// and returns a numeric value $$y$$ that lies in the range $$\(-\infty, \infty\)$$.
/// If the input value is too large an overflow error might occur.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.cosh(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cosh(x: Float) -> Float {
  do_cosh(x)
}

if erlang {
  external fn do_cosh(Float) -> Float =
    "math" "cosh"
}

if javascript {
  external fn do_cosh(Float) -> Float =
    "../../maths.mjs" "cosh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The exponential function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; e^{(x)} = y \in \(0, +\infty\)
/// \\]
///
/// $$e \approx 2.71828\dots$$ is Eulers' number.
///
/// Note: If the input value $$x$$ is too large an overflow error might occur.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.exponential(0.0)
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
pub fn exponential(x: Float) -> Float {
  do_exponential(x)
}

if erlang {
  external fn do_exponential(Float) -> Float =
    "math" "exp"
}

if javascript {
  external fn do_exponential(Float) -> Float =
    "../../maths.mjs" "exponential"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The base $$b$$ logarithm function (computed through the "change of base" formula):
///
/// \\[
/// \forall x \in \(0, \infty\) \textnormal{ and } b > 1,  \\; \log_{b}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(0, \infty\)$$ and a base $$b > 1$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\(-\infty, \infty\)$$.
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/float as floatx
///
///     pub fn example () {
///       floatx.logarithm(1.0, option.Some(10.0))
///       |> should.equal(Ok(0.0))
///
///       floatx.logarithm(floatx.e(), option.Some(floatx.e()))
///       |> should.equal(Ok(1.0))
///
///       floatx.logarithm(-1.0, option.Some(2.0))
///       |> should.be_error()
///     }
/// </details>
///
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithm(x: Float, base: option.Option(Float)) -> Result(Float, String) {
  case x >. 0.0 {
    True ->
      case base {
        option.Some(a) ->
          case a >. 0.0 && a != 1.0 {
            True -> {
              // Apply the "change of base formula"
              assert Ok(numerator) = logarithm_10(x)
              assert Ok(denominator) = logarithm_10(a)
              numerator /. denominator
              |> Ok
            }
            False ->
              "Invalid input argument: base <= 0 or base == 1. Valid input is base > 0 and base != 1."
              |> Error
          }
        _ ->
          "Invalid input argument: base <= 0 or base == 1. Valid input is base > 0 and base != 1."
          |> Error
      }
    _ ->
      "Invalid input argument: x <= 0. Valid input is x > 0."
      |> Error
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The natural logarithm function:
///
/// \\[
/// \forall x \in \(0, \infty\),   \\; \log_{e}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(0, \infty\)$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\(-\infty, \infty\)$$.
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example () {
///       floatx.natural_logarithm(1.0)
///       |> should.equal(Ok(0.0))
///
///       floatx.natural_logarithm(floatx.e())
///       |> should.equal(Ok(1.0))
///
///       floatx.natural_logarithm(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn natural_logarithm(x: Float) -> Result(Float, String) {
  case x >. 0.0 {
    True ->
      do_natural_logarithm(x)
      |> Ok
    False ->
      "Invalid input argument: x <= 0. Valid input is x > 0."
      |> Error
  }
}

if erlang {
  external fn do_natural_logarithm(Float) -> Float =
    "math" "log"
}

if javascript {
  external fn do_natural_logarithm(Float) -> Float =
    "../../maths.mjs" "logarithm"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The base-10 logarithm function:
///
/// \\[
/// \forall x \in \(0, \infty),   \\; \log_{10}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(0, \infty\)$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\(-\infty, \infty\)$$.
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example () {
///       floatx.logarithm_10(1.0)
///       |> should.equal(Ok(0.0))
///
///       floatx.logarithm_10(10.0)
///       |> should.equal(Ok(1.0))
///
///       floatx.logarithm_10(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithm_10(x: Float) -> Result(Float, String) {
  case x >. 0.0 {
    True ->
      do_logarithm_10(x)
      |> Ok
    False ->
      "Invalid input argument: x <= 0. Valid input is x > 0."
      |> Error
  }
}

if erlang {
  external fn do_logarithm_10(Float) -> Float =
    "math" "log10"
}

if javascript {
  external fn do_logarithm_10(Float) -> Float =
    "../../maths.mjs" "logarithm_10"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The The base-2 logarithm function:
///
/// \\[
/// \forall x \in \(0, \infty),   \\; \log_{2}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(0, \infty\)$$ as input and returns
/// a numeric value $$y$$ that lies in the range $$\(-\infty, \infty\)$$.
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example () {
///       floatx.logarithm_2(1.0)
///       |> should.equal(Ok(0.0))
///
///       floatx.logarithm_2(2.0)
///       |> should.equal(Ok(1.0))
///
///       floatx.logarithm_2(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithm_2(x: Float) -> Result(Float, String) {
  case x >. 0.0 {
    True ->
      do_logarithm_2(x)
      |> Ok
    False ->
      "Invalid input argument: x <= 0. Valid input is x > 0."
      |> Error
  }
}

if erlang {
  external fn do_logarithm_2(Float) -> Float =
    "math" "log2"
}

if javascript {
  external fn do_logarithm_2(Float) -> Float =
    "../../maths.mjs" "logarithm_2"
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
/// The exponentiation function: $$y = x^{a}$$.
///
/// Note that the function is not defined if:
/// 1. The base is negative ($$x < 0$$) and the exponent is fractional
///    ($$a = \frac{n}{m}$$ is an irrreducible fraction). An error will be returned
///    as an imaginary number will otherwise have to be returned.
/// 2. The base is zero ($$x = 0$$) and the exponent is negative ($$a < 0$$) then the
///    expression is equivalent to the exponent $$y$$ divided by $$0$$ and an
///    error will have to be returned as the expression is otherwise undefined.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.power(2., -1.)
///       |> should.equal(Ok(0.5))
///
///       floatx.power(2., 2.)
///       |> should.equal(Ok(4.0))
///
///       floatx.power(-1., 0.5)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn power(x: Float, y: Float) -> Result(Float, String) {
  let fractional: Bool = do_ceiling(y) -. y >. 0.0
  // In the following check:
  // 1. If the base (x) is negative and the exponent (y) is fractional
  //    then return an error as it will otherwise be an imaginary number
  // 2. If the base (x) is 0 and the exponent (y) is negative then the
  //    expression is equivalent to the exponent (y) divided by 0 and an
  //    error should be returned
  case x <. 0.0 && fractional || x == 0.0 && y <. 0.0 {
    True ->
      "Invalid input argument: x < 0 and y is fractional or x = 0 and y < 0."
      |> Error
    False ->
      do_power(x, y)
      |> Ok
  }
}

if erlang {
  external fn do_power(Float, Float) -> Float =
    "math" "pow"
}

if javascript {
  external fn do_power(Float, Float) -> Float =
    "../../maths.mjs" "power"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The square root function: $$y = \sqrt[2]{x} = x^{\frac{1}{2}}$$.
///
/// Note that the function is not defined if:
/// 1. The input is negative ($$x < 0$$). An error will be returned
///    as an imaginary number will otherwise have to be returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.square_root(1.0)
///       |> should.equal(Ok(1.0))
///
///       floatx.square_root(4.0)
///       |> should.equal(Ok(2.0))
///
///       floatx.square_root(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn square_root(x: Float) -> Result(Float, String) {
  // In the following check:
  // 1. If x is negative then return an error as it will otherwise be an 
  // imaginary number
  case x <. 0.0 {
    True ->
      "Invalid input argument: x < 0."
      |> Error
    False -> {
      assert Ok(result) = power(x, 1.0 /. 2.0)
      result
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
/// The cube root function: $$y = \sqrt[3]{x} = x^{\frac{1}{3}}$$.
///
/// Note that the function is not defined if:
/// 1. The input is negative ($$x < 0$$). An error will be returned
///    as an imaginary number will otherwise have to be returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.cube_root(1.0)
///       |> should.equal(Ok(1.0))
///
///       floatx.cube_root(27.0)
///       |> should.equal(Ok(3.0))
///
///       floatx.cube_root(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cube_root(x: Float) -> Result(Float, String) {
  // In the following check:
  // 1. If x is negative then return an error as it will otherwise be an 
  // imaginary number
  case x <. 0.0 {
    True ->
      "Invalid input argument: x < 0."
      |> Error
    False -> {
      assert Ok(result) = power(x, 1.0 /. 3.0)
      result
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
/// The $$n$$'th root function: $$y = \sqrt[n]{x} = x^{\frac{1}{n}}$$.
///
/// Note that the function is not defined if:
/// 1. The input is negative ($$x < 0$$). An error will be returned
///    as an imaginary number will otherwise have to be returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.nth_root(1.0, 2)
///       |> should.equal(Ok(1.0))
///
///       floatx.nth_root(27.0, 3)
///       |> should.equal(Ok(3.0))
///
///       floatx.nth_root(256.0, 4)
///       |> should.equal(Ok(4.0))
///
///       floatx.nth_root(-1.0, 2)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn nth_root(x: Float, n: Int) -> Result(Float, String) {
  // In the following check:
  // 1. If x is negative then return an error as it will otherwise be an 
  // imaginary number
  case x <. 0.0 {
    True ->
      "Invalid input argument: x < 0. Valid input is x > 0"
      |> Error
    False ->
      case n >= 1 {
        True -> {
          assert Ok(result) = power(x, 1.0 /. int.to_float(n))
          result
          |> Ok
        }
        False ->
          "Invalid input argument: n < 1. Valid input is n >= 2."
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
/// A function to compute the hypotenuse of a right-angled triangle: $$\sqrt[2]{x^2 + y^2}$$.
/// The function can also be used to calculate the Euclidean distance in 2 dimensions. 
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.hypotenuse(0.0, 0.0)
///       |> should.equal(0.0)
///     
///       floatx.hypotenuse(1.0, 0.0)
///       |> should.equal(1.0)
///     
///       floatx.hypotenuse(0.0, 1.0)
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
pub fn hypotenuse(x: Float, y: Float) -> Float {
  assert Ok(term1) = power(x, 2.0)
  assert Ok(term2) = power(y, 2.0)
  assert Ok(h) = square_root(term1 +. term2)
  h
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The sine function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \sin{(x)} = y \in \[-1, 1\]
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, \infty\)$$ (an angle in radians)
/// as input and returns a numeric value $$y$$ that lies in the range $$\[-1, 1\]$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.sin(0.0)
///       |> should.equal(0.0)
///
///       floatx.sin(0.5 *. floatx.pi())
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
pub fn sin(x: Float) -> Float {
  do_sin(x)
}

if erlang {
  external fn do_sin(Float) -> Float =
    "math" "sin"
}

if javascript {
  external fn do_sin(Float) -> Float =
    "../../maths.mjs" "sin"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The hyperbolic sine function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \sinh{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, +\infty\)$$ as input
/// (an angle in radians) and returns a numeric value $$y$$ that lies in the range
/// $$\(-\infty, +\infty\)$$. If the input value is too large an overflow error might
/// occur.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.sinh(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sinh(x: Float) -> Float {
  do_sinh(x)
}

if erlang {
  external fn do_sinh(Float) -> Float =
    "math" "sinh"
}

if javascript {
  external fn do_sinh(Float) -> Float =
    "../../maths.mjs" "sinh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The tangent function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \tan{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, +\infty\)$$ as input
/// (an angle in radians) and returns a numeric value $$y$$ that lies in the range
/// $$\(-\infty, +\infty\)$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.tan(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tan(x: Float) -> Float {
  do_tan(x)
}

if erlang {
  external fn do_tan(Float) -> Float =
    "math" "tan"
}

if javascript {
  external fn do_tan(Float) -> Float =
    "../../maths.mjs" "tan"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The hyperbolic tangent function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; \tanh{(x)} = y \in \[-1, 1\]
/// \\]
///
/// The function takes a number $$x$$ in its domain $$\(-\infty, \infty\)$$ as input (an angle in radians)
/// and returns a numeric value $$y$$ that lies in the range $$\[-1, 1\]$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example () {
///       floatx.tanh(0.0)
///       |> should.equal(0.0)
///
///       floatx.tanh(25.0)
///       |> should.equal(1.0)
///
///       floatx.tanh(-25.0)
///       |> should.equal(-1.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tanh(x: Float) -> Float {
  do_tanh(x)
}

if erlang {
  external fn do_tanh(Float) -> Float =
    "math" "tanh"
}

if javascript {
  external fn do_tanh(Float) -> Float =
    "../../maths.mjs" "tanh"
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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.to_degree(0.0)
///       |> should.equal(0.0)
///
///       floatx.to_degree(2. *. floatx.pi())
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
pub fn to_degree(x: Float) -> Float {
  x *. 180.0 /. pi()
}

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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.to_radian(360.)
///       |> should.equal(2. *. floatx.pi())
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn to_radian(x: Float) -> Float {
  x *. pi() /. 180.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The minimum function that takes two arguments $$x, y \in \mathbb{R}$$ and returns the smallest of the two.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.minimum(2.0, 1.5)
///       |> should.equal(1.5)
///
///       floatx.minimum(1.5, 2.0)
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
pub fn minimum(x: Float, y: Float) -> Float {
  case x <. y {
    True -> x
    False -> y
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The maximum function that takes two arguments $$x, y \in \mathbb{R}$$ and returns the largest of the two.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.maximum(2.0, 1.5)
///       |> should.equal(1.5)
///
///       floatx.maximum(1.5, 2.0)
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
pub fn maximum(x: Float, y: Float) -> Float {
  case x >. y {
    True -> x
    False -> y
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The minmax function that takes two arguments $$x, y \in \mathbb{R}$$ and returns a tuple with the smallest value first and largest second.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.minmax(2.0, 1.5)
///       |> should.equal(#(1.5, 2.0))
///
///       floatx.minmax(1.5, 2.0)
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
pub fn minmax(x: Float, y: Float) -> #(Float, Float) {
  #(minimum(x, y), maximum(x, y))
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The sign function that returns the sign of the input, indicating whether it is positive (+1), negative (-1), or zero (0).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sign(x: Float) -> Float {
  do_sign(x)
}

if erlang {
  fn do_sign(x: Float) -> Float {
    case x <. 0.0 {
      True -> -1.0
      False ->
        case x == 0.0 {
          True -> 0.0
          False -> 1.0
        }
    }
  }
}

if javascript {
  external fn do_sign(Float) -> Float =
    "../../maths.mjs" "sign"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes two arguments $$x$$ and $$y$$ and returns $$x$$ such that it has the same sign as $$y$$.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn copy_sign(x: Float, y: Float) -> Float {
  case sign(x) == sign(y) {
    // x and y have the same sign, just return x
    True -> x
    // x and y have different signs:
    // - x is positive and y is negative, then flip sign of x
    // - x is negative and y is positive, then flip sign of x
    False -> flip_sign(x)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function flips the sign of a given input value.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn flip_sign(x: Float) -> Float {
  -1.0 *. x
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The beta function over the real numbers:
///
/// \\[
/// \text{B}(x, y) = \frac{\Gamma(x) \cdot \Gamma(y)}{\Gamma(x + y)}
/// \\]
///
/// The beta function is evaluated through the use of the gamma function.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn beta(x: Float, y: Float) -> Float {
  gamma(x) *. gamma(y) /. gamma(x +. y)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The error function.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn erf(x: Float) -> Float {
  let [a1, a2, a3, a4, a5]: List(Float) = [
    0.254829592, -0.284496736, 1.421413741, -1.453152027, 1.061405429,
  ]
  let p: Float = 0.3275911

  let sign: Float = sign(x)
  let x: Float = float.absolute_value(x)

  // Formula 7.1.26 given in Abramowitz and Stegun.
  let t: Float = 1.0 /. { 1.0 +. p *. x }
  let y: Float =
    1.0 -. { { { { a5 *. t +. a4 } *. t +. a3 } *. t +. a2 } *. t +. a1 } *. t *. exponential(
      -1.0 *. x *. x,
    )
  sign *. y
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The gamma function over the real numbers. The function is essentially equal to the
/// factorial for any positive integer argument: $$\Gamma(n) = (n - 1)!$$
///
/// The implemented gamma function is approximated through Lanczos approximation
/// using the same coefficients used by the GNU Scientific Library.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn gamma(x: Float) -> Float {
  gamma_lanczos(x)
}

const lanczos_g: Float = 7.0

const lanczos_p: List(Float) = [
  0.99999999999980993, 676.5203681218851, -1259.1392167224028,
  771.32342877765313, -176.61502916214059, 12.507343278686905,
  -0.13857109526572012, 0.0000099843695780195716, 0.00000015056327351493116,
]

fn gamma_lanczos(x: Float) -> Float {
  case x <. 0.5 {
    True -> pi() /. { sin(pi() *. x) *. gamma_lanczos(1.0 -. x) }
    False -> {
      let z = x -. 1.0
      let x: Float =
        list.index_fold(
          lanczos_p,
          0.0,
          fn(acc: Float, v: Float, index: Int) {
            case index > 0 {
              True -> acc +. v /. { z +. int.to_float(index) }
              False -> v
            }
          },
        )
      let t: Float = z +. lanczos_g +. 0.5
      assert Ok(v1) = power(2.0 *. pi(), 0.5)
      assert Ok(v2) = power(t, z +. 0.5)
      v1 *. v2 *. exponential(-1.0 *. t) *. x
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The lower incomplete gamma function over the real numbers.
///
/// The implemented incomplete gamma function is evaluated through a power series
/// expansion.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn incomplete_gamma(a: Float, x: Float) -> Result(Float, String) {
  case a >. 0.0 && x >=. 0.0 {
    True -> {
      assert Ok(v) = power(x, a)
      v *. exponential(-1.0 *. x) *. incomplete_gamma_sum(
        a,
        x,
        1.0 /. a,
        0.0,
        1.0,
      )
      |> Ok
    }

    False ->
      "Invlaid input argument: a <= 0 or x < 0. Valid input is a > 0 and x >= 0."
      |> Error
  }
}

fn incomplete_gamma_sum(
  a: Float,
  x: Float,
  t: Float,
  s: Float,
  n: Float,
) -> Float {
  case t {
    0.0 -> s
    _ -> {
      let ns: Float = s +. t
      let nt: Float = t *. { x /. { a +. n } }
      incomplete_gamma_sum(a, x, nt, ns, n +. 1.0)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The mathematical constant pi: $$\pi \approx 3.1415\dots$$
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn pi() -> Float {
  do_pi()
}

if erlang {
  external fn do_pi() -> Float =
    "math" "pi"
}

if javascript {
  external fn do_pi() -> Float =
    "../../maths.mjs" "pi"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The mathematical constant tau: $$\tau = 2 \cdot \pi \approx 6.283\dots$$
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tau() -> Float {
  2.0 *. pi()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Euler's number $$e \approx 2.71828\dots$$.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       // Test that the constant is approximately equal to 2.7128...
///       floatx.e()
///       |> floatx.is_close(2.7128, 0.0, 0.000001)
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
pub fn e() -> Float {
  exponential(1.0)
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
///     import gleam_community/maths/float as floatx
///
///     pub fn example() {
///       floatx.absolute_difference(-10.0, 10.0)
///       |> should.equal(20.0)
///
///       floatx.absolute_difference(0.0, -2.0)
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
pub fn absolute_difference(a: Float, b: Float) -> Float {
  a -. b
  |> float.absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a given value $$a$$ is close to or equivalent to a reference value 
/// $$b$$ based on supplied relative $$r_{tol}$$ and absolute $$a_{tol}$$ tolerance values.
/// The equivalance of the two given values are then determined based on the equation:
///
/// \\[
///     \|a - b\| \leq (a_{tol} + r_{tol} \cdot \|b\|)
/// \\]
///
/// `True` is returned if statement holds, otherwise `False` is returned. 
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/float as floatx
///
///     pub fn example () {
///       let val: Float = 99.
///       let ref_val: Float = 100.
///       // We set 'atol' and 'rtol' such that the values are equivalent
///       // if 'val' is within 1 percent of 'ref_val' +/- 0.1
///       let rtol: Float = 0.01
///       let atol: Float = 0.10
///       floatx.is_close(val, ref_val, rtol, atol)
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
pub fn is_close(a: Float, b: Float, rtol: Float, atol: Float) -> Bool {
  let x: Float = absolute_difference(a, b)
  let y: Float = atol +. rtol *. float.absolute_value(b)
  case x <=. y {
    True -> True
    False -> False
  }
}
