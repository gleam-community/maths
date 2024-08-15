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
//// Combinatorics: A module that offers mathematical functions related to counting, arrangements, 
//// and combinations. 
//// 
//// * **Combinatorial functions**
////   * [`combination`](#combination)
////   * [`factorial`](#factorial)
////   * [`permutation`](#permutation)
////   * [`list_combination`](#list_combination)
////   * [`list_permutation`](#list_permutation)
////   * [`cartesian_product`](#cartesian_product)
//// 

import gleam/iterator
import gleam/list
import gleam/option
import gleam/set
import gleam_community/maths/conversion
import gleam_community/maths/elementary

pub type CombinatoricsMode {
  WithRepetitions
  WithoutRepetitions
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the number of $$k$$-combinations of $$n$$ elements:
///
/// **Without Repetitions:**
///
/// \\[
/// C(n, k) = \binom{n}{k} = \frac{n!}{k! (n-k)!}
/// \\]
/// Also known as "$$n$$ choose $$k$$" or the binomial coefficient.
///
/// **With Repetitions:**
///
/// \\[
/// C^*(n, k) = \binom{n + k - 1}{k} = \frac{(n + k - 1)!}{k! (n - 1)!}
/// \\]
/// Also known as the "stars and bars" problem in combinatorics.
///
/// The implementation uses an efficient iterative multiplicative formula for computing the result.
/// 
/// <details>
/// <summary>Details</summary>
/// A $$k$$-combination is a sequence of $$k$$ elements selected from $$n$$ elements where 
/// the order of selection does not matter. For example, consider selecting 2 elements from a list 
/// of 3 elements: `["A", "B", "C"]`:
/// 
/// - For $$k$$-combinations (without repetitions), where order does not matter, the possible 
///   selections are:
///   - ["A", "B"]
///   - ["A", "C"]
///   - ["B", "C"]
///
/// - For $$k$$-combinations (with repetitions), where order does not matter but elements can 
///   repeat, the possible selections are:
///   - ["A", "A"], ["A", "B"], ["A", "C"]
///   - ["B", "B"], ["B", "C"], ["C", "C"]
///
/// - On the contrary, for $$k$$-permutations, the order matters, so the possible selections are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
/// </details>
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
pub fn combination(
  n: Int,
  k: Int,
  mode: option.Option(CombinatoricsMode),
) -> Result(Int, String) {
  case mode {
    option.Some(WithRepetitions) -> combination_with_repetitions(n, k)
    _ -> combination_without_repetitions(n, k)
  }
}

fn combination_without_repetitions(n: Int, k: Int) -> Result(Int, String) {
  case n < 0 || k < 0 || k > n {
    True -> "Invalid input: Ensure n >= 0, k >= 0, and k <= n." |> Error
    False ->
      case k == 0 || k == n {
        True -> 1 |> Ok
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

fn combination_with_repetitions(n: Int, k: Int) -> Result(Int, String) {
  case n < 0 {
    True -> "Invalid input argument: n < 0. Valid input is n >= 0 " |> Error
    False -> {
      case k < 0 {
        True -> "Invalid input argument: k < 0. Valid input is k >= 0 " |> Error
        False -> {
          { n + k - 1 }
          |> combination_without_repetitions(k)
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
      "Invalid input argument: n < 0. Valid input is n >= 0."
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
          |> list.fold(1, fn(acc: Int, x: Int) -> Int { acc * x })
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
/// A combinatorial function for computing the number of $$k$$-permutations (without and without
/// repetitions) of $$n$$ elements.
/// 
/// **Without** repetitions:
///
/// \\[
/// P(n, k) = \binom{n}{k} \cdot k! = \frac{n!}{(n - k)!}
/// \\]
/// 
/// **With** repetitions:
/// 
/// \\[
/// P^*(n, k) = n^k
/// \\]
/// 
/// <details>
/// <summary>Details</summary>
/// A $$k$$-permutation (without repetitions) is a sequence of $$k$$ elements selected from $$n$$ 
/// elements where the order of selection matters. For example, consider selecting 2 elements from 
/// a list of 3 elements: `["A", "B", "C"]`:
/// 
/// - For $$k$$-permutations (without repetitions), the order matters, so the possible selections 
/// are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
/// 
/// - For $$k$$-permutations (with repetitions), the order also matters, but we have repeated 
///   selections:
///   - ["A", "A"], ["A", "B"], ["A", "C"]
///   - ["B", "A"], ["B", "B"], ["B", "C"]
///   - ["C", "A"], ["C", "B"], ["C", "C"]
///
/// - On the contrary, for $$k$$-combinations, where order does not matter, the possible selections
///   are:
///   - ["A", "B"]
///   - ["A", "C"]
///   - ["B", "C"]
/// </details>
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
pub fn permutation(
  n: Int,
  k: Int,
  mode: option.Option(CombinatoricsMode),
) -> Result(Int, String) {
  case mode {
    option.Some(WithRepetitions) -> permutation_with_repetitions(n, k)
    _ -> permutation_without_repetitions(n, k)
  }
}

fn permutation_without_repetitions(n: Int, k: Int) -> Result(Int, String) {
  case n < 0 {
    True ->
      "Invalid input argument: n < 0. Valid input is n >= 0."
      |> Error
    False ->
      case k < 0 || k > n {
        True ->
          0
          |> Ok
        False ->
          case k == 0 {
            True -> 1 |> Ok
            False ->
              list.range(0, k - 1)
              |> list.fold(1, fn(acc: Int, x: Int) -> Int { acc * { n - x } })
              |> Ok
          }
      }
  }
}

fn permutation_with_repetitions(n: Int, k: Int) -> Result(Int, String) {
  case n < 0 {
    True ->
      "Invalid input argument: n < 0. Valid input is n >= 0."
      |> Error
    False ->
      case k < 0 {
        True ->
          "Invalid input argument: k < 0. Valid input is k >= 0."
          |> Error
        False -> {
          let n_float = conversion.int_to_float(n)
          let k_float = conversion.int_to_float(k)
          let assert Ok(result) = elementary.power(n_float, k_float)
          result
          |> conversion.float_to_int()
          |> Ok
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
pub fn list_combination(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), String) {
  case k < 0 {
    True -> Error("Invalid input argument: k < 0. Valid input is k >= 0.")
    False -> {
      case k > list.length(arr) {
        True ->
          Error(
            "Invalid input argument: k > length(arr). Valid input is 0 <= k <= length(arr).",
          )
        False -> Ok(do_list_combination(iterator.from_list(arr), k, []))
      }
    }
  }
}

fn do_list_combination(
  arr: iterator.Iterator(a),
  k: Int,
  prefix: List(a),
) -> iterator.Iterator(List(a)) {
  case k {
    0 -> iterator.single(list.reverse(prefix))
    _ ->
      case arr |> iterator.step {
        iterator.Done -> iterator.empty()
        iterator.Next(x, xs) -> {
          let with_x = do_list_combination(xs, k - 1, [x, ..prefix])
          let without_x = do_list_combination(xs, k, prefix)
          iterator.concat([with_x, without_x])
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
pub fn list_permutation(arr: List(a)) -> iterator.Iterator(List(a)) {
  case arr {
    [] -> iterator.single([])
    _ ->
      iterator.from_list(arr)
      // Iterate over each element in the list 'arr' to generate permutations for each possible 
      // starting element 'x'.
      |> iterator.flat_map(fn(x) {
        // For each element 'x', we remove it from the list. This will gives us the remaining list
        // that contains all elements except 'x'.
        let remaining = remove_first(arr, x)
        // Recursively call 'list_permutation' on the remaining list to generate all permutations
        // of the smaller list.
        let permutations = list_permutation(remaining)
        // For each permutation generated by the recursive call, we prepend the element 'x' back to
        // the front of the permutation.
        iterator.map(permutations, fn(permutation) { [x, ..permutation] })
      })
  }
}

fn remove_first(list: List(a), x: a) -> List(a) {
  case list {
    [] -> []
    [head, ..tail] ->
      case head == x {
        True -> tail
        False -> [head, ..remove_first(tail, x)]
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
