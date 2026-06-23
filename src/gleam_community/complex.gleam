//// <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css" integrity="sha384-5TcZemv2l/9On385z///+d7MSYlvIEw9FuZTIdZ14vJLqWphw7e7ZPuOiCHJcFCP" crossorigin="anonymous">
//// <script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.js" integrity="sha384-cMkvdD8LoxVzGF/RPUKAcvmm49FQ0oxwDF3BGKtDXcEc+T1b2N+teh/OJfpU0jr6" crossorigin="anonymous"></script>
//// <script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/contrib/auto-render.min.js" integrity="sha384-hCXGrW6PitJEwbkoStFjeJxv+fSOOQKOPbJxSfM6G5sWZjAyWhXiTIIAmQqnlLlh" crossorigin="anonymous"></script>
//// <script>
////   document.addEventListener("DOMContentLoaded", function() {
////     renderMathInElement(document.body, {
////       delimiters: [
////         {left: '$$', right: '$$', display: false},
////         {left: '$', right: '$', display: false},
////         {left: '\\(', right: '\\)', display: false},
////         {left: '\\[', right: '\\]', display: true}
////       ],
////       throwOnError : true
////     });
////   });
//// </script>
//// <style>
////   .katex { font-size: 1.10em; }
//// </style>
////
//// Functions for working with complex numbers.
////
//// A complex number is represented by a real component and an imaginary
//// component:
////
//// \\[
//// z = a + bi
//// \\]
////
//// where \\(a, b \in \mathbb{R}\\) and \\(i^2 = -1\\). Functions that use
//// logarithms, roots, powers, or inverse trigonometric functions return the
//// principal value unless otherwise specified.

import gleam/float
import gleam/int
import gleam/list
import gleam/order.{type Order, Eq, Gt, Lt}
import gleam/result
import gleam_community/maths

/// A complex number with real and imaginary components.
///
/// The value `Complex(3.0, 4.0)` represents \\(3 + 4i\\).
///
pub type Complex {
  Complex(real: Float, imaginary: Float)
}

/// Add two complex numbers:
///
/// \\[
/// (a + bi) + (c + di) = (a + c) + (b + d)i
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.add(complex.Complex(1.0, 2.0), complex.Complex(3.0, 4.0))
///   |> should.equal(complex.Complex(4.0, 6.0))
/// }
/// ```
///
/// </details>
///
pub fn add(a: Complex, b: Complex) -> Complex {
  Complex(a.real +. b.real, a.imaginary +. b.imaginary)
}

/// Subtract one complex number from another:
///
/// \\[
/// (a + bi) - (c + di) = (a - c) + (b - d)i
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.subtract(complex.Complex(5.0, 7.0), complex.Complex(2.0, 3.0))
///   |> should.equal(complex.Complex(3.0, 4.0))
/// }
/// ```
///
/// </details>
///
pub fn subtract(a: Complex, b: Complex) -> Complex {
  Complex(a.real -. b.real, a.imaginary -. b.imaginary)
}

/// Multiply two complex numbers:
///
/// \\[
/// (a + bi)(c + di) = (ac - bd) + (ad + bc)i
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.multiply(complex.Complex(1.0, 2.0), complex.Complex(3.0, 4.0))
///   |> should.equal(complex.Complex(-5.0, 10.0))
/// }
/// ```
///
/// </details>
///
pub fn multiply(a: Complex, b: Complex) -> Complex {
  Complex(
    a.real *. b.real -. a.imaginary *. b.imaginary,
    a.real *. b.imaginary +. a.imaginary *. b.real,
  )
}

/// Divide one complex number by another:
///
/// \\[
/// \begin{aligned}
/// \frac{a + bi}{c + di}
/// &= \frac{ac + bd}{c^2 + d^2} + \frac{bc - ad}{c^2 + d^2}i
/// \end{aligned}
/// \\]
///
/// This function follows the library's total division convention: if the
/// denominator is zero, the result is `zero()`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.divide(complex.Complex(1.0, 2.0), complex.Complex(3.0, 4.0))
///   |> complex.is_close(complex.Complex(0.44, 0.08), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn divide(a: Complex, b: Complex) -> Complex {
  let denominator = b.real *. b.real +. b.imaginary *. b.imaginary

  case denominator == 0.0 {
    True -> zero()
    False ->
      Complex(
        { a.real *. b.real +. a.imaginary *. b.imaginary } /. denominator,
        { a.imaginary *. b.real -. a.real *. b.imaginary } /. denominator,
      )
  }
}

/// Return the absolute value \\(|z|\\):
///
/// \\[
/// |a + bi| = \sqrt{a^2 + b^2}
/// \\]
///
/// This is the distance from \\(z\\) to zero in the complex plane.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.absolute_value(complex.Complex(3.0, 4.0))
///   |> should.equal(5.0)
/// }
/// ```
///
/// </details>
///
pub fn absolute_value(z: Complex) -> Float {
  // This assertion is safe because a sum of squares is non-negative.
  let assert Ok(result) =
    float.square_root(z.real *. z.real +. z.imaginary *. z.imaginary)
  result
}

/// Return the principal argument of \\(z\\) in radians:
///
/// \\[
/// \arg(a + bi) = \operatorname{atan2}(b, a)
/// \\]
///
/// The result lies in the range \\(\[-\pi, \pi\]\\). The argument of zero is
/// returned as \\(0\\).
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
/// import gleam_community/maths
///
/// pub fn example() {
///   complex.argument(complex.Complex(0.0, 1.0))
///   |> should.equal(maths.pi() /. 2.0)
/// }
/// ```
///
/// </details>
///
pub fn argument(z: Complex) -> Float {
  maths.atan2(z.imaginary, z.real)
}

/// Convert a float to a complex number with no imaginary component:
///
/// \\[
/// x \mapsto x + 0i
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.from_float(2.0)
///   |> should.equal(complex.Complex(2.0, 0.0))
/// }
/// ```
///
/// </details>
///
pub fn from_float(real: Float) -> Complex {
  Complex(real, 0.0)
}

/// Create a complex number from polar coordinates:
///
/// \\[
/// r(\cos(\phi) + i\sin(\phi))
/// \\]
///
/// The value \\(r\\) is the distance from zero and \\(\phi\\) is the angle in radians.
/// This function is equivalent to calling `maths.polar_to_cartesian(r, phi)`
/// and constructing a complex value from the returned coordinates.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
/// import gleam_community/maths
///
/// pub fn example() {
///   complex.from_polar(1.0, maths.pi() /. 2.0)
///   |> complex.is_close(complex.imaginary_unit(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn from_polar(r: Float, phi: Float) -> Complex {
  case r >=. 0.0 && r <=. 0.0 {
    True -> zero()
    False -> {
      let #(real, imaginary) = maths.polar_to_cartesian(r, phi)

      Complex(real, imaginary)
    }
  }
}

/// Convert \\(z\\) to polar coordinates:
///
/// \\[
/// a + bi \mapsto (|a + bi|, \arg(a + bi))
/// \\]
///
/// The returned tuple is `#(r, phi)`, where \\(r\\) is the absolute value and
/// \\(\phi\\) is the principal argument in radians. This function is equivalent to calling
/// `maths.cartesian_to_polar(z.real, z.imaginary)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
/// import gleam_community/maths
///
/// pub fn example() {
///   let #(r, phi) = complex.to_polar(complex.Complex(0.0, 1.0))
///   r
///   |> maths.is_close(1.0, 0.0, 0.0000001)
///   |> should.be_true()
///   phi
///   |> maths.is_close(maths.pi() /. 2.0, 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn to_polar(z: Complex) -> #(Float, Float) {
  maths.cartesian_to_polar(z.real, z.imaginary)
}

/// Return the complex exponential of \\(z\\):
///
/// \\[
/// e^{a + bi} = e^a(\cos(b) + i\sin(b))
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.exponential(complex.zero())
///   |> should.equal(complex.one())
/// }
/// ```
///
/// </details>
///
pub fn exponential(z: Complex) -> Complex {
  from_polar(maths.exponential(z.real), z.imaginary)
}

/// Return the reciprocal of \\(z\\):
///
/// \\[
/// \frac{1}{a + bi} = \frac{a}{a^2 + b^2} - \frac{b}{a^2 + b^2}i
/// \\]
///
/// This function follows the library's total division convention: the
/// reciprocal of zero is `zero()`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.reciprocal(complex.Complex(2.0, 0.0))
///   |> should.equal(complex.Complex(0.5, 0.0))
/// }
/// ```
///
/// </details>
///
pub fn reciprocal(z: Complex) -> Complex {
  let divisor = z.real *. z.real +. z.imaginary *. z.imaginary

  case divisor == 0.0 {
    True -> zero()
    False -> Complex(z.real /. divisor, 0.0 -. z.imaginary /. divisor)
  }
}

/// Raise \\(z\\) to a complex exponent.
///
/// For non-zero \\(z\\), this function uses the principal logarithm:
///
/// \\[
/// z^w = e^{w \operatorname{Log}(z)}
/// \\]
///
/// Complex powers are generally multi-valued. This function returns the
/// principal value for non-zero bases.
///
/// If \\(z = 0\\), the logarithm is not evaluated. Zero raised to a positive
/// real exponent returns `Ok(zero())`. Zero raised to a zero, negative, or
/// non-real exponent is undefined and returns `Error(Nil)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) =
///     complex.power(complex.Complex(2.0, 0.0), complex.Complex(3.0, 0.0))
///   result
///   |> complex.is_close(complex.Complex(8.0, 0.0), 0.0, 0.0000001)
///   |> should.be_true()
///
///   complex.power(complex.zero(), complex.zero())
///   |> should.be_error()
/// }
/// ```
///
/// </details>
///
pub fn power(z: Complex, exponent: Complex) -> Result(Complex, Nil) {
  case is_zero(z), exponent.imaginary == 0.0, exponent.real >. 0.0 {
    True, True, True -> Ok(zero())
    True, _, _ -> Error(Nil)
    False, _, _ -> {
      use log_z <- result.try(natural_logarithm(z))

      Ok(exponential(multiply(exponent, log_z)))
    }
  }
}

/// Raise \\(z\\) to a real-valued exponent.
///
/// For non-zero \\(z\\), this function uses the principal logarithm:
///
/// \\[
/// z^p = e^{p \operatorname{Log}(z)}
/// \\]
///
/// Complex powers with non-integer exponents are generally multi-valued. This
/// function returns the principal value. This is equivalent to calling
/// `power(z, from_float(exponent))`.
///
/// If \\(z = 0\\), the logarithm is not evaluated. Positive exponents return
/// `Ok(zero())`. Zero or negative exponents are undefined and return
/// `Error(Nil)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) =
///     complex.power_with_real_exponent(complex.Complex(2.0, 0.0), 3.0)
///   result
///   |> complex.is_close(complex.Complex(8.0, 0.0), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn power_with_real_exponent(
  z: Complex,
  exponent: Float,
) -> Result(Complex, Nil) {
  power(z, from_float(exponent))
}

/// Return the \\(n\\)th roots of \\(z\\).
///
/// For positive \\(n\\) and non-zero \\(z = re^{i\phi}\\), the roots are:
///
/// \\[
/// \sqrt[n]{r}e^{i\frac{\phi + 2\pi k}{n}}
/// \quad \text{for} \quad k = 0, 1, \dots, n - 1
/// \\]
///
/// Positive \\(n\\) values return the \\(n\\) complex roots, except that the roots of
/// zero are returned as `Ok([zero()])`. Zero or negative root degrees are
/// undefined and return `Error(Nil)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.nth_root(complex.zero(), 3)
///   |> should.equal(Ok([complex.zero()]))
///
///   complex.nth_root(complex.one(), 0)
///   |> should.be_error()
/// }
/// ```
///
/// </details>
///
pub fn nth_root(z: Complex, n: Int) -> Result(List(Complex), Nil) {
  case n <= 0, is_zero(z) {
    True, _ -> Error(Nil)
    False, True -> Ok([zero()])
    False, False -> {
      let arg = argument(z)
      let r = absolute_value(z)
      // r and n are always positive -> root is defined
      let assert Ok(new_r) = maths.nth_root(r, n)

      Ok(
        int.range(0, n, [], list.prepend)
        |> list.reverse
        |> list.map(fn(k) {
          from_polar(
            new_r,
            { arg +. 2.0 *. int.to_float(k) *. maths.pi() } /. int.to_float(n),
          )
        }),
      )
    }
  }
}

/// Return the additive identity:
///
/// \\[
/// 0 + 0i
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.zero()
///   |> should.equal(complex.Complex(0.0, 0.0))
/// }
/// ```
///
/// </details>
///
pub fn zero() -> Complex {
  Complex(0.0, 0.0)
}

/// Return the multiplicative identity:
///
/// \\[
/// 1 + 0i
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.one()
///   |> should.equal(complex.Complex(1.0, 0.0))
/// }
/// ```
///
/// </details>
///
pub fn one() -> Complex {
  from_float(1.0)
}

/// Return the imaginary unit:
///
/// \\[
/// i = 0 + 1i
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.imaginary_unit()
///   |> should.equal(complex.Complex(0.0, 1.0))
/// }
/// ```
///
/// </details>
///
pub fn imaginary_unit() -> Complex {
  Complex(0.0, 1.0)
}

fn multiplicative_identity() -> Complex {
  one()
}

fn is_zero(z: Complex) -> Bool {
  z.real == 0.0 && z.imaginary == 0.0
}

fn is_real_tangent_pole(x: Float) -> Bool {
  let periods_from_first_pole = x /. maths.pi() -. 0.5
  !maths.is_fractional(periods_from_first_pole)
}

fn is_complex_tangent_pole(z: Complex) -> Bool {
  z.imaginary == 0.0 && is_real_tangent_pole(z.real)
}

fn is_complex_hyperbolic_tangent_pole(z: Complex) -> Bool {
  z.real == 0.0 && is_real_tangent_pole(z.imaginary)
}

/// Calculate the sum of the elements in a list:
///
/// \\[
/// \sum_{i=1}^n z_i
/// \\]
///
/// The sum of an empty list is `zero()`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   [complex.Complex(1.0, 2.0), complex.Complex(3.0, 4.0)]
///   |> complex.sum()
///   |> should.equal(complex.Complex(4.0, 6.0))
/// }
/// ```
///
/// </details>
///
pub fn sum(arr: List(Complex)) -> Complex {
  list.fold(arr, zero(), add)
}

/// Calculate the product of the elements in a list:
///
/// \\[
/// \prod_{i=1}^n z_i
/// \\]
///
/// The product of an empty list is `one()`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   [complex.Complex(1.0, 2.0), complex.Complex(3.0, 4.0)]
///   |> complex.product()
///   |> should.equal(complex.Complex(-5.0, 10.0))
/// }
/// ```
///
/// </details>
///
pub fn product(arr: List(Complex)) -> Complex {
  list.fold(arr, multiplicative_identity(), multiply)
}

/// Calculate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j z_i \quad \forall j = 1,\dots,n
/// \\]
///
/// The value \\(v_j\\) is the \\(j\\)'th element in the returned list.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   [complex.Complex(1.0, 1.0), complex.Complex(2.0, 2.0)]
///   |> complex.cumulative_sum()
///   |> should.equal([complex.Complex(1.0, 1.0), complex.Complex(3.0, 3.0)])
/// }
/// ```
///
/// </details>
///
pub fn cumulative_sum(arr: List(Complex)) -> List(Complex) {
  list.scan(arr, zero(), add)
}

/// Calculate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j z_i \quad \forall j = 1,\dots,n
/// \\]
///
/// The value \\(v_j\\) is the \\(j\\)'th element in the returned list.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   [complex.Complex(1.0, 1.0), complex.Complex(2.0, 0.0)]
///   |> complex.cumulative_product()
///   |> should.equal([complex.Complex(1.0, 1.0), complex.Complex(2.0, 2.0)])
/// }
/// ```
///
/// </details>
///
pub fn cumulative_product(arr: List(Complex)) -> List(Complex) {
  list.scan(arr, multiplicative_identity(), multiply)
}

/// Return the absolute difference between two complex numbers:
///
/// \\[
/// |z_1 - z_2|
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.absolute_difference(complex.Complex(3.0, 4.0), complex.zero())
///   |> should.equal(5.0)
/// }
/// ```
///
/// </details>
///
pub fn absolute_difference(a: Complex, b: Complex) -> Float {
  absolute_value(subtract(a, b))
}

/// Calculate the arithmetic mean of the elements in a list:
///
/// \\[
/// \bar{z} = \frac{1}{n}\sum_{i=1}^n z_i
/// \\]
///
/// This function returns an error for an empty list.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   [complex.Complex(1.0, 2.0), complex.Complex(3.0, 4.0)]
///   |> complex.mean()
///   |> should.equal(Ok(complex.Complex(2.0, 3.0)))
/// }
/// ```
///
/// </details>
///
pub fn mean(arr: List(Complex)) -> Result(Complex, Nil) {
  case arr {
    [] -> Error(Nil)
    _ ->
      Ok(sum(arr) |> divide(arr |> list.length |> int.to_float |> from_float))
  }
}

/// Determine if \\(x\\) is close to or equivalent to \\(y\\), based on supplied
/// relative \\(r_{tol}\\) and absolute \\(a_{tol}\\) tolerance values.
///
/// The equivalence is determined by:
///
/// \\[
/// |x - y| \leq a_{tol} + r_{tol}|y|
/// \\]
///
/// Negative tolerance values are invalid and return `False`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let value = complex.Complex(1.01, 2.0)
///   let reference = complex.Complex(1.0, 2.0)
///   complex.is_close(value, reference, 0.01, 0.01)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn is_close(x: Complex, y: Complex, rtol: Float, atol: Float) -> Bool {
  case rtol <. 0.0 || atol <. 0.0 {
    True -> False
    False -> {
      let x = absolute_difference(x, y)
      let y = atol +. rtol *. absolute_value(y)
      x <=. y
    }
  }
}

/// Determine if each complex value is close to its corresponding reference
/// value.
///
/// For each pair \\((x_i, y_i)\\), the equivalence is determined by:
///
/// \\[
/// |x_i - y_i| \leq a_{tol} + r_{tol}|y_i|
/// \\]
///
/// This function returns one boolean result for each pair in the input list.
/// Negative tolerance values make each comparison return `False`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   [
///     #(complex.Complex(1.01, 2.0), complex.Complex(1.0, 2.0)),
///     #(complex.Complex(3.0, 4.0), complex.Complex(3.0, 4.0)),
///   ]
///   |> complex.all_close(0.01, 0.01)
///   |> should.equal([True, True])
/// }
/// ```
///
/// </details>
///
pub fn all_close(
  arr: List(#(Complex, Complex)),
  rtol: Float,
  atol: Float,
) -> List(Bool) {
  list.map(arr, fn(tuple) { is_close(tuple.0, tuple.1, rtol, atol) })
}

/// Return the principal natural logarithm of \\(z\\):
///
/// \\[
/// \operatorname{Log}(z) = \ln(|z|) + i\arg(z)
/// \\]
///
/// The natural logarithm of zero is undefined and returns `Error(Nil)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.natural_logarithm(complex.Complex(1.0, 0.0))
///   |> should.equal(Ok(complex.zero()))
///
///   complex.natural_logarithm(complex.zero())
///   |> should.be_error()
/// }
/// ```
///
/// </details>
///
pub fn natural_logarithm(z: Complex) -> Result(Complex, Nil) {
  case is_zero(z) {
    True -> Error(Nil)
    False -> {
      // This assertion is safe because non-zero complex values have positive
      // absolute value.
      let assert Ok(log_r) = maths.natural_logarithm(absolute_value(z))

      Ok(Complex(log_r, argument(z)))
    }
  }
}

/// Return the logarithm of \\(z\\) with the given complex base:
///
/// \\[
/// \log_b(z) = \frac{\operatorname{Log}(z)}{\operatorname{Log}(b)}
/// \\]
///
/// The logarithm is calculated using principal natural logarithms. A zero
/// input, zero base, or base whose principal natural logarithm is zero returns
/// `Error(Nil)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) =
///     complex.logarithm(complex.Complex(8.0, 0.0), complex.Complex(2.0, 0.0))
///   result
///   |> complex.is_close(complex.Complex(3.0, 0.0), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn logarithm(z: Complex, base: Complex) -> Result(Complex, Nil) {
  use log_z <- result.try(natural_logarithm(z))
  use log_base <- result.try(natural_logarithm(base))

  case is_zero(log_base) {
    True -> Error(Nil)
    False -> Ok(divide(log_z, log_base))
  }
}

/// Return the principal base-10 logarithm of \\(z\\):
///
/// \\[
/// \log_{10}(z)
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.logarithm_10(complex.Complex(100.0, 0.0))
///   result
///   |> complex.is_close(complex.Complex(2.0, 0.0), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn logarithm_10(z: Complex) -> Result(Complex, Nil) {
  logarithm(z, from_float(10.0))
}

/// Return the principal square root of \\(z\\).
///
/// This function returns the square root whose argument lies in the principal
/// branch.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.square_root(complex.Complex(-1.0, 0.0))
///   |> complex.is_close(complex.imaginary_unit(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn square_root(z: Complex) -> Complex {
  // This assertion is safe because square roots use a positive real exponent.
  let assert Ok(result) = power_with_real_exponent(z, 0.5)

  result
}

/// Return the sine of \\(z\\):
///
/// \\[
/// \sin(a + bi) = \sin(a)\cosh(b) + i\cos(a)\sinh(b)
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns a complex number in the codomain \\(\mathbb{C}\\). The range
/// is all complex numbers.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.sin(complex.zero())
///   |> should.equal(complex.zero())
/// }
/// ```
///
/// </details>
///
pub fn sin(z: Complex) -> Complex {
  Complex(
    maths.sin(z.real) *. maths.cosh(z.imaginary),
    maths.cos(z.real) *. maths.sinh(z.imaginary),
  )
}

/// Return the cosine of \\(z\\):
///
/// \\[
/// \cos(a + bi) = \cos(a)\cosh(b) - i\sin(a)\sinh(b)
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns a complex number in the codomain \\(\mathbb{C}\\). The range
/// is all complex numbers.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.cos(complex.zero())
///   |> should.equal(complex.one())
/// }
/// ```
///
/// </details>
///
pub fn cos(z: Complex) -> Complex {
  Complex(
    maths.cos(z.real) *. maths.cosh(z.imaginary),
    0.0 -. maths.sin(z.real) *. maths.sinh(z.imaginary),
  )
}

/// Return the tangent of \\(z\\):
///
/// \\[
/// \tan(z) = \frac{\sin(z)}{\cos(z)}
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain
/// \\(\mathbb{C} \setminus \{\frac{\pi}{2} + k\pi \mid k \in \mathbb{Z}\}\\)
/// as input and returns a complex number in the codomain \\(\mathbb{C}\\). The
/// range is \\(\mathbb{C} \setminus \{-i, i\}\\).
///
/// Tangent is calculated as \\(\sin(z) / \cos(z)\\). Values outside the domain,
/// where \\(\cos(z) = 0\\), are undefined and return `Error(Nil)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.tan(complex.zero())
///   result
///   |> should.equal(complex.zero())
/// }
/// ```
///
/// </details>
///
pub fn tan(z: Complex) -> Result(Complex, Nil) {
  let denominator = cos(z)

  case is_complex_tangent_pole(z) || is_zero(denominator) {
    True -> Error(Nil)
    False -> Ok(divide(sin(z), denominator))
  }
}

/// Return the principal inverse sine of \\(z\\):
///
/// \\[
/// \arcsin(z) = -i\operatorname{Log}(iz + \sqrt{1 - z^2})
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns the principal value in the codomain \\(\mathbb{C}\\). Its
/// principal values lie in the vertical strip
/// \\(-\frac{\pi}{2} \le \operatorname{Re}(y) \le \frac{\pi}{2}\\).
///
/// This function returns `Error(Nil)` if the value inside the principal
/// logarithm is zero.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.asin(complex.zero())
///   result
///   |> complex.is_close(complex.zero(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn asin(z: Complex) -> Result(Complex, Nil) {
  let iz = multiply(imaginary_unit(), z)
  let one_minus_z_squared = subtract(one(), multiply(z, z))
  let sqrt_term = square_root(one_minus_z_squared)
  use log_value <- result.try(natural_logarithm(add(iz, sqrt_term)))

  Ok(multiply(Complex(0.0, -1.0), log_value))
}

/// Return the principal inverse cosine of \\(z\\):
///
/// \\[
/// \arccos(z) = \frac{\pi}{2} - \arcsin(z)
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns the principal value in the codomain \\(\mathbb{C}\\). Its
/// principal values lie in the vertical strip
/// \\(0 \le \operatorname{Re}(y) \le \pi\\).
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.acos(complex.one())
///   result
///   |> complex.is_close(complex.zero(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn acos(z: Complex) -> Result(Complex, Nil) {
  use asin_z <- result.try(asin(z))

  Ok(subtract(Complex(maths.pi() /. 2.0, 0.0), asin_z))
}

/// Return the principal inverse tangent of \\(z\\):
///
/// \\[
/// \begin{aligned}
/// \arctan(z)
/// &= -\frac{i}{2}\left(\operatorname{Log}(1 + iz) - \operatorname{Log}(1 - iz)\right)
/// \end{aligned}
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain
/// \\(\mathbb{C} \setminus \{-i, i\}\\) as input and returns the principal value
/// in the codomain \\(\mathbb{C}\\). Its principal values lie in the vertical
/// strip \\(-\frac{\pi}{2} \le \operatorname{Re}(y) \le \frac{\pi}{2}\\).
///
/// This function returns `Error(Nil)` when either value inside the principal
/// logarithms is zero, which occurs at \\(z = -i\\) and \\(z = i\\).
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.atan(complex.zero())
///   result
///   |> complex.is_close(complex.zero(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn atan(z: Complex) -> Result(Complex, Nil) {
  let iz = multiply(imaginary_unit(), z)
  use log_plus <- result.try(natural_logarithm(add(one(), iz)))
  use log_minus <- result.try(natural_logarithm(subtract(one(), iz)))

  Ok(multiply(Complex(0.0, -0.5), subtract(log_plus, log_minus)))
}

/// Return the hyperbolic sine of \\(z\\):
///
/// \\[
/// \sinh(a + bi) = \sinh(a)\cos(b) + i\cosh(a)\sin(b)
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns a complex number in the codomain \\(\mathbb{C}\\). The range
/// is all complex numbers.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.sinh(complex.zero())
///   |> should.equal(complex.zero())
/// }
/// ```
///
/// </details>
///
pub fn sinh(z: Complex) -> Complex {
  Complex(
    maths.sinh(z.real) *. maths.cos(z.imaginary),
    maths.cosh(z.real) *. maths.sin(z.imaginary),
  )
}

/// Return the hyperbolic cosine of \\(z\\):
///
/// \\[
/// \cosh(a + bi) = \cosh(a)\cos(b) + i\sinh(a)\sin(b)
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns a complex number in the codomain \\(\mathbb{C}\\). The range
/// is all complex numbers.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.cosh(complex.zero())
///   |> should.equal(complex.one())
/// }
/// ```
///
/// </details>
///
pub fn cosh(z: Complex) -> Complex {
  Complex(
    maths.cosh(z.real) *. maths.cos(z.imaginary),
    maths.sinh(z.real) *. maths.sin(z.imaginary),
  )
}

/// Return the hyperbolic tangent of \\(z\\):
///
/// \\[
/// \tanh(z) = \frac{\sinh(z)}{\cosh(z)}
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain
/// \\(\mathbb{C} \setminus \{i(\frac{\pi}{2} + k\pi) \mid k \in \mathbb{Z}\}\\)
/// as input and returns a complex number in the codomain \\(\mathbb{C}\\). The
/// range is \\(\mathbb{C} \setminus \{-1, 1\}\\).
///
/// Hyperbolic tangent is calculated as \\(\sinh(z) / \cosh(z)\\). Values outside
/// the domain, where \\(\cosh(z) = 0\\), are undefined and return `Error(Nil)`.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.tanh(complex.zero())
///   result
///   |> should.equal(complex.zero())
/// }
/// ```
///
/// </details>
///
pub fn tanh(z: Complex) -> Result(Complex, Nil) {
  let denominator = cosh(z)

  case is_complex_hyperbolic_tangent_pole(z) || is_zero(denominator) {
    True -> Error(Nil)
    False -> Ok(divide(sinh(z), denominator))
  }
}

/// Return the principal inverse hyperbolic sine of \\(z\\):
///
/// \\[
/// \operatorname{asinh}(z) = \operatorname{Log}(z + \sqrt{z^2 + 1})
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns the principal value in the codomain \\(\mathbb{C}\\). Its
/// principal values lie in the horizontal strip
/// \\(-\frac{\pi}{2} \le \operatorname{Im}(y) \le \frac{\pi}{2}\\).
///
/// This function returns `Error(Nil)` if the value inside the principal
/// logarithm is zero.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.asinh(complex.zero())
///   result
///   |> complex.is_close(complex.zero(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn asinh(z: Complex) -> Result(Complex, Nil) {
  let sqrt_term = square_root(add(multiply(z, z), one()))

  natural_logarithm(add(z, sqrt_term))
}

/// Return the principal inverse hyperbolic cosine of \\(z\\):
///
/// \\[
/// \operatorname{acosh}(z) = \operatorname{Log}(z + \sqrt{z + 1}\sqrt{z - 1})
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain \\(\mathbb{C}\\) as
/// input and returns the principal value in the codomain \\(\mathbb{C}\\). Its
/// principal values satisfy \\(\operatorname{Re}(y) \ge 0\\) and
/// \\(-\pi < \operatorname{Im}(y) \le \pi\\).
///
/// This function returns `Error(Nil)` if the value inside the principal
/// logarithm is zero.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.acosh(complex.one())
///   result
///   |> complex.is_close(complex.zero(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn acosh(z: Complex) -> Result(Complex, Nil) {
  let sqrt_plus = square_root(add(z, one()))
  let sqrt_minus = square_root(subtract(z, one()))

  natural_logarithm(add(z, multiply(sqrt_plus, sqrt_minus)))
}

/// Return the principal inverse hyperbolic tangent of \\(z\\):
///
/// \\[
/// \begin{aligned}
/// \operatorname{atanh}(z)
/// &= \frac{1}{2}\left(\operatorname{Log}(1 + z) - \operatorname{Log}(1 - z)\right)
/// \end{aligned}
/// \\]
///
/// The function takes a complex number \\(z\\) in its domain
/// \\(\mathbb{C} \setminus \{-1, 1\}\\) as input and returns the principal value
/// in the codomain \\(\mathbb{C}\\). Its principal values lie in the horizontal
/// strip \\(-\frac{\pi}{2} \le \operatorname{Im}(y) \le \frac{\pi}{2}\\).
///
/// This function returns `Error(Nil)` when either value inside the principal
/// logarithms is zero, which occurs at \\(z = -1\\) and \\(z = 1\\).
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   let assert Ok(result) = complex.atanh(complex.zero())
///   result
///   |> complex.is_close(complex.zero(), 0.0, 0.0000001)
///   |> should.be_true()
/// }
/// ```
///
/// </details>
///
pub fn atanh(z: Complex) -> Result(Complex, Nil) {
  use log_plus <- result.try(natural_logarithm(add(one(), z)))
  use log_minus <- result.try(natural_logarithm(subtract(one(), z)))

  Ok(multiply(from_float(0.5), subtract(log_plus, log_minus)))
}

/// Compare two complex numbers by their real components.
///
/// This function only compares the real components and does not define a
/// mathematical ordering of complex numbers.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleam/order
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.compare_real(complex.Complex(1.0, 10.0), complex.Complex(2.0, 0.0))
///   |> should.equal(order.Lt)
/// }
/// ```
///
/// </details>
///
pub fn compare_real(a: Complex, b: Complex) -> Order {
  float.compare(a.real, b.real)
}

/// Compare two complex numbers by their imaginary components.
///
/// This function only compares the imaginary components and does not define a
/// mathematical ordering of complex numbers.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleam/order
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.compare_imaginary(complex.Complex(10.0, 1.0), complex.Complex(0.0, 2.0))
///   |> should.equal(order.Lt)
/// }
/// ```
///
/// </details>
///
pub fn compare_imaginary(a: Complex, b: Complex) -> Order {
  float.compare(a.imaginary, b.imaginary)
}

/// Return the complex conjugate of \\(z\\):
///
/// \\[
/// \overline{a + bi} = a - bi
/// \\]
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.conjugate(complex.Complex(1.0, 2.0))
///   |> should.equal(complex.Complex(1.0, -2.0))
/// }
/// ```
///
/// </details>
///
pub fn conjugate(z: Complex) -> Complex {
  Complex(z.real, 0.0 -. z.imaginary)
}

/// Convert \\(z\\) to a string.
///
/// The output is formatted as `"a"`, `"a + bi"`, or `"a - bi"` depending on the
/// sign of the imaginary component.
///
/// <details>
/// <summary>Examples</summary>
///
/// ```gleam
/// import gleeunit/should
/// import gleam_community/complex
///
/// pub fn example() {
///   complex.to_string(complex.Complex(1.0, -2.0))
///   |> should.equal("1.0 - 2.0i")
/// }
/// ```
///
/// </details>
///
pub fn to_string(z: Complex) -> String {
  float.to_string(z.real)
  <> case float.compare(z.imaginary, 0.0) {
    Eq -> ""
    Gt -> " + " <> float.to_string(z.imaginary) <> "i"
    Lt -> " - " <> float.to_string(0.0 -. z.imaginary) <> "i"
  }
}
