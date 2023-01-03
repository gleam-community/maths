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
//// A module containing several different kinds of mathematical constants and 
//// functions applying to real numbers.
////
//// Function naming has been adopted from <a href="https://en.wikipedia.org/wiki/C_mathematical_functions"> C mathematical function</a>.
//// 
//// ---
////
//// * **Rounding functions**
////   * [`ceiling`](#ceiling)
////   * [`floor`](#floor)
////   * [`truncate`](#truncate)
////   * [`round`](#round)
//// * **Division functions**
////   * [`gcd`](#gcd)
////   * [`lcm`](#lcm)
//// * **Sign and absolute value functions**
////   * [`abs2`](#abs2)
////   * [`absdiff`](#abs_diff)
////   * [`sign`](#sign)
////   * [`flipsign`](#flipsign)
////   * [`copysign`](#copysign)
//// * **Powers, logs and roots**
////   * [`exp`](#exp)
////   * [`log`](#log)
////   * [`log10`](#log10)
////   * [`log2`](#log2)
////   * [`pow`](#pow)
////
////   * [`isqrt`](#isqrt)
////   * [`icbrt`](#icbrt)
////
////   * [`sqrt`](#sqrt)
////   * [`cbrt`](#cbrt)
////   * [`nthrt`](#nthrt)
////   * [`hypot`](#hypot)
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
////   * [`deg2rad`](#deg2rad)
////   * [`rad2deg`](#rad2deg)
//// * **Mathematical functions**
////   * [`min`](#min)
////   * [`max`](#max)
////   * [`minmax`](#minmax)
//// * **Special mathematical functions**
////   * [`beta`](#beta)
////   * [`erf`](#erf)
////   * [`gamma`](#gamma)
////   * [`gammainc`](#gammainc)
//// * **Mathematical constants**
////   * [`pi`](#pi)
////   * [`tau`](#tau)
//// * **Tests**
////   * [`ispow2`](#ispow2)
////   * [`isclose`](#isclose)
////   * [`iseven`](#iseven)
////   * [`isodd`](#isodd)

import gleam/list
import gleam/int
import gleam/float
import gleam/option
import gleam/io

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
pub fn log(x: Float, base: option.Option) -> Result(Float, String) {
  case x >. 0.0 {
    True -> {
      case base {
        option.Some(a) -> {
          case a >. 0.0 && a != 1.0 {
            True -> {
              // Apply the change of base formula
              assert Ok(numerator) = log10(x)
              assert Ok(denominator) = log10(b)
              numerator /. denominator
              |> Ok
            }
            False ->
              "Invalid input argument: base <= 0 or base == 1. Valid input is base > 0 and base != 1."
              |> Error
          }
          case 
        }
        _ -> {
          "Invalid input argument: x <= 0. Valid input is x > 0."
          |> Error
        }
      }
    }
  }
  // case x >. 0.0 {
  //   True ->
  //     do_log(x)
  //     |> Ok
  //   False ->
  //     "Invalid input argument: x <= 0. Valid input is x > 0."
  //     |> Error
  // }
}

pub fn ln(x: Float) -> Result(Float, String) {
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

// pub fn logb(x: Float, b: Float) -> Result(Float, String) {
//   case x >. 0.0 {
//     True ->
//       case b >. 0.0 && b != 1.0 {
//         True -> {
//           // Apply the change of base formula
//           assert Ok(numerator) = log10(x)
//           assert Ok(denominator) = log10(b)
//           numerator /. denominator
//           |> Ok
//         }
//         False ->
//           "Invalid input argument: b <= 0 or b == 1. Valid input is b > 0 and b != 1."
//           |> Error
//       }
//     False ->
//       "Invalid input argument: x <= 0. Valid input is x > 0."
//       |> Error
//   }
// }

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
/// The square root function: $$y = \sqrt[2]{x} = x^{\frac{1}{2}}$$.
///
/// Note that the function is not defined if:
/// 1. The base is negative ($$x < 0$$). An error will be returned
///    as an imaginary number will otherwise have to be returned.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.sqrt(1.0)
///       |> should.equal(1.0)
///
///       math.sqrt(4.0)
///       |> should.equal(2.0)
///
///       math.sqrt(-1.0)
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
pub fn sqrt(x: Float) -> Result(Float, String) {
  // In the following check:
  // 1. If x is negative then return an error as it will otherwise be an 
  // imaginary number
  case x <. 0.0 {
    True ->
      "Invalid input argument: x < 0."
      |> Error
    False -> {
      assert Ok(result) = pow(x, 1.0 /. 2.0)
      result
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
/// The cube root function: $$y = \sqrt[3]{x} = x^{\frac{1}{3}}$$.
///
/// Note that the function is not defined if:
/// 1. The base is negative ($$x < 0$$). An error will be returned
///    as an imaginary number will otherwise have to be returned.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.cbrt(1.0)
///       |> should.equal(1.0)
///
///       math.cbrt(27.0)
///       |> should.equal(3.0)
///
///       math.cbrt(-1.0)
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
pub fn cbrt(x: Float) -> Result(Float, String) {
  // In the following check:
  // 1. If x is negative then return an error as it will otherwise be an 
  // imaginary number
  case x <. 0.0 {
    True ->
      "Invalid input argument: x < 0."
      |> Error
    False -> {
      assert Ok(result) = pow(x, 1.0 /. 3.0)
      result
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
/// A function to compute the hypotenuse of a right-angled triangle: $$\sqrt[2](x^2 + y^2)$$.
///
/// The function can also be used to calculate the Euclidean distance in 2 dimensions. 
///
/// Naive (unfused) and corrected (unfused) in [https://arxiv.org/pdf/1904.09481.pdf]("An Improved Algorithm for Hypot(A, B)" by Borges, C. F)
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn hypot(x: Float, y: Float, corrected: option.Option(Bool)) -> Float {
  assert Ok(term1) = pow(x, 2.0)
  assert Ok(term2) = pow(y, 2.0)
  assert Ok(h) = sqrt(term1 +. term2)
  case corrected {
    option.Some(True) -> {
      let ax = float.absolute_value(x)
      let ay = float.absolute_value(y)
      case ay >. ax {
        True -> {

        }
        False -> {

        }
      }
    }
    _ -> {
      h
    }
  }
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
///       math.rad2deg(0.0)
///       |> should.equal(0.0)
///
///       math.rad2deg(2. *. pi())
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
pub fn rad2deg(x: Float) -> Float {
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
///       math.deg2rad(360.)
///       |> should.equal(2. *. pi())
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn deg2rad(x: Float) -> Float {
  x *. pi() /. 180.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The ceiling function that rounds given input $$x \in \mathbb{R}$$ towards $$+\infty$$. 
/// ceil(x) returns the nearest integral value of the same type as x that is greater than or equal to x.
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
/// The floor function that rounds given input $$x \in \mathbb{R}$$ towards $$-\infty$$. 
/// floor(x) returns the nearest integral value of the same type as x that is less than or equal to x.
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

fn to_int(x: Float) -> Int {
  do_to_int(x)
}

if erlang {
  external fn do_to_int(Float) -> Int =
    "erlang" "trunc"
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
pub fn round(
  x: Float,
  digits: option.Option(Int),
  mode: option.Option(String),
) -> Result(Float, String) {
  case digits {
    option.Some(a) ->
      case mode {
        option.Some("Nearest") -> {
          let positive = x >. 0.0
          // let geq_tie =
          //   float.absolute_value(x) -. float.absolute_value(truncate(x)) >=. 0.5
          let xabs = float.absolute_value(x)
          let geq_tie = xabs -. truncate(xabs) >=. 0.5
          assert Ok(is_even) = int.modulo(to_int(xabs), 2)
          io.debug(is_even)
          case geq_tie {
            True ->
              case is_even == 0 {
                True -> {
                  assert Ok(p) = pow(10.0, int.to_float(a))
                  sign(x) *. truncate({ xabs +. 0.0 } *. p) /. p
                  |> Ok
                }
                False -> {
                  assert Ok(p) = pow(10.0, int.to_float(a))
                  sign(x) *. truncate({ xabs +. 1.0 } *. p) /. p
                  |> Ok
                }
              }
            False -> {
              assert Ok(p) = pow(10.0, int.to_float(a))
              sign(x) *. truncate({ xabs +. 0.0 } *. p) /. p
              |> Ok
            }
          }
        }
        option.Some("TiesAway") -> {
          let positive = x >. 0.0
          let xabs = float.absolute_value(x)
          let g_tie = xabs -. truncate(xabs) >=. 0.5
          io.debug(xabs -. truncate(xabs))
          //   assert Ok(p) = pow(10.0, int.to_float(a))
          //   sign(x) *. truncate({ float.absolute_value(x) +. 1.0 } *. p) /. p
          //   |> Ok
          case g_tie {
            True -> {
              assert Ok(p) = pow(10.0, int.to_float(a))
              sign(x) *. truncate({ xabs +. 1.0 } *. p) /. p
              |> Ok
            }
            False -> {
              assert Ok(p) = pow(10.0, int.to_float(a))
              truncate(x *. p) /. p
              |> Ok
            }
          }
        }
        // assert Ok(p) = pow(10.0, int.to_float(a))
        // sign(x) *. truncate({ float.absolute_value(x) +. 1.0 } *. p) /. p
        // |> Ok
        // Round towards positive infinity
        option.Some("TiesUp") -> {
          let positive = x >. 0.0
          // let geq_tie =
          //   float.absolute_value(x) -. float.absolute_value(truncate(x)) >=. 0.5
          let xabs = float.absolute_value(x)
          let geq_tie = xabs -. truncate(xabs) >=. 0.5
          case geq_tie {
            True ->
              case positive {
                True -> {
                  assert Ok(p) = pow(10.0, int.to_float(a))
                  sign(x) *. truncate({ xabs +. 1.0 } *. p) /. p
                  |> Ok
                }
                False -> {
                  assert Ok(p) = pow(10.0, int.to_float(a))
                  sign(x) *. truncate({ xabs +. 0.0 } *. p) /. p
                  |> Ok
                }
              }
            False ->
              case positive {
                True -> {
                  assert Ok(p) = pow(10.0, int.to_float(a))
                  sign(x) *. truncate({ xabs +. 0.0 } *. p) /. p
                  |> Ok
                }
                False -> {
                  assert Ok(p) = pow(10.0, int.to_float(a))
                  sign(x) *. truncate({ xabs +. 0.0 } *. p) /. p
                  |> Ok
                }
              }
          }
        }
        option.Some("ToZero") -> {
          assert Ok(p) = pow(10.0, int.to_float(a))
          truncate(x *. p) /. p
          |> Ok
        }
        option.Some("Down") -> {
          assert Ok(p) = pow(10.0, int.to_float(a))
          floor(x *. p) /. p
          |> Ok
        }
        option.Some("Up") -> {
          assert Ok(p) = pow(10.0, int.to_float(a))
          ceil(x *. p) /. p
          |> Ok
        }
        _ ->
          "Invalid Rounding Mode!"
          |> Error
      }
    _ ->
      "Invalid!"
      |> Error
  }
  // assert Ok(p) = pow(10.0, int.to_float(digits))
  // int.to_float(float.round(x *. p)) /. p
}

pub fn truncate(x: Float) -> Float {
  do_truncate(x)
}

if erlang {
  external fn do_truncate(Float) -> Float =
    "erlang" "trunc"
}

// pub fn round_to_nearest_ties_away(x: Float, digits: Int) -> Float {
//   assert Ok(p) = pow(10.0, int.to_float(digits))
//   int.to_float(float.round(x *. p)) /. p
// }

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
///
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
pub fn trunc(x: Float, precision: Int) -> Float {
  assert Ok(p) = pow(10.0, int.to_float(precision))
  int.to_float(float.round(x *. p)) /. p
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The min function.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.min(2.0, 1.5)
///       |> should.equal(1.5)
///
///       math.min(1.5, 2.0)
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
pub fn min(x: Float, y: Float) -> Float {
  case x <. y {
    True -> x
    False -> y
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The min function.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.min(2.0, 1.5)
///       |> should.equal(1.5)
///
///       math.min(1.5, 2.0)
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
pub fn max(x: Float, y: Float) -> Float {
  case x >. y {
    True -> x
    False -> y
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The minmax function.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.minmax(2.0, 1.5)
///       |> should.equal(#(1.5, 2.0))
///
///       math.minmax(1.5, 2.0)
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
  #(min(x, y), max(x, y))
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
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn flipsign(x: Float) -> Float {
  -1.0 *. x
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

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/math
///
///     pub fn example() {
///       math.absdiff(-10.0, 10.0)
///       |> should.equal(20.0)
///
///       math.absdiff(0.0, -2.0)
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
pub fn absdiff(a: Float, b: Float) -> Float {
  a -. b
  |> float.absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/nicklasxyz/gleam_stats/issues">
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
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_stats/stats
///
///     pub fn example () {
///       let val: Float = 99.
///       let ref_val: Float = 100.
///       // We set 'atol' and 'rtol' such that the values are equivalent
///       // if 'val' is within 1 percent of 'ref_val' +/- 0.1
///       let rtol: Float = 0.01
///       let atol: Float = 0.10
///       stats.isclose(val, ref_val, rtol, atol)
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
pub fn isclose(a: Float, b: Float, rtol: Float, atol: Float) -> Bool {
  let x: Float = float.absolute_value(a -. b)
  let y: Float = atol +. rtol *. float.absolute_value(b)
  case x <=. y {
    True -> True
    False -> False
  }
}
