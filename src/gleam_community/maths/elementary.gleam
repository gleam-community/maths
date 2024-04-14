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
//// Elementary: A module containing a comprehensive set of foundational mathematical functions and constants.
//// 
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
//// * **Mathematical constants**
////   * [`pi`](#pi)
////   * [`tau`](#tau)
////   * [`e`](#e)
//// 

import gleam/int
import gleam/option

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.acos(1.0)
///       |> should.equal(Ok(0.0))
///
///       elementary.acos(1.1)
///       |> should.be_error()
///
///       elementary.acos(-1.1)
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

@external(erlang, "math", "acos")
@external(javascript, "../../maths.mjs", "acos")
fn do_acos(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.acosh(1.0)
///       |> should.equal(Ok(0.0))
///
///       elementary.acosh(0.0)
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

@external(erlang, "math", "acosh")
@external(javascript, "../../maths.mjs", "acosh")
fn do_acosh(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.asin(0.0)
///       |> should.equal(Ok(0.0))
///
///       elementary.asin(1.1)
///       |> should.be_error()
///
///       elementary.asin(-1.1)
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

@external(erlang, "math", "asin")
@external(javascript, "../../maths.mjs", "asin")
fn do_asin(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.asinh(0.0)
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

@external(erlang, "math", "asinh")
@external(javascript, "../../maths.mjs", "asinh")
fn do_asinh(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.atan(0.0)
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

@external(erlang, "math", "atan")
@external(javascript, "../../maths.mjs", "atan")
fn do_atan(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.atan2(0.0, 0.0)
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

@external(erlang, "math", "atan2")
@external(javascript, "../../maths.mjs", "atan2")
fn do_atan2(a: Float, b: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.atanh(0.0)
///       |> should.equal(Ok(0.0))
///
///       elementary.atanh(1.0)
///       |> should.be_error()
///
///       elementary.atanh(-1.0)
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

@external(erlang, "math", "atanh")
@external(javascript, "../../maths.mjs", "atanh")
fn do_atanh(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.cos(0.0)
///       |> should.equal(1.0)
///
///       elementary.cos(elementary.pi())
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

@external(erlang, "math", "cos")
@external(javascript, "../../maths.mjs", "cos")
fn do_cos(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.cosh(0.0)
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

@external(erlang, "math", "cosh")
@external(javascript, "../../maths.mjs", "cosh")
fn do_cosh(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.sin(0.0)
///       |> should.equal(0.0)
///
///       elementary.sin(0.5 *. elementary.pi())
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

@external(erlang, "math", "sin")
@external(javascript, "../../maths.mjs", "sin")
fn do_sin(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.sinh(0.0)
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

@external(erlang, "math", "sinh")
@external(javascript, "../../maths.mjs", "sinh")
fn do_sinh(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.tan(0.0)
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

@external(erlang, "math", "tan")
@external(javascript, "../../maths.mjs", "tan")
fn do_tan(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example () {
///       elementary.tanh(0.0)
///       |> should.equal(0.0)
///
///       elementary.tanh(25.0)
///       |> should.equal(1.0)
///
///       elementary.tanh(-25.0)
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

@external(erlang, "math", "tanh")
@external(javascript, "../../maths.mjs", "tanh")
fn do_tanh(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.exponential(0.0)
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

@external(erlang, "math", "exp")
@external(javascript, "../../maths.mjs", "exponential")
fn do_exponential(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example () {
///       elementary.natural_logarithm(1.0)
///       |> should.equal(Ok(0.0))
///
///       elementary.natural_logarithm(elementary.e())
///       |> should.equal(Ok(1.0))
///
///       elementary.natural_logarithm(-1.0)
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

@external(erlang, "math", "log")
@external(javascript, "../../maths.mjs", "logarithm")
fn do_natural_logarithm(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example () {
///       elementary.logarithm(1.0, option.Some(10.0))
///       |> should.equal(Ok(0.0))
///
///       elementary.logarithm(elementary.e(), option.Some(elementary.e()))
///       |> should.equal(Ok(1.0))
///
///       elementary.logarithm(-1.0, option.Some(2.0))
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
              let assert Ok(numerator) = logarithm_10(x)
              let assert Ok(denominator) = logarithm_10(a)
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
///     import gleam_community/maths/elementary
///
///     pub fn example () {
///       elementary.logarithm_2(1.0)
///       |> should.equal(Ok(0.0))
///
///       elementary.logarithm_2(2.0)
///       |> should.equal(Ok(1.0))
///
///       elementary.logarithm_2(-1.0)
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

@external(erlang, "math", "log2")
@external(javascript, "../../maths.mjs", "logarithm_2")
fn do_logarithm_2(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example () {
///       elementary.logarithm_10(1.0)
///       |> should.equal(Ok(0.0))
///
///       elementary.logarithm_10(10.0)
///       |> should.equal(Ok(1.0))
///
///       elementary.logarithm_10(-1.0)
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

@external(erlang, "math", "log10")
@external(javascript, "../../maths.mjs", "logarithm_10")
fn do_logarithm_10(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.power(2., -1.)
///       |> should.equal(Ok(0.5))
///
///       elementary.power(2., 2.)
///       |> should.equal(Ok(4.0))
///
///       elementary.power(-1., 0.5)
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

@external(erlang, "math", "pow")
@external(javascript, "../../maths.mjs", "power")
fn do_power(a: Float, b: Float) -> Float

@external(erlang, "math", "ceil")
@external(javascript, "../../maths.mjs", "ceiling")
fn do_ceiling(a: Float) -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.square_root(1.0)
///       |> should.equal(Ok(1.0))
///
///       elementary.square_root(4.0)
///       |> should.equal(Ok(2.0))
///
///       elementary.square_root(-1.0)
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
      let assert Ok(result) = power(x, 1.0 /. 2.0)
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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.cube_root(1.0)
///       |> should.equal(Ok(1.0))
///
///       elementary.cube_root(27.0)
///       |> should.equal(Ok(3.0))
///
///       elementary.cube_root(-1.0)
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
      let assert Ok(result) = power(x, 1.0 /. 3.0)
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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       elementary.nth_root(1.0, 2)
///       |> should.equal(Ok(1.0))
///
///       elementary.nth_root(27.0, 3)
///       |> should.equal(Ok(3.0))
///
///       elementary.nth_root(256.0, 4)
///       |> should.equal(Ok(4.0))
///
///       elementary.nth_root(-1.0, 2)
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
          let assert Ok(result) = power(x, 1.0 /. int.to_float(n))
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

@external(erlang, "math", "pi")
@external(javascript, "../../maths.mjs", "pi")
fn do_pi() -> Float

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
///     import gleam_community/maths/elementary
///
///     pub fn example() {
///       // Test that the constant is approximately equal to 2.7128...
///       elementary.e()
///       |> elementary.is_close(2.7128, 0.0, 0.000001)
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
