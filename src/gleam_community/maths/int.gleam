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
//// A module containing mathematical functions applying to integers.
////
//// ---
////
//// * **Sign and absolute value functions**
////   * [`absolute_difference`](#absolute_difference)
////   * [`sign`](#sign)
////   * [`copy_sign`](#copysign)
////   * [`flip_sign`](#flipsign)
//// * **Misc. mathematical functions**
////   * [`minimum`](#min)
////   * [`maximum`](#max)
////   * [`minmax`](#minmax)
//// * **Division functions**
////   * [`gcd`](#gcd)
////   * [`lcm`](#lcm)
////   * [`divisors`](#divisors)
////   * [`proper_divisors`](#proper_divisors)
//// * **Combinatorial functions**
////   * [`combination`](#combination)
////   * [`factorial`](#factorial)
////   * [`permutation`](#permutation)
//// * **Tests**
////   * [`is_power`](#is_power)
////   * [`is_perfect`](#is_perfect)
////   * [`is_even`](#is_even)
////   * [`is_odd`](#isodd)
//// * **Misc. functions**
////   * [`to_float`](#to_float)

import gleam/list
import gleam/int
import gleam/float
import gleam/io
import gleam/option
import gleam_community/maths/float as floatx

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The minimum function that takes two arguments $$x, y \in \mathbb{Z}$$ and returns the smallest of the two.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.minimum(2, 1)
///       |> should.equal(1)
///
///       intx.minimum(1, 2)
///       |> should.equal(1)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minimum(x: Int, y: Int) -> Int {
  case x < y {
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
/// The maximum function that takes two arguments $$x, y \in \mathbb{Z}$$ and returns the largest of the two.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.maximum(2, 1)
///       |> should.equal(1)
///
///       intx.maximum(1, 2)
///       |> should.equal(1)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn maximum(x: Int, y: Int) -> Int {
  case x > y {
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
/// The minmax function that takes two arguments $$x, y \in \mathbb{Z}$$ and returns a tuple with the smallest value first and largest second.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.minmax(2, 1)
///       |> should.equal(#(1, 2))
///
///       intx.minmax(1, 2)
///       |> should.equal(#(1, 2))
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
  #(minimum(x, y), maximum(x, y))
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The sign function which returns the sign of the input, indicating
/// whether it is positive (+1), negative (-1), or zero (0).
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
    "../../maths.mjs" "sign"
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
pub fn flip_sign(x: Int) -> Int {
  -1 * x
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes two arguments $$x, y \in \mathbb{Z}$$ and returns $$x$$ such that it has the same sign as $$y$$.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn copy_sign(x: Int, y: Int) -> Int {
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
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       // Invalid input gives an error
///       // Error on: n = -1 < 0
///       intx.combination(-1, 1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       intx.combination(4, 0)
///       |> should.equal(Ok(1))
///
///       intx.combination(4, 4)
///       |> should.equal(Ok(1))
///
///       intx.combination(4, 2)
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
///     <a href="https://github.com/gleam-community/maths/issues">
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
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       // Invalid input gives an error
///       intx.factorial(-1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       intx.factorial(0)
///       |> should.equal(Ok(1))
///       intx.factorial(1)
///       |> should.equal(Ok(1))
///       intx.factorial(2)
///       |> should.equal(Ok(2))
///       intx.factorial(3)
///       |> should.equal(Ok(6))
///       intx.factorial(4)
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
///     <a href="https://github.com/gleam-community/maths/issues">
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
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       // Invalid input gives an error
///       // Error on: n = -1 < 0
///       intx.permutation(-1, 1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       intx.permutation(4, 0)
///       |> should.equal(Ok(1))
///
///       intx.permutation(4, 4)
///       |> should.equal(Ok(1))
///
///       intx.permutation(4, 2)
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
/// The function takes two inputs $$x$$ and $$y$$ and returns a positive integer value which is the the absolute difference of the inputs.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.absolute_difference(-10.0, 10.0)
///       |> should.equal(20.0)
///
///       intx.absolute_difference(0.0, -2.0)
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
pub fn absolute_difference(a: Int, b: Int) -> Int {
  a - b
  |> int.absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value $$x \in \mathbb{Z}$$ is a power of another integer value $$y \in \mathbb{Z}$$.  
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       // Check if 4 is a power of 2 (it is)
///       intx.is_power(4, 2)
///       |> should.equal(True)
///
///       // Check if 5 is a power of 2 (it is not)
///       intx.is_power(5, 2)
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
  assert Ok(value) =
    floatx.logarithm(int.to_float(x), option.Some(int.to_float(y)))
  assert Ok(truncated) = floatx.truncate(value, option.Some(0))
  let rem = value -. truncated
  rem == 0.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value $$n \in \mathbb{Z}$$ is a perfect number. A number is perfect if it is equal to the sum of its proper positive divisors.
/// 
/// <details>
///     <summary>Details</summary>
///
///   For example:
///   - $$6$$ is a perfect number since the divisors of 6 are $$1 + 2 + 3 = 6$$.
///   - $$28$$ is a perfect number since the divisors of 28 are $$1 + 2 + 4 + 7 + 14 = 28$$
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.is_perfect(6)
///       |> should.equal(True)
///
///       intx.is_perfect(28)
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
  do_sum(proper_divisors(n)) == n
}

fn do_sum(arr: List(Int)) -> Int {
  case arr {
    [] -> 0
    _ ->
      arr
      |> list.fold(0, fn(acc: Int, a: Int) -> Int { a + acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns all the positive divisors of an integer, excluding the number iteself.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.proper_divisors(4)
///       |> should.equal([1, 2])
///
///       intx.proper_divisors(6)
///       |> should.equal([1, 2, 3])
///
///       intx.proper_divisors(13)
///       |> should.equal([1])
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
pub fn proper_divisors(n: Int) -> List(Int) {
  let divisors: List(Int) = find_divisors(n)
  divisors
  |> list.take(list.length(divisors) - 1)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns all the positive divisors of an integer, including the number iteself.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.divisors(4)
///       |> should.equal([1, 2, 4])
///
///       intx.divisors(6)
///       |> should.equal([1, 2, 3, 6])
///
///       intx.proper_divisors(13)
///       |> should.equal([1, 13])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn divisors(n: Int) -> List(Int) {
  find_divisors(n)
}

pub fn find_divisors(n: Int) -> List(Int) {
  let nabs: Float = float.absolute_value(to_float(n))
  assert Ok(sqrt_result) = floatx.square_root(nabs)
  let max: Int = floatx.to_int(sqrt_result) + 1
  list.range(2, max)
  |> list.fold(
    [1, n],
    fn(acc: List(Int), i: Int) -> List(Int) {
      case n % i == 0 {
        True -> [i, n / i, ..acc]
        False -> acc
      }
    },
  )
  |> list.unique()
  |> list.sort(int.compare)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function calculates the greatest common multiple of two integers $$x, y \in \mathbb{Z}$$.
/// The greatest common multiple is the largest positive integer that is divisible by both $$x$$ and $$y$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.lcm(1, 1)
///       |> should.equal(1)
///   
///       intx.lcm(100, 10)
///       |> should.equal(10)
///
///       intx.gcd(-36, -17)
///       |> should.equal(1)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn gcd(x: Int, y: Int) -> Int {
  let absx: Int = int.absolute_value(x)
  let absy: Int = int.absolute_value(y)
  do_gcd(absx, absy)
}

pub fn do_gcd(x: Int, y: Int) -> Int {
  case x == 0 {
    True -> y
    False -> {
      assert Ok(z) = int.modulo(y, x)
      do_gcd(z, x)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function calculates the least common multiple of two integers $$x, y \in \mathbb{Z}$$.
/// The least common multiple is the smallest positive integer that has both $$x$$ and $$y$$ as factors.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.lcm(1, 1)
///       |> should.equal(1)
///   
///       intx.lcm(100, 10)
///       |> should.equal(100)
///
///       intx.lcm(-36, -17)
///       |> should.equal(612)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn lcm(x: Int, y: Int) -> Int {
  let absx: Int = int.absolute_value(x)
  let absy: Int = int.absolute_value(y)
  absx * absy / do_gcd(absx, absy)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value $$x \in \mathbb{Z}$$ is odd.  
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.is_odd(-3)
///       |> should.equal(True)
///     
///       intx.is_odd(-4)
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
/// A function that tests whether a given integer value $$x \in \mathbb{Z}$$ is even.  
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.is_even(-3)
///       |> should.equal(False)
///     
///       intx.is_even(-4)
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
/// A function that produces a number of type `Float` and from an `Int`.
/// 
/// Note: The function is equivalent to the similar function in the Gleam stdlib.
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/int as intx
///
///     pub fn example() {
///       intx.to_float(-1)
///       |> should.equal(-1.0)
///     
///       intx.is_even(1)
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
pub fn to_float(x: Int) -> Float {
  int.to_float(x)
}
