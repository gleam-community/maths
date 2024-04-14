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
//// Special: A module containing special mathematical functions.
//// 
//// * **Special mathematical functions**
////   * [`beta`](#beta)
////   * [`erf`](#erf)
////   * [`gamma`](#gamma)
////   * [`incomplete_gamma`](#incomplete_gamma)
//// 

import gleam_community/maths/conversion
import gleam_community/maths/elementary
import gleam_community/maths/piecewise
import gleam/list

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
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
///     <a href="https://github.com/gleam-community/maths/issues">
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
  let assert [a1, a2, a3, a4, a5]: List(Float) = [
    0.254829592, -0.284496736, 1.421413741, -1.453152027, 1.061405429,
  ]
  let p: Float = 0.3275911

  let sign: Float = piecewise.float_sign(x)
  let x: Float = piecewise.float_absolute_value(x)

  // Formula 7.1.26 given in Abramowitz and Stegun.
  let t: Float = 1.0 /. { 1.0 +. p *. x }
  let y: Float =
    1.0
    -. { { { { a5 *. t +. a4 } *. t +. a3 } *. t +. a2 } *. t +. a1 }
    *. t
    *. elementary.exponential(-1.0 *. x *. x)
  sign *. y
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The gamma function over the real numbers. The function is essentially equal to 
/// the factorial for any positive integer argument: $$\Gamma(n) = (n - 1)!$$
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
    True ->
      elementary.pi()
      /. { elementary.sin(elementary.pi() *. x) *. gamma_lanczos(1.0 -. x) }
    False -> {
      let z = x -. 1.0
      let x: Float =
        list.index_fold(lanczos_p, 0.0, fn(acc: Float, v: Float, index: Int) {
          case index > 0 {
            True -> acc +. v /. { z +. conversion.int_to_float(index) }
            False -> v
          }
        })
      let t: Float = z +. lanczos_g +. 0.5
      let assert Ok(v1) = elementary.power(2.0 *. elementary.pi(), 0.5)
      let assert Ok(v2) = elementary.power(t, z +. 0.5)
      v1 *. v2 *. elementary.exponential(-1.0 *. t) *. x
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
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
pub fn incomplete_gamma(a: Float, x: Float) -> Result(Float, String) {
  case a >. 0.0 && x >=. 0.0 {
    True -> {
      let assert Ok(v) = elementary.power(x, a)
      v
      *. elementary.exponential(-1.0 *. x)
      *. incomplete_gamma_sum(a, x, 1.0 /. a, 0.0, 1.0)
      |> Ok
    }

    False ->
      "Invalid input argument: a <= 0 or x < 0. Valid input is a > 0 and x >= 0."
      |> Error
  }
}

fn incomplete_gamma_sum(
  a: Float,
  x: Float,
  t: Float,
  s: Float,
  n: Float,
) -> Float {
  case t {
    0.0 -> s
    _ -> {
      let ns: Float = s +. t
      let nt: Float = t *. { x /. { a +. n } }
      incomplete_gamma_sum(a, x, nt, ns, n +. 1.0)
    }
  }
}
