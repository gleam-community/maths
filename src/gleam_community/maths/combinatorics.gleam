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
//// Combinatorics: A module that offers mathematical functions related to counting, arrangements, and combinations. 
//// 
//// * **Combinatorial functions**
////   * [`combination`](#combination)
////   * [`factorial`](#factorial)
////   * [`permutation`](#permutation)
////   * [`list_combination`](#list_combination)
////   * [`list_permutation`](#list_permutation)
////   * [`cartesian_product`](#cartesian_product)
//// 

import gleam/list
import gleam/set

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
///     import gleam_community/maths/combinatorics
///
///     pub fn example() {
///       // Invalid input gives an error
///       // Error on: n = -1 < 0
///       combinatorics.combination(-1, 1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       combinatorics.combination(4, 0)
///       |> should.equal(Ok(1))
///
///       combinatorics.combination(4, 4)
///       |> should.equal(Ok(1))
///
///       combinatorics.combination(4, 2)
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
              |> list.fold(1, fn(acc: Int, x: Int) -> Int {
                acc * { n + 1 - x } / x
              })
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
///     import gleam_community/maths/combinatorics
///
///     pub fn example() {
///       // Invalid input gives an error
///       combinatorics.factorial(-1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       combinatorics.factorial(0)
///       |> should.equal(Ok(1))
/// 
///       combinatorics.factorial(1)
///       |> should.equal(Ok(1))
/// 
///       combinatorics.factorial(2)
///       |> should.equal(Ok(2))
/// 
///       combinatorics.factorial(3)
///       |> should.equal(Ok(6))
/// 
///       combinatorics.factorial(4)
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
///     import gleam_community/maths/combinatorics
///
///     pub fn example() {
///       // Invalid input gives an error
///       // Error on: n = -1 < 0
///       combinatorics.permutation(-1, 1)
///       |> should.be_error()
///
///       // Valid input returns a result
///       combinatorics.permutation(4, 0)
///       |> should.equal(Ok(1))
///
///       combinatorics.permutation(4, 4)
///       |> should.equal(Ok(1))
///
///       combinatorics.permutation(4, 2)
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
              let assert Ok(v1) = factorial(n)
              let assert Ok(v2) = factorial(n - k)
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
/// Generate all $$k$$-combinations based on a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/set
///     import gleam_community/maths/combinatorics
///
///     pub fn example () {
///       let assert Ok(result) = combinatorics.list_combination([1, 2, 3, 4], 3)
///       result
///       |> set.from_list()
///       |> should.equal(set.from_list([[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn list_combination(arr: List(a), k: Int) -> Result(List(List(a)), String) {
  case k < 0 {
    True ->
      "Invalid input argument: k < 0. Valid input is k > 0."
      |> Error
    False -> {
      case k > list.length(arr) {
        True ->
          "Invalid input argument: k > length(arr). Valid input is 0 < k <= length(arr)."
          |> Error
        False -> {
          do_list_combination(arr, k, [])
          |> Ok
        }
      }
    }
  }
}

fn do_list_combination(arr: List(a), k: Int, prefix: List(a)) -> List(List(a)) {
  case k {
    0 -> [list.reverse(prefix)]
    _ ->
      case arr {
        [] -> []
        [x, ..xs] -> {
          let with_x = do_list_combination(xs, k - 1, [x, ..prefix])
          let without_x = do_list_combination(xs, k, prefix)
          list.append(with_x, without_x)
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
/// Generate all permutations of a given list.
///
/// Repeated elements are treated as distinct for the
/// purpose of permutations, so two identical elements
/// for example will appear "both ways round". This
/// means lists with repeated elements return the same
/// number of permutations as ones without.
///
/// N.B. The output of this function is a list of size
/// factorial in the size of the input list. Caution is
/// advised on input lists longer than ~11 elements, which
/// may cause the VM to use unholy amounts of memory for
/// the output.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/set
///     import gleam_community/maths/combinatorics
///
///     pub fn example () {
///       [1, 2, 3]
///       |> combinatorics.list_permutation()
///       |> set.from_list()
///       |> should.equal(set.from_list([
///         [1, 2, 3],
///         [2, 1, 3],
///         [3, 1, 2],
///         [1, 3, 2],
///         [2, 3, 1],
///         [3, 2, 1],
///       ]))
///
///       [1.0, 1.0]
///       |> combinatorics.list_permutation()
///       |> should.equal([[1.0, 1.0], [1.0, 1.0]])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn list_permutation(arr: List(a)) -> List(List(a)) {
  case arr {
    [] -> [[]]
    _ -> {
      use x <- list.flat_map(arr)
      // `x` is drawn from the list `arr` above,
      // so Ok(...) can be safely asserted as the result of `list.pop` below
      let assert Ok(#(_, remaining)) = list.pop(arr, fn(y) { x == y })
      list.map(list_permutation(remaining), fn(perm) { [x, ..perm] })
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generate a list containing all combinations of pairs of elements coming from two given lists.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam/list
///     import gleam_community/maths/combinatorics
///
///     pub fn example () {
///       []
///       |> combinatorics.cartesian_product([])
///       |> should.equal([])
///     
///       [1.0, 10.0]
///       |> combinatorics.cartesian_product([1.0, 2.0])
///       |> should.equal([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cartesian_product(xarr: List(a), yarr: List(a)) -> List(#(a, a)) {
  let xset: set.Set(a) =
    xarr
    |> set.from_list()
  let yset: set.Set(a) =
    yarr
    |> set.from_list()
  xset
  |> set.fold(
    set.new(),
    fn(accumulator0: set.Set(#(a, a)), member0: a) -> set.Set(#(a, a)) {
      set.fold(
        yset,
        accumulator0,
        fn(accumulator1: set.Set(#(a, a)), member1: a) -> set.Set(#(a, a)) {
          set.insert(accumulator1, #(member0, member1))
        },
      )
    },
  )
  |> set.to_list()
}
