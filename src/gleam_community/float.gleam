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
//// A module containing several different kinds of mathematical functions and constants.
////
//// ---
////
//// * **Transcendental functions**
////   * [`acos`](#acos)
////   * [`acosh`](#acosh)
////   * [`asin`](#asin)
////   * [`asinh`](#asinh)
////   * [`atan`](#atan)
////   * [`atan2`](#atan2)
////   * [`atanh`](#atanh)
////   * [`cos`](#cos)
////   * [`cosh`](#cosh)
////   * [`exp`](#exp)
////   * [`log`](#log)
////   * [`log10`](#log10)
////   * [`log2`](#log2)
////   * [`pow`](#pow)
////   * [`sqrt`](#sqrt)
////   * [`cbrt`](#cbrt)
////   * [`sin`](#sin)
////   * [`sinh`](#sinh)
////   * [`tan`](#tan)
////   * [`tanh`](#tanh)
//// * **Standard mathematical functions**
////   * [`ceil`](#ceil)
////   * [`floor`](#floor)
////   * [`sign`](#sign)
////   * [`round`](#round)
////   * [`absolute_difference`](#absolute_difference)
//// * **Special mathematical functions**
////   * [`beta`](#beta)
////   * [`erf`](#erf)
////   * [`gamma`](#gamma)
////   * [`gammainc`](#gammainc)
//// * **Mathematical constants**
////   * [`pi`](#pi)
////   * [`tau`](#tau)

import gleam/list
import gleam/int
import gleam/float

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.acos(1.0)
///       |> should.equal(Ok(0.0))
///
///       math.acos(1.1)
///       |> should.be_error()
///
///       math.acos(-1.1)
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
    "../math.mjs" "acos"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.acosh(1.0)
///       |> should.equal(Ok(0.0))
///
///       math.acosh(0.0)
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
    "../math.mjs" "acosh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.asin(0.0)
///       |> should.equal(0.0)
///
///       math.asin(1.1)
///       |> should.be_error()
///
///       math.asin(-1.1)
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
    "../math.mjs" "asin"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.asinh(0.0)
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
    "../math.mjs" "asinh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.atan(0.0)
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
    "../math.mjs" "atan"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.atan2(0.0, 0.0)
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
    "../math.mjs" "atan2"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.atanh(0.0)
///       |> should.equal(Ok(0.0))
///
///       math.atanh(1.0)
///       |> should.be_error()
///
///       math.atanh(-1.0)
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
    "../math.mjs" "atanh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The ceiling function.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.ceil(0.2)
///       |> should.equal(1.0)
///
///       math.ceil(0.8)
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
pub fn ceil(x: Float) -> Float {
  do_ceil(x)
}

if erlang {
  external fn do_ceil(Float) -> Float =
    "math" "ceil"
}

if javascript {
  external fn do_ceil(Float) -> Float =
    "../math.mjs" "ceil"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.cos(0.0)
///       |> should.equal(1.0)
///
///       math.cos(math.pi())
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
    "../math.mjs" "cos"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.cosh(0.0)
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
    "../math.mjs" "cosh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
/// If the input value is too large an overflow error might occur.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.exp(0.0)
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
pub fn exp(x: Float) -> Float {
  do_exp(x)
}

if erlang {
  external fn do_exp(Float) -> Float =
    "math" "exp"
}

if javascript {
  external fn do_exp(Float) -> Float =
    "../math.mjs" "exp"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The floor function.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.floor(0.2)
///       |> should.equal(0.0)
///
///       math.floor(0.8)
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
pub fn floor(x: Float) -> Float {
  do_floor(x)
}

if erlang {
  external fn do_floor(Float) -> Float =
    "math" "floor"
}

if javascript {
  external fn do_floor(Float) -> Float =
    "../math.mjs" "floor"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example () {
///       math.log(1.0)
///       |> should.equal(Ok(0.0))
///
///       math.log(math.exp(1.0))
///       |> should.equal(1.0)
///
///       math.log(-1.0)
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
pub fn log(x: Float) -> Result(Float, String) {
  case x >. 0.0 {
    True ->
      do_log(x)
      |> Ok
    False ->
      "Invalid input argument: x <= 0. Valid input is x > 0."
      |> Error
  }
}

if erlang {
  external fn do_log(Float) -> Float =
    "math" "log"
}

if javascript {
  external fn do_log(Float) -> Float =
    "../math.mjs" "log"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The The base-10 logarithm function:
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example () {
///       math.log10(1.0)
///       |> should.equal(Ok(0.0))
///
///       math.log10(10.0)
///       |> should.equal(Ok(1.0))
///
///       math.log10(-1.0)
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
pub fn log10(x: Float) -> Result(Float, String) {
  case x >. 0.0 {
    True ->
      do_log10(x)
      |> Ok
    False ->
      "Invalid input argument: x <= 0. Valid input is x > 0."
      |> Error
  }
}

if erlang {
  external fn do_log10(Float) -> Float =
    "math" "log10"
}

if javascript {
  external fn do_log10(Float) -> Float =
    "../math.mjs" "log10"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example () {
///       math.log2(1.0)
///       |> should.equal(Ok(0.0))
///
///       math.log2(2.0)
///       |> should.equal(Ok(1.0))
///
///       math.log2(-1.0)
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
pub fn log2(x: Float) -> Result(Float, String) {
  case x >. 0.0 {
    True ->
      do_log2(x)
      |> Ok
    False ->
      "Invalid input argument: x <= 0. Valid input is x > 0."
      |> Error
  }
}

if erlang {
  external fn do_log2(Float) -> Float =
    "math" "log2"
}

if javascript {
  external fn do_log2(Float) -> Float =
    "../math.mjs" "log2"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.pow(2., -1.)
///       |> should.equal(0.5)
///
///       math.pow(2., 2.)
///       |> should.equal(4.0)
///
///       math.pow(-1., 0.5)
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
pub fn pow(x: Float, y: Float) -> Result(Float, String) {
  let fractional: Bool = ceil(y) -. y >. 0.0
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
      do_pow(x, y)
      |> Ok
  }
}

if erlang {
  external fn do_pow(Float, Float) -> Float =
    "math" "pow"
}

if javascript {
  external fn do_pow(Float, Float) -> Float =
    "../math.mjs" "pow"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The sign function which returns the sign of the input, indicating
/// whether it is positive, negative, or zero.
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
    "../math.mjs" "sign"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.sin(0.0)
///       |> should.equal(0.0)
///
///       math.sin(0.5 *. math.pi())
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
    "../math.mjs" "sin"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.sinh(0.0)
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
    "../math.mjs" "sinh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.tan(0.0)
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
    "../math.mjs" "tan"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example () {
///       math.tanh(0.0)
///       |> should.equal(0.0)
///
///       math.tanh(25.0)
///       |> should.equal(1.0)
///
///       math.tanh(-25.0)
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
    "../math.mjs" "tanh"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Convert a value in degrees to a value measured in radians.
/// That is, $$1 \text{ radians } = \frac{180}{\pi} \text{ degrees }$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.to_degrees(0.0)
///       |> should.equal(0.0)
///
///       math.to_degrees(2 *. pi())
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
pub fn to_degrees(x: Float) -> Float {
  x *. 180.0 /. pi()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Convert a value in degrees to a value measured in radians.
/// That is, $$1 \text{ degrees } = \frac{\pi}{180} \text{ radians }$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.sin(0.0)
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
pub fn to_radians(x: Float) -> Float {
  x *. pi() /. 180.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
  let [a1, a2, a3, a4, a5] = [
    0.254829592, -0.284496736, 1.421413741, -1.453152027, 1.061405429,
  ]
  let p = 0.3275911

  // TODO: Use the implemented sign function
  let sign = case x <. 0.0 {
    True -> -1.0
    False -> 1.0
  }
  let x = float.absolute_value(x)

  // Formula 7.1.26 given in Abramowitz and Stegun.
  let t = 1.0 /. { 1.0 +. p *. x }
  let y =
    1.0 -. { { { { a5 *. t +. a4 } *. t +. a3 } *. t +. a2 } *. t +. a1 } *. t *. exp(
      -1.0 *. x *. x,
    )
  sign *. y
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
      assert Ok(v1) = pow(2.0 *. pi(), 0.5)
      assert Ok(v2) = pow(t, z +. 0.5)
      v1 *. v2 *. exp(-1.0 *. t) *. x
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
pub fn gammainc(a: Float, x: Float) -> Result(Float, String) {
  case a >. 0.0 && x >=. 0.0 {
    True -> {
      assert Ok(v) = pow(x, a)
      v *. exp(-1.0 *. x) *. gammainc_sum(a, x, 1.0 /. a, 0.0, 1.0)
      |> Ok
    }

    False ->
      "Invlaid input argument: a <= 0 or x < 0. Valid input is a > 0 and x >= 0."
      |> Error
  }
}

fn gammainc_sum(a: Float, x: Float, t: Float, s: Float, n: Float) -> Float {
  case t {
    0.0 -> s
    _ -> {
      let ns: Float = s +. t
      let nt: Float = t *. { x /. { a +. n } }
      gammainc_sum(a, x, nt, ns, n +. 1.0)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a floating point number to a specific decimal precision.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.round(0.4444, 2)
///       |> should.equal(0.44)
///
///       math.round(0.4445, 2)
///       |> should.equal(0.44)
///
///       math.round(0.4455, 2)
///       |> should.equal(0.45)
///
///       math.round(0.4555, 2)
///       |> should.equal(0.46)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round(x: Float, precision: Int) -> Float {
  assert Ok(p) = pow(10.0, int.to_float(precision))
  int.to_float(float.round(x *. p)) /. p
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the number of a $$k$$-combinations of $$n$$ elements:
///
/// \\[
/// C(n, k) = \binom{n}{k} = \frac{n!}{k! (n-k)!}
/// \\]
/// Also known as "$$n$$ choose $$k$$" or the binomial coefficient.
///
/// The implementation uses the effecient iterative multiplicative formula for the computation.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       // Invalid input gives an error
///       // Error on: n = -1 < 0
///       math.combination(-1, 1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       math.combination(4, 0)
///       |> should.equal(Ok(1))
///
///       math.combination(4, 4)
///       |> should.equal(Ok(1))
///
///       math.combination(4, 2)
///       |> should.equal(Ok(6))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn combination(n: Int, k: Int) -> Result(Int, String) {
  case n < 0 {
    True ->
      "Invalid input argument: n < 0. Valid input is n > 0."
      |> Error
    False ->
      case k < 0 || k > n {
        True ->
          0
          |> Ok
        False ->
          case k == 0 || k == n {
            True ->
              1
              |> Ok
            False -> {
              let min = case k < n - k {
                True -> k
                False -> n - k
              }
              list.range(1, min + 1)
              |> list.fold(
                1,
                fn(acc: Int, x: Int) -> Int { acc * { n + 1 - x } / x },
              )
              |> Ok
            }
          }
      }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the total number of combinations of $$n$$
/// elements, that is $$n!$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       // Invalid input gives an error
///       math.factorial(-1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       math.factorial(0)
///       |> should.equal(Ok(1))
///       math.factorial(1)
///       |> should.equal(Ok(1))
///       math.factorial(2)
///       |> should.equal(Ok(2))
///       math.factorial(3)
///       |> should.equal(Ok(6))
///       math.factorial(4)
///       |> should.equal(Ok(24))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn factorial(n) -> Result(Int, String) {
  case n < 0 {
    True ->
      "Invalid input argument: n < 0. Valid input is n > 0."
      |> Error
    False ->
      case n {
        0 ->
          1
          |> Ok
        1 ->
          1
          |> Ok
        _ ->
          list.range(1, n + 1)
          |> list.fold(1, fn(acc: Int, x: Int) { acc * x })
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
/// A combinatorial function for computing the number of $$k$$-permuations (without repetitions)
/// of $$n$$ elements:
///
/// \\[
/// P(n, k) = \frac{n!}{(n - k)!}
/// \\]
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       // Invalid input gives an error
///       // Error on: n = -1 < 0
///       math.permutation(-1, 1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       math.permutation(4, 0)
///       |> should.equal(Ok(1))
///
///       math.permutation(4, 4)
///       |> should.equal(Ok(1))
///
///       math.permutation(4, 2)
///       |> should.equal(Ok(12))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn permutation(n: Int, k: Int) -> Result(Int, String) {
  case n < 0 {
    True ->
      "Invalid input argument: n < 0. Valid input is n > 0."
      |> Error
    False ->
      case k < 0 || k > n {
        True ->
          0
          |> Ok
        False ->
          case k == n {
            True ->
              1
              |> Ok
            False -> {
              assert Ok(v1) = factorial(n)
              assert Ok(v2) = factorial(n - k)
              v1 / v2
              |> Ok
            }
          }
      }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
    "../math.mjs" "pi"
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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

/// Returns the absolute difference of the inputs as a positive Int.
///
/// ## Examples
///
/// ```gleam
/// > absolute_int_difference(-10, 10)
/// > 20
/// ```
///
/// ```gleam
/// > absolute_int_difference(0, -2)
/// 2
///
pub fn absolute_int_difference(a: Int, b: Int) -> Int {
  a - b
  |> int.absolute_value()
}

/// Returns the absolute difference of the inputs as a positive Float.
///
/// ## Examples
///
/// ```gleam
/// > absolute_float_difference(-10, 10)
/// > 20
/// ```
///
/// ```gleam
/// > absolute_float_difference(0, -2)
/// 2
///
/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.acos(1.0)
///       |> should.equal(Ok(0.0))
///
///       math.acos(1.1)
///       |> should.be_error()
///
///       math.acos(-1.1)
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
pub fn absolute_difference(a: Float, b: Float) -> Float {
  a -. b
  |> float.absolute_value()
}
