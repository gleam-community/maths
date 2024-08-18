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
//// Combinatorics: A module that offers mathematical functions related to counting, arrangements,
//// and permutations/combinations.
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
/// A combinatorial function for computing the number of \\(k\\)-combinations of \\(n\\) elements.
///
/// **Without Repetitions:**
///
/// \\[
/// C(n, k) = \binom{n}{k} = \frac{n!}{k! (n-k)!}
/// \\]
/// Also known as "\\(n\\) choose \\(k\\)" or the binomial coefficient.
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
///
/// A \\(k\\)-combination is a sequence of \\(k\\) elements selected from \\(n\\) elements where
/// the order of selection does not matter. For example, consider selecting 2 elements from a list
/// of 3 elements: `["A", "B", "C"]`:
///
/// - For \\(k\\)-combinations (without repetitions), where order does not matter, the possible
///   selections are:
///   - `["A", "B"]`
///   - `["A", "C"]`
///   - `["B", "C"]`
///
/// - For \\(k\\)-combinations (with repetitions), where order does not matter but elements can
///   repeat, the possible selections are:
///   - `["A", "A"], ["A", "B"], ["A", "C"]`
///   - `["B", "B"], ["B", "C"], ["C", "C"]`
///
/// - On the contrary, for \\(k\\)-permutations (without repetitions), the order matters, so the
///   possible selections are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
/// </details>
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/option
///     import gleeunit/should
///     import gleam_community/maths/combinatorics
///
///     pub fn example() {
///       // Invalid input gives an error
///       combinatorics.combination(-1, 1, option.None)
///       |> should.be_error()
///
///       // Valid input: n = 4 and k = 0
///       combinatorics.combination(4, 0, option.Some(combinatorics.WithoutRepetitions))
///       |> should.equal(Ok(1))
///
///       // Valid input: k = n (n = 4, k = 4)
///       combinatorics.combination(4, 4, option.Some(combinatorics.WithoutRepetitions))
///       |> should.equal(Ok(1))
///
///       // Valid input: combinations with repetition (n = 2, k = 3)
///       combinatorics.combination(2, 3, option.Some(combinatorics.WithRepetitions))
///       |> should.equal(Ok(4))
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
  case n, k {
    _, _ if n < 0 ->
      "Invalid input argument: n < 0. Valid input is n >= 0." |> Error
    _, _ if k < 0 ->
      "Invalid input argument: k < 0. Valid input is k >= 0." |> Error
    _, _ -> {
      case mode {
        option.Some(WithRepetitions) -> combination_with_repetitions(n, k)
        _ -> combination_without_repetitions(n, k)
      }
    }
  }
}

fn combination_with_repetitions(n: Int, k: Int) -> Result(Int, String) {
  { n + k - 1 }
  |> combination_without_repetitions(k)
}

fn combination_without_repetitions(n: Int, k: Int) -> Result(Int, String) {
  case n, k {
    _, _ if k == 0 || k == n -> {
      1 |> Ok
    }
    _, _ -> {
      let min = case k < n - k {
        True -> k
        False -> n - k
      }
      list.range(1, min)
      |> list.fold(1, fn(acc, x) { acc * { n + 1 - x } / x })
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
/// A combinatorial function for computing the total number of combinations of \\(n\\)
/// elements, that is \\(n!\\).
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
///       // Valid input returns a result (n = 0)
///       combinatorics.factorial(0)
///       |> should.equal(Ok(1))
///
///       combinatorics.factorial(3)
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
pub fn factorial(n) -> Result(Int, String) {
  case n {
    _ if n < 0 ->
      "Invalid input argument: n < 0. Valid input is n >= 0."
      |> Error
    0 ->
      1
      |> Ok
    1 ->
      1
      |> Ok
    _ ->
      list.range(1, n)
      |> list.fold(1, fn(acc, x) { acc * x })
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the number of \\(k\\)-permutations.
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
/// The implementation uses an efficient iterative multiplicative formula for computing the result.
///
/// <details>
/// <summary>Details</summary>
///
/// A \\(k\\)-permutation (without repetitions) is a sequence of \\(k\\) elements selected from \
/// \\(n\\) elements where the order of selection matters. For example, consider selecting 2
/// elements from a list of 3 elements: `["A", "B", "C"]`:
///
/// - For \\(k\\)-permutations (without repetitions), the order matters, so the possible selections
/// are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
///
/// - For \\(k\\)-permutations (with repetitions), the order also matters, but we have repeated
///   selections:
///   - `["A", "A"], ["A", "B"], ["A", "C"]`
///   - `["B", "A"], ["B", "B"], ["B", "C"]`
///   - `["C", "A"], ["C", "B"], ["C", "C"]`
///
/// - On the contrary, for \\(k\\)-combinations (without repetitions), where order does not matter,
///   the possible selections are:
///   - `["A", "B"]`
///   - `["A", "C"]`
///   - `["B", "C"]`
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/option
///     import gleeunit/should
///     import gleam_community/maths/combinatorics
///
///     pub fn example() {
///       // Invalid input gives an error
///       combinatorics.permutation(-1, 1, option.None)
///       |> should.be_error()
///
///       // Valid input returns a result (n = 4, k = 0)
///       combinatorics.permutation(4, 0, option.Some(combinatorics.WithoutRepetitions))
///       |> should.equal(Ok(1))
///
///       // Valid input returns the correct number of permutations (n = 4, k = 2)
///       combinatorics.permutation(4, 2, option.Some(combinatorics.WithoutRepetitions))
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
  case n, k {
    _, _ if n < 0 ->
      "Invalid input argument: n < 0. Valid input is n >= 0." |> Error
    _, _ if k < 0 ->
      "Invalid input argument: k < 0. Valid input is k >= 0." |> Error
    _, _ -> {
      case mode {
        option.Some(WithRepetitions) -> permutation_with_repetitions(n, k)
        _ -> permutation_without_repetitions(n, k)
      }
    }
  }
}

fn permutation_without_repetitions(n: Int, k: Int) -> Result(Int, String) {
  case n, k {
    _, _ if k < 0 || k > n -> {
      0 |> Ok
    }
    _, _ if k == 0 -> {
      1 |> Ok
    }
    _, _ ->
      list.range(0, k - 1)
      |> list.fold(1, fn(acc, x) { acc * { n - x } })
      |> Ok
  }
}

fn permutation_with_repetitions(n: Int, k: Int) -> Result(Int, String) {
  let n_float = conversion.int_to_float(n)
  let k_float = conversion.int_to_float(k)
  // 'n' ank 'k' are positive integers, so no errors here...
  let assert Ok(result) = elementary.power(n_float, k_float)
  result
  |> conversion.float_to_int()
  |> Ok
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generates all possible combinations of \\(k\\) elements selected from a given list of size
/// \\(n\\).
///
/// The function can handle cases with and without repetitions
/// (see more details [here](#combination)). Also, note that repeated elements are treated as
/// distinct.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleam/option
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths/combinatorics
///
///     pub fn example () {
///       // Generate all 3-combinations without repetition
///       let assert Ok(result) =
///         combinatorics.list_combination(
///           [1, 2, 3, 4],
///           3,
///           option.Some(combinatorics.WithoutRepetitions),
///         )
///
///       result
///       |> iterator.to_list()
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
  mode: option.Option(CombinatoricsMode),
) -> Result(iterator.Iterator(List(a)), String) {
  case k {
    _ if k < 0 ->
      "Invalid input argument: k < 0. Valid input is k >= 0."
      |> Error
    _ ->
      case mode {
        option.Some(WithRepetitions) ->
          list_combination_with_repetitions(arr, k)
        _ -> list_combination_without_repetitions(arr, k)
      }
  }
}

fn list_combination_without_repetitions(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), String) {
  case k, list.length(arr) {
    _, arr_length if k > arr_length -> {
      "Invalid input argument: k > length(arr). Valid input is 0 <= k <= length(arr)."
      |> Error
    }
    // Special case: When k = n, then the entire list is the only valid combination
    _, arr_length if k == arr_length -> {
      iterator.single(arr) |> Ok
    }
    _, _ -> {
      Ok(
        do_list_combination_without_repetitions(iterator.from_list(arr), k, []),
      )
    }
  }
}

fn do_list_combination_without_repetitions(
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
          let with_x =
            do_list_combination_without_repetitions(xs, k - 1, [x, ..prefix])
          let without_x = do_list_combination_without_repetitions(xs, k, prefix)
          iterator.concat([with_x, without_x])
        }
      }
  }
}

fn list_combination_with_repetitions(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), String) {
  Ok(do_list_combination_with_repetitions(iterator.from_list(arr), k, []))
}

fn do_list_combination_with_repetitions(
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
          let with_x =
            do_list_combination_with_repetitions(arr, k - 1, [x, ..prefix])
          let without_x = do_list_combination_with_repetitions(xs, k, prefix)
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
/// Generates all possible permutations of \\(k\\) elements selected from a given list of size
/// \\(n\\).
///
/// The function can handle cases with and without repetitions
/// (see more details [here](#permutation)). Also, note that repeated elements are treated as
/// distinct.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleam/option
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths/combinatorics
///
///     pub fn example () {
///       // Generate all 3-permutations without repetition
///       let assert Ok(result) =
///         combinatorics.list_permutation(
///           [1, 2, 3],
///           3,
///           option.Some(combinatorics.WithoutRepetitions),
///         )
///
///       result
///       |> iterator.to_list()
///       |> set.from_list()
///       |> should.equal(
///         set.from_list([
///           [1, 2, 3],
///           [2, 1, 3],
///           [3, 1, 2],
///           [1, 3, 2],
///           [2, 3, 1],
///           [3, 2, 1],
///         ]),
///       )
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
///
pub fn list_permutation(
  arr: List(a),
  k: Int,
  mode: option.Option(CombinatoricsMode),
) -> Result(iterator.Iterator(List(a)), String) {
  case k {
    _ if k < 0 ->
      "Invalid input argument: k < 0. Valid input is k >= 0."
      |> Error
    _ ->
      case mode {
        option.Some(WithRepetitions) ->
          list_permutation_with_repetitions(arr, k)
        _ -> list_permutation_without_repetitions(arr, k)
      }
  }
}

fn remove_first_by_index(
  arr: iterator.Iterator(#(Int, a)),
  index_to_remove: Int,
) -> iterator.Iterator(#(Int, a)) {
  iterator.flat_map(arr, fn(arg) {
    let #(index, element) = arg
    case index == index_to_remove {
      True -> iterator.empty()
      False -> iterator.single(#(index, element))
    }
  })
}

fn list_permutation_without_repetitions(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), String) {
  case k, list.length(arr) {
    _, arr_length if k > arr_length -> {
      "Invalid input argument: k > length(arr). Valid input is 0 <= k <= length(arr)."
      |> Error
    }
    _, _ -> {
      let indexed_arr = list.index_map(arr, fn(x, i) { #(i, x) })
      Ok(do_list_permutation_without_repetitions(
        iterator.from_list(indexed_arr),
        k,
      ))
    }
  }
}

fn do_list_permutation_without_repetitions(
  arr: iterator.Iterator(#(Int, a)),
  k: Int,
) -> iterator.Iterator(List(a)) {
  case k {
    0 -> iterator.single([])
    _ ->
      iterator.flat_map(arr, fn(arg) {
        let #(index, element) = arg
        let remaining = remove_first_by_index(arr, index)
        let permutations =
          do_list_permutation_without_repetitions(remaining, k - 1)
        iterator.map(permutations, fn(permutation) { [element, ..permutation] })
      })
  }
}

fn list_permutation_with_repetitions(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), String) {
  let indexed_arr = list.index_map(arr, fn(x, i) { #(i, x) })
  Ok(do_list_permutation_with_repetitions(indexed_arr, k))
}

fn do_list_permutation_with_repetitions(
  arr: List(#(Int, a)),
  k: Int,
) -> iterator.Iterator(List(a)) {
  case k {
    0 -> iterator.single([])
    _ ->
      iterator.flat_map(arr |> iterator.from_list, fn(arg) {
        let #(_, element) = arg
        // Allow the same element (by index) to be reused in future recursive calls
        let permutations = do_list_permutation_with_repetitions(arr, k - 1)
        // Prepend the current element to each generated permutation
        iterator.map(permutations, fn(permutation) { [element, ..permutation] })
      })
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
///     import gleam/set
///     import gleeunit/should
///     import gleam_community/maths/combinatorics
///
///     pub fn example () {
///       // Cartesian product of two empty sets
///       set.from_list([])
///       |> combinatorics.cartesian_product(set.from_list([]))
///       |> should.equal(set.from_list([]))
///
///       // Cartesian product of two sets with numeric values
///       set.from_list([1.0, 10.0])
///       |> combinatorics.cartesian_product(set.from_list([1.0, 2.0]))
///       |> should.equal(
///         set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)]),
///       )
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cartesian_product(xset: set.Set(a), yset: set.Set(a)) -> set.Set(#(a, a)) {
  xset
  |> set.fold(set.new(), fn(accumulator0: set.Set(#(a, a)), member0: a) {
    set.fold(yset, accumulator0, fn(accumulator1: set.Set(#(a, a)), member1: a) {
      set.insert(accumulator1, #(member0, member1))
    })
  })
}
