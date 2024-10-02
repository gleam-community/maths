////<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css" integrity="sha384-nB0miv6/jRmo5UMMR1wu3Gz6NLsoTkbqJghGIsx//Rlm+ZU03BU6SQNC66uf4l5+" crossorigin="anonymous">
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js" integrity="sha384-7zkQWkzuo3B5mTepMUcHkMB5jZaolc2xDwL6VFqjFALcbeS9Ggm/Yr2r3Dy4lfFg" crossorigin="anonymous"></script>
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js" integrity="sha384-43gviWU0YVjaDtb/GhzOouOXtZMP/7XUzwPTstBeZFe/+rCMvRwr4yROQP43s0Xk" crossorigin="anonymous"></script>
////<script>
////    document.addEventListener("DOMContentLoaded", function() {
////        renderMathInElement(document.body, {
////          // customised options
////          // • auto-render specific keys, e.g.:
////          delimiters: [
////              {left: '$$', right: '$$', display: false},
////              {left: '$', right: '$', display: false},
////              {left: '\\(', right: '\\)', display: false},
////              {left: '\\[', right: '\\]', display: true}
////          ],
////          // • rendering keys, e.g.:
////          throwOnError : true
////        });
////    });
////</script>
////<style>
////    .katex { font-size: 1.1em; }
////</style>
////
//// ---
////
//// Predicates: A module containing functions for testing various mathematical
//// properties of numbers.
////
//// * **Tests**
////   * [`is_close`](#is_close)
////   * [`list_all_close`](#all_close)
////   * [`is_fractional`](#is_fractional)
////   * [`is_between`](#is_between)
////   * [`is_power`](#is_power)
////   * [`is_perfect`](#is_perfect)
////   * [`is_even`](#is_even)
////   * [`is_odd`](#is_odd)
////   * [`is_divisible`](#is_divisible)
////   * [`is_multiple`](#is_multiple)
////   * [`is_prime`](#is_prime)
////

import gleam/int
import gleam/list
import gleam/option
import gleam/pair
import gleam_community/maths/arithmetics
import gleam_community/maths/elementary
import gleam_community/maths/piecewise

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a given value \\(a\\) is close to or equivalent to a reference value
/// \\(b\\) based on supplied relative \\(r_{tol}\\) and absolute \\(a_{tol}\\) tolerance
/// values. The equivalance of the two given values are then determined based on
/// the equation:
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
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let val = 99.
///       let ref_val = 100.
///       // We set 'atol' and 'rtol' such that the values are equivalent
///       // if 'val' is within 1 percent of 'ref_val' +/- 0.1
///       let rtol = 0.01
///       let atol = 0.10
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
  let x = float_absolute_difference(a, b)
  let y = atol +. rtol *. float_absolute_value(b)
  case x <=. y {
    True -> True
    False -> False
  }
}

fn float_absolute_value(x: Float) -> Float {
  case x >. 0.0 {
    True -> x
    False -> -1.0 *. x
  }
}

fn float_absolute_difference(a: Float, b: Float) -> Float {
  a -. b
  |> float_absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a list of values are close to or equivalent to a another list of
/// reference values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/list
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       let val = 99.
///       let ref_val = 100.
///       let xarr = list.repeat(val, 42)
///       let yarr = list.repeat(ref_val, 42)
///       // We set 'atol' and 'rtol' such that the values are equivalent
///       // if 'val' is within 1 percent of 'ref_val' +/- 0.1
///       let rtol = 0.01
///       let atol = 0.10
///       predicates.all_close(xarr, yarr, rtol, atol)
///       |> fn(zarr: Result(List(Bool), Nil)) -> Result(Bool, Nil) {
///         case zarr {
///           Ok(arr) ->
///             arr
///             |> list.all(fn(a) { a })
///             |> Ok
///           _ -> Nil |> Error
///         }
///       }
///       |> should.equal(Ok(True))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn all_close(
  xarr: List(Float),
  yarr: List(Float),
  rtol: Float,
  atol: Float,
) -> Result(List(Bool), Nil) {
  let xlen = list.length(xarr)
  let ylen = list.length(yarr)
  case xlen == ylen {
    False -> Error(Nil)
    True ->
      list.zip(xarr, yarr)
      |> list.map(fn(z) { is_close(pair.first(z), pair.second(z), rtol, atol) })
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a given value is fractional.
///
/// `True` is returned if the given value is fractional, otherwise `False` is
/// returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example () {
///       predicates.is_fractional(0.3333)
///       |> should.equal(True)
///
///       predicates.is_fractional(1.0)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_fractional(x: Float) -> Bool {
  do_ceiling(x) -. x >. 0.0
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
/// A function that tests whether a given integer value \\(x \in \mathbb{Z}\\) is a
/// power of another integer value \\(y \in \mathbb{Z}\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       // Check if 4 is a power of 2 (it is)
///       predicates.is_power(4, 2)
///       |> should.equal(True)
///
///       // Check if 5 is a power of 2 (it is not)
///       predicates.is_power(5, 2)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_power(x: Int, y: Int) -> Bool {
  let assert Ok(value) =
    elementary.logarithm(int.to_float(x), option.Some(int.to_float(y)))
  let truncated = piecewise.truncate(value, option.Some(0))
  let remainder = value -. truncated
  remainder == 0.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value \\(n \in \mathbb{Z}\\) is a
/// perfect number. A number is perfect if it is equal to the sum of its proper
/// positive divisors.
///
/// <details>
///     <summary>Details</summary>
///
///   For example:
///   - \\(6\\) is a perfect number since the divisors of 6 are \\(1 + 2 + 3 = 6\\).
///   - \\(28\\) is a perfect number since the divisors of 28 are \\(1 + 2 + 4 + 7 + 14 = 28\\).
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       predicates.is_perfect(6)
///       |> should.equal(True)
///
///       predicates.is_perfect(28)
///       |> should.equal(True)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_perfect(n: Int) -> Bool {
  do_sum(arithmetics.proper_divisors(n)) == n
}

fn do_sum(arr: List(Int)) -> Int {
  case arr {
    [] -> 0
    _ ->
      arr
      |> list.fold(0, fn(acc, a) { a + acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value \\(x \in \mathbb{Z}\\) is even.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       predicates.is_even(-3)
///       |> should.equal(False)
///
///       predicates.is_even(-4)
///       |> should.equal(True)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_even(x: Int) -> Bool {
  x % 2 == 0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value \\(x \in \mathbb{Z}\\) is odd.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       predicates.is_odd(-3)
///       |> should.equal(True)
///
///       predicates.is_odd(-4)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_odd(x: Int) -> Bool {
  x % 2 != 0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value \\(x \in \mathbb{Z}\\) is a
/// prime number. A prime number is a natural number greater than 1 that has no
/// positive divisors other than 1 and itself.
///
/// The function uses the Miller-Rabin primality test to assess if \\(x\\) is prime.
/// It is a probabilistic test, so it can mistakenly identify a composite number
/// as prime. However, the probability of such errors decreases with more testing
/// iterations (the function uses 64 iterations internally, which is typically
/// more than sufficient). The Miller-Rabin test is particularly useful for large
/// numbers.
///
/// <details>
///     <summary>Details</summary>
///
///   Examples of prime numbers:
///   - \\(2\\) is a prime number since it has only two divisors: \\(1\\) and \\(2\\).
///   - \\(7\\) is a prime number since it has only two divisors: \\(1\\) and \\(7\\).
///   - \\(4\\) is not a prime number since it has divisors other than \\(1\\) and itself, such
///     as \\(2\\).
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       predicates.is_prime(2)
///       |> should.equal(True)
///
///       predicates.is_prime(4)
///       |> should.equal(False)
///
///       // Test the 2nd Carmichael number
///       predicates.is_prime(1105)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_prime(x: Int) -> Bool {
  case x {
    x if x < 2 -> {
      False
    }
    x if x == 2 -> {
      True
    }
    _ -> {
      miller_rabin_test(x, 64)
    }
  }
}

fn miller_rabin_test(n: Int, k: Int) -> Bool {
  case n, k {
    _, 0 -> True
    _, _ -> {
      // Generate a random int in the range [2, n]
      let random_candidate = 2 + int.random(n - 2)
      case powmod_with_check(random_candidate, n - 1, n) == 1 {
        True -> miller_rabin_test(n, k - 1)
        False -> False
      }
    }
  }
}

fn powmod_with_check(base: Int, exponent: Int, modulus: Int) -> Int {
  case exponent, { exponent % 2 } == 0 {
    0, _ -> 1
    _, True -> {
      let x = powmod_with_check(base, exponent / 2, modulus)
      case { x * x } % modulus, x != 1 && x != { modulus - 1 } {
        1, True -> 0
        _, _ -> { x * x } % modulus
      }
    }
    _, _ -> { base * powmod_with_check(base, exponent - 1, modulus) } % modulus
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given real number \\(x \in \mathbb{R}\\) is strictly
/// between two other real numbers, \\(a,b \in \mathbb{R}\\), such that \\(a < x < b\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       predicates.is_between(5.5, 5.0, 6.0)
///       |> should.equal(True)
///
///       predicates.is_between(5.0, 5.0, 6.0)
///       |> should.equal(False)
///
///       predicates.is_between(6.0, 5.0, 6.0)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_between(x: Float, lower: Float, upper: Float) -> Bool {
  lower <. x && x <. upper
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer \\(n \in \mathbb{Z}\\) is divisible by another
/// integer \\(d \in \mathbb{Z}\\), such that \\(n \mod d = 0\\).
///
/// <details>
///     <summary>Details</summary>
///
///   For example:
///   - \\(n = 10\\) is divisible by \\(d = 2\\) because \\(10 \mod 2 = 0\\).
///   - \\(n = 7\\) is not divisible by \\(d = 3\\) because \\(7 \mod 3 \neq 0\\).
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       predicates.is_divisible(10, 2)
///       |> should.equal(True)
///
///       predicates.is_divisible(7, 3)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_divisible(n: Int, d: Int) -> Bool {
  n % d == 0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer \\(m \in \mathbb{Z}\\) is a multiple of another
/// integer \\(k \in \mathbb{Z}\\), such that \\(m = k \times q\\), with \\(q \in \mathbb{Z}\\).
///
/// <details>
///     <summary>Details</summary>
///
///   For example:
///   - \\(m = 15\\) is a multiple of \\(k = 5\\) because \\(15 = 5 \times 3\\).
///   - \\(m = 14\\) is not a multiple of \\(k = 5\\) because \\(14 \div 5\\) does not yield an
///     integer quotient.
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/predicates
///
///     pub fn example() {
///       predicates.is_multiple(15, 5)
///       |> should.equal(True)
///
///       predicates.is_multiple(14, 5)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_multiple(m: Int, k: Int) -> Bool {
  m % k == 0
}
