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
//// Arithmetics: A module containing a collection of fundamental mathematical functions relating to simple arithmetics (addition, subtraction, multiplication, etc.), but also number theory.
//// 
//// * **Division functions**
////   * [`gcd`](#gcd)
////   * [`lcm`](#lcm)
////   * [`divisors`](#divisors)
////   * [`proper_divisors`](#proper_divisors)
////   * [`int_euclidean_modulo`](#int_euclidean_modulo)
//// * **Sums and products**
////   * [`float_sum`](#float_sum)
////   * [`int_sum`](#int_sum)
////   * [`float_product`](#float_product)
////   * [`int_product`](#int_product)
////   * [`float_cumulative_sum`](#float_cumulative_sum)
////   * [`int_cumulative_sum`](#int_cumulative_sum)
////   * [`float_cumulative_product`](#float_cumulative_product)
////   * [`int_cumulative_product`](#int_cumulative_product)
//// 

import gleam/int
import gleam/list
import gleam/option
import gleam/pair
import gleam/result
import gleam_community/maths/conversion
import gleam_community/maths/elementary
import gleam_community/maths/piecewise

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function calculates the greatest common divisor of two integers 
/// $$x, y \in \mathbb{Z}$$. The greatest common divisor is the largest positive
/// integer that is divisible by both $$x$$ and $$y$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example() {
///       arithmetics.gcd(1, 1)
///       |> should.equal(1)
///   
///       arithmetics.gcd(100, 10)
///       |> should.equal(10)
///
///       arithmetics.gcd(-36, -17)
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
  let absx: Int = piecewise.int_absolute_value(x)
  let absy: Int = piecewise.int_absolute_value(y)
  do_gcd(absx, absy)
}

fn do_gcd(x: Int, y: Int) -> Int {
  case x == 0 {
    True -> y
    False -> {
      let assert Ok(z) = int.modulo(y, x)
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
/// 
/// Given two integers, $$x$$ (dividend) and $$y$$ (divisor), the Euclidean modulo
/// of $$x$$ by $$y$$, denoted as $$x \mod y$$, is the remainder $$r$$ of the 
/// division of $$x$$ by $$y$$, such that:
/// 
/// \\[
/// x = q \cdot y + r \quad \text{and} \quad 0 \leq r < |y|,
/// \\]
/// 
/// where $$q$$ is an integer that represents the quotient of the division.
///
/// The Euclidean modulo function of two numbers, is the remainder operation most 
/// commonly utilized in mathematics. This differs from the standard truncating 
/// modulo operation frequently employed in programming via the `%` operator. 
/// Unlike the `%` operator, which may return negative results depending on the 
/// divisor's sign, the Euclidean modulo function is designed to always yield a 
/// positive outcome, ensuring consistency with mathematical conventions.
/// 
/// Note that like the Gleam division operator `/` this will return `0` if one of
/// the arguments is `0`.
///
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example() {
///       arithmetics.euclidean_modulo(15, 4)
///       |> should.equal(3)
///   
///       arithmetics.euclidean_modulo(-3, -2)
///       |> should.equal(1)
///
///       arithmetics.euclidean_modulo(5, 0)
///       |> should.equal(0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_euclidean_modulo(x: Int, y: Int) -> Int {
  case x % y, x, y {
    _, 0, _ -> 0
    _, _, 0 -> 0
    md, _, _ if md < 0 -> md + int.absolute_value(y)
    md, _, _ -> md
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function calculates the least common multiple of two integers 
/// $$x, y \in \mathbb{Z}$$. The least common multiple is the smallest positive
/// integer that has both $$x$$ and $$y$$ as factors.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example() {
///       arithmetics.lcm(1, 1)
///       |> should.equal(1)
///   
///       arithmetics.lcm(100, 10)
///       |> should.equal(100)
///
///       arithmetics.lcm(-36, -17)
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
  let absx: Int = piecewise.int_absolute_value(x)
  let absy: Int = piecewise.int_absolute_value(y)
  absx * absy / do_gcd(absx, absy)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns all the positive divisors of an integer, including the 
/// number itself.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example() {
///       arithmetics.divisors(4)
///       |> should.equal([1, 2, 4])
///
///       arithmetics.divisors(6)
///       |> should.equal([1, 2, 3, 6])
///
///       arithmetics.proper_divisors(13)
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

fn find_divisors(n: Int) -> List(Int) {
  let nabs: Float = piecewise.float_absolute_value(conversion.int_to_float(n))
  let assert Ok(sqrt_result) = elementary.square_root(nabs)
  let max: Int = conversion.float_to_int(sqrt_result) + 1
  list.range(2, max)
  |> list.fold([1, n], fn(acc: List(Int), i: Int) -> List(Int) {
    case n % i == 0 {
      True -> [i, n / i, ..acc]
      False -> acc
    }
  })
  |> list.unique()
  |> list.sort(int.compare)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns all the positive divisors of an integer, excluding the 
/// number iteself.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example() {
///       arithmetics.proper_divisors(4)
///       |> should.equal([1, 2])
///
///       arithmetics.proper_divisors(6)
///       |> should.equal([1, 2, 3])
///
///       arithmetics.proper_divisors(13)
///       |> should.equal([1])
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
/// Calculate the (weighted) sum of the elements in a list:
///
/// \\[
/// \sum_{i=1}^n w_i x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{R}$$ is
/// the value in the input list indexed by $$i$$, while the $$w_i \in \mathbb{R}$$
/// are corresponding weights ($$w_i = 1.0\\;\forall i=1...n$$ by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> arithmetics.float_sum(option.None)
///       |> should.equal(0.0)
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> arithmetics.float_sum(option.None)
///       |> should.equal(6.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_sum(arr: List(Float), weights: option.Option(List(Float))) -> Float {
  case arr, weights {
    [], _ -> 0.0
    _, option.None ->
      arr
      |> list.fold(0.0, fn(acc: Float, a: Float) -> Float { a +. acc })
    _, option.Some(warr) -> {
      list.zip(arr, warr)
      |> list.fold(0.0, fn(acc: Float, a: #(Float, Float)) -> Float {
        pair.first(a) *. pair.second(a) +. acc
      })
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the sum of the elements in a list:
///
/// \\[
/// \sum_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{Z}$$ is 
/// the value in the input list indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       // An empty list returns 0
///       []
///       |> arithmetics.int_sum()
///       |> should.equal(0)
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> arithmetics.int_sum()
///       |> should.equal(6)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_sum(arr: List(Int)) -> Int {
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
/// Calculate the (weighted) product of the elements in a list:
///
/// \\[
/// \prod_{i=1}^n x_i^{w_i}
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{R}$$ is
/// the value in the input list indexed by $$i$$, while the $$w_i \in \mathbb{R}$$
/// are corresponding weights ($$w_i = 1.0\\;\forall i=1...n$$ by default).
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/option
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       // An empty list returns 1.0
///       []
///       |> arithmetics.float_product(option.None)
///       |> should.equal(1.0)
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> arithmetics.float_product(option.None)
///       |> should.equal(6.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_product(
  arr: List(Float),
  weights: option.Option(List(Float)),
) -> Result(Float, String) {
  case arr, weights {
    [], _ ->
      1.0
      |> Ok
    _, option.None ->
      arr
      |> list.fold(1.0, fn(acc: Float, a: Float) -> Float { a *. acc })
      |> Ok
    _, option.Some(warr) -> {
      let results =
        list.zip(arr, warr)
        |> list.map(fn(a: #(Float, Float)) -> Result(Float, String) {
          pair.first(a)
          |> elementary.power(pair.second(a))
        })
        |> result.all
      case results {
        Ok(prods) ->
          prods
          |> list.fold(1.0, fn(acc: Float, a: Float) -> Float { a *. acc })
          |> Ok
        Error(msg) ->
          msg
          |> Error
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
/// Calculate the product of the elements in a list:
///
/// \\[
/// \prod_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{Z}$$ is 
/// the value in the input list indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       // An empty list returns 1
///       []
///       |> arithmetics.int_product()
///       |> should.equal(1)
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> arithmetics.int_product()
///       |> should.equal(6)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_product(arr: List(Int)) -> Int {
  case arr {
    [] -> 1
    _ ->
      arr
      |> list.fold(1, fn(acc: Int, a: Int) -> Int { a * acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative sum of $$n$$
/// elements. That is, $$n$$ is the length of the list and $$x_i \in \mathbb{R}$$ 
/// is the value in the input list indexed by $$i$$. The value $$v_j$$ is thus the
/// sum of the $$1$$ to $$j$$ first elements in the given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       []
///       |> arithmetics.float_cumulative_sum()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> arithmetics.float_cumulative_sum()
///       |> should.equal([1.0, 3.0, 6.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_cumulative_sum(arr: List(Float)) -> List(Float) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(0.0, fn(acc: Float, a: Float) -> Float { a +. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative sum of $$n$$
/// elements. That is, $$n$$ is the length of the list and $$x_i \in \mathbb{Z}$$ 
/// is the value in the input list indexed by $$i$$. The value $$v_j$$ is thus the
/// sum of the $$1$$ to $$j$$ first elements in the given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       []
///       |> arithmetics.int_cumulative_sum()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> arithmetics.int_cumulative_sum()
///       |> should.equal([1, 3, 6])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_cumulative_sum(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(0, fn(acc: Int, a: Int) -> Int { a + acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative product of 
/// $$n$$ elements. That is, $$n$$ is the length of the list and 
/// $$x_i \in \mathbb{R}$$ is the value in the input list indexed by $$i$$. The 
/// value $$v_j$$ is thus the sum of the $$1$$ to $$j$$ first elements in the 
/// given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> arithmetics.float_cumulative_product()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> arithmetics.float_cumulative_product()
///       |> should.equal([1.0, 2.0, 6.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_cumulative_product(arr: List(Float)) -> List(Float) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(1.0, fn(acc: Float, a: Float) -> Float { a *. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative product of 
/// $$n$$ elements. That is, $$n$$ is the length of the list and 
/// $$x_i \in \mathbb{Z}$$ is the value in the input list indexed by $$i$$. The 
/// value $$v_j$$ is thus the product of the $$1$$ to $$j$$ first elements in the
/// given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       // An empty list returns an error
///       []
///       |> arithmetics.int_cumulative_product()
///       |> should.equal([])
///
///       // Valid input returns a result
///       [1, 2, 3]
///       |> arithmetics.int_cumulative_product()
///       |> should.equal([1, 2, 6])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_cumulative_product(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(1, fn(acc: Int, a: Int) -> Int { a * acc })
  }
}
