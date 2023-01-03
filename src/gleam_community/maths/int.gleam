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
//// applying to integer numbers.
////
//// Function naming has been adopted from <a href="https://en.wikipedia.org/wiki/C_mathematical_functions"> C mathematical function</a>.
////
//// ---
////
//// * **Sign and absolute value functions**
////   * [`abs2`](#abs2)
////   * [`absdiff`](#abs_diff)
////   * [`sign`](#sign)
////   * [`copysign`](#copysign)
////   * [`flipsign`](#flipsign)
//// * **Powers, logs and roots**
////   * [`exp`](#exp)
////   * [`ln`](#ln)
////   * [`log`](#log)
////   * [`log10`](#log10)
////   * [`log2`](#log2)
////   * [`pow`](#pow)
////   * [`sqrt`](#sqrt)
////   * [`cbrt`](#cbrt)
////   * [`hypot`](#hypot)
//// * **Misc. mathematical functions**
////   * [`min`](#min)
////   * [`max`](#max)
////   * [`minmax`](#minmax)
//// * **Division functions**
////   * [`gcd`](#gcd)
////   * [`lcm`](#lcm)
//// * **Combinatorial functions**
////   * [`combination`](#combination)
////   * [`factorial`](#factorial)
////   * [`permutation`](#permutation)
//// * **Tests**
////   * [`ispow2`](#ispow2)
////   * [`iseven`](#iseven)
////   * [`isodd`](#isodd)
//// * **Misc. functions**
////   * [`to_float`](#to_float)

import gleam/list
import gleam/int
import gleam/float

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
pub fn min(x: Int, y: Int) -> Int {
  case x < y {
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
pub fn max(x: Int, y: Int) -> Int {
  case x > y {
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
pub fn minmax(x: Int, y: Int) -> #(Int, Int) {
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
pub fn sign(x: Int) -> Int {
  do_sign(x)
}

if erlang {
  fn do_sign(x: Int) -> Int {
    case x < 0 {
      True -> -1
      False ->
        case x == 0 {
          True -> 0
          False -> 1
        }
    }
  }
}

if javascript {
  external fn do_sign(Int) -> Int =
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
pub fn flipsign(x: Int) -> Int {
  -1 * x
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
              list.range(1, min)
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
          list.range(1, n)
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
pub fn absdiff(a: Int, b: Int) -> Int {
  a - b
  |> int.absolute_value()
}
