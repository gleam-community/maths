////<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.css" integrity="sha384-GvrOXuhMATgEsSwCs4smul74iXGOixntILdUW9XmUC6+HX0sLNAK3q71HotJqlAn" crossorigin="anonymous">
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.js" integrity="sha384-cpW21h6RZv/phavutF+AuVYrr+dA8xD9zs6FwLpaCct6O9ctzYFfFr4dgmgccOTx" crossorigin="anonymous"></script>
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/contrib/auto-render.min.js" integrity="sha384-+VBxd3r6XgURycqtZ117nYw44OOcIax56Z4dCRWbxyPt0Koah1uHoK0o4+/RRE05" crossorigin="anonymous"></script>
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
import gleam_community/maths/conversion
import gleam_community/maths/elementary
import gleam_community/maths/piecewise

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
///     import gleam_community/maths/arithmetics
///
///     pub fn example() {
///       arithmetics.lcm(1, 1)
///       |> should.equal(1)
///   
///       arithmetics.lcm(100, 10)
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
/// The function calculates the least common multiple of two integers $$x, y \in \mathbb{Z}$$.
/// The least common multiple is the smallest positive integer that has both $$x$$ and $$y$$ as factors.
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
/// The function returns all the positive divisors of an integer, including the number iteself.
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
/// The function returns all the positive divisors of an integer, excluding the number iteself.
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
/// Calculcate the sum of the elements in a list:
///
/// \\[
/// \sum_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{R}$$ is the value in the input list indexed by $$i$$.
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
///       |> arithmetics.float_sum()
///       |> should.equal(0.0)
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> arithmetics.float_sum()
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
pub fn float_sum(arr: List(Float)) -> Float {
  case arr {
    [] -> 0.0
    _ ->
      arr
      |> list.fold(0.0, fn(acc: Float, a: Float) -> Float { a +. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the sum of the elements in a list:
///
/// \\[
/// \sum_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{Z}$$ is the value in the input list indexed by $$i$$.
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
/// Calculcate the product of the elements in a list:
///
/// \\[
/// \prod_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{R}$$ is the value in the input list indexed by $$i$$.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths/arithmetics
///
///     pub fn example () {
///       // An empty list returns 0.0
///       []
///       |> arithmetics.float_product()
///       |> should.equal(0.0)
///
///       // Valid input returns a result
///       [1.0, 2.0, 3.0]
///       |> arithmetics.float_product()
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
pub fn float_product(arr: List(Float)) -> Float {
  case arr {
    [] -> 1.0
    _ ->
      arr
      |> list.fold(1.0, fn(acc: Float, a: Float) -> Float { a *. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculcate the product of the elements in a list:
///
/// \\[
/// \prod_{i=1}^n x_i
/// \\]
///
/// In the formula, $$n$$ is the length of the list and $$x_i \in \mathbb{Z}$$ is the value in the input list indexed by $$i$$.
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
///       |> arithmetics.int_product()
///       |> should.equal(0)
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
/// Calculcate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative sum of $$n$$ elements.
/// That is, $$n$$ is the length of the list and $$x_i \in \mathbb{R}$$ is the value in the input list indexed by $$i$$. 
/// The value $$v_j$$ is thus the sum of the $$1$$ to $$j$$ first elements in the given list.
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
/// Calculcate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative sum of $$n$$ elements.
/// That is, $$n$$ is the length of the list and $$x_i \in \mathbb{Z}$$ is the value in the input list indexed by $$i$$. 
/// The value $$v_j$$ is thus the sum of the $$1$$ to $$j$$ first elements in the given list.
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
/// Calculcate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative product of $$n$$ elements.
/// That is, $$n$$ is the length of the list and $$x_i \in \mathbb{R}$$ is the value in the input list indexed by $$i$$. 
/// The value $$v_j$$ is thus the sum of the $$1$$ to $$j$$ first elements in the given list.
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
pub fn float_cumumlative_product(arr: List(Float)) -> List(Float) {
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
/// Calculcate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, $$v_j$$ is the $$j$$'th element in the cumulative product of $$n$$ elements.
/// That is, $$n$$ is the length of the list and $$x_i \in \mathbb{Z}$$ is the value in the input list indexed by $$i$$. 
/// The value $$v_j$$ is thus the product of the $$1$$ to $$j$$ first elements in the given list.
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
