import gleam/bool
import gleam/float
import gleam/int
import gleam/list
import gleam/order.{type Order, Eq, Gt, Lt}
import gleam/result
import gleam_community/maths

pub type Complex {
  Complex(real: Float, imaginary: Float)
}

pub fn add(a: Complex, b: Complex) -> Complex {
  Complex(a.real +. b.real, a.imaginary +. b.imaginary)
}

pub fn subtract(a: Complex, b: Complex) -> Complex {
  Complex(a.real -. b.real, a.imaginary -. b.imaginary)
}

pub fn multiply(a: Complex, b: Complex) -> Complex {
  Complex(
    a.real *. b.real -. a.imaginary *. b.imaginary,
    a.real *. b.imaginary +. a.imaginary *. b.real,
  )
}

pub fn divide(a: Complex, b: Complex) -> Complex {
  Complex(
    { a.real *. b.real +. a.imaginary *. b.imaginary }
      /. { b.real *. b.real +. b.imaginary *. b.imaginary },
    { a.imaginary *. b.real -. a.real *. b.imaginary }
      /. { b.real *. b.real +. b.imaginary *. b.imaginary },
  )
}

pub fn absolute_value(z: Complex) -> Float {
  let assert Ok(result) =
    float.square_root(z.real *. z.real +. z.imaginary *. z.imaginary)
  result
}

pub fn argument(z: Complex) -> Result(Float, Nil) {
  case float.compare(z.real, 0.0), float.compare(z.imaginary, 0.0) {
    Eq, Eq -> Error(Nil)
    Eq, Lt -> Ok(0.0 -. maths.pi() /. 2.0)
    Eq, Gt -> Ok(maths.pi() /. 2.0)
    Lt, Lt -> Ok(maths.atan(z.imaginary /. z.real) -. maths.pi())
    Lt, _ -> Ok(maths.atan(z.imaginary /. z.real) +. maths.pi())
    Gt, _ -> Ok(maths.atan(z.imaginary /. z.real))
  }
}

pub fn from_float(real: Float) -> Complex {
  Complex(real, 0.0)
}

fn from_unit_angle(phi: Float) -> Complex {
  Complex(maths.cos(phi), maths.sin(phi))
}

pub fn from_polar(r: Float, phi: Float) -> Complex {
  multiply(from_float(r), from_unit_angle(phi))
}

pub fn to_polar(z: Complex) -> Result(#(Float, Float), Nil) {
  case argument(z) {
    Error(_) -> Error(Nil)
    Ok(arg) -> Ok(#(absolute_value(z), arg))
  }
}

pub fn exponential(z: Complex) -> Complex {
  from_polar(maths.exponential(z.real), z.imaginary)
}

pub fn reciprocal(z: Complex) -> Complex {
  let divisor = z.real *. z.real +. z.imaginary *. z.imaginary
  Complex(z.real /. divisor, 0.0 -. z.imaginary /. divisor)
}

// De Moivre’s Theorem
pub fn power(z: Complex, n: Int) -> Result(Complex, Nil) {
  let r = absolute_value(z)
  case argument(z), int.compare(n, 0) {
    // 0 ^ 0 -> undefined
    Error(_), Eq -> Error(Nil)
    // 0 ^ n -> 0
    Error(_), _ -> Ok(Complex(0.0, 0.0))
    // z ^ 0 -> 1
    Ok(_), Eq -> Ok(multiplicative_identity())
    // De Moivre's Theorem only works for positive integers
    Ok(_), Lt -> Error(Nil)
    Ok(arg), _ -> {
      // n can't be 0
      let assert Ok(r_to_the_n) = float.power(r, int.to_float(n))
      Ok(from_polar(r_to_the_n, int.to_float(n) *. arg))
    }
  }
}

// De Moivre’s Theorem
pub fn nth_root(z: Complex, n: Int) -> Result(List(Complex), Nil) {
  case int.compare(n, 0) {
    Eq -> Error(Nil)
    Lt -> {
      let assert Ok(result_before_reciprocal) = nth_root(z, -n)
      Ok(
        result_before_reciprocal
        |> list.map(reciprocal),
      )
    }
    Gt ->
      case argument(z) {
        // any root of 0 = 0
        Error(_) -> Ok([Complex(0.0, 0.0)])
        Ok(arg) -> {
          let r = absolute_value(z)
          // r and n are always positive -> root is defined
          let assert Ok(new_r) = maths.nth_root(r, n)

          list.range(0, n - 1)
          |> list.map(fn(k) {
            from_polar(
              new_r,
              { arg +. 2.0 *. int.to_float(k) *. maths.pi() } /. int.to_float(n),
            )
          })
          |> Ok
        }
      }
  }
}

fn zero() -> Complex {
  Complex(0.0, 0.0)
}

fn multiplicative_identity() -> Complex {
  from_float(1.0)
}

pub fn sum(arr: List(Complex)) -> Complex {
  list.fold(arr, zero(), add)
}

pub fn product(arr: List(Complex)) -> Complex {
  list.fold(arr, multiplicative_identity(), multiply)
}

pub fn weighted_sum(arr: List(#(Complex, Float))) -> Result(Complex, Nil) {
  let weight_is_negative = list.any(arr, fn(tuple) { tuple.1 <. 0.0 })
  case weight_is_negative {
    True -> Error(Nil)
    False ->
      Ok(
        list.fold(arr, zero(), fn(acc, tuple) {
          add(acc, multiply(tuple.0, from_float(tuple.1)))
        }),
      )
  }
}

pub fn weighted_product(arr: List(#(Complex, Int))) -> Result(Complex, Nil) {
  let weight_is_negative = list.any(arr, fn(tuple) { tuple.1 < 0 })
  case weight_is_negative {
    True -> Error(Nil)
    False ->
      list.fold(arr, Ok(multiplicative_identity()), fn(acc_result, tuple) {
        acc_result
        |> result.then(fn(acc) {
          power(tuple.0, tuple.1)
          |> result.map(multiply(acc, _))
        })
      })
  }
}

pub fn cumulative_sum(arr: List(Complex)) -> List(Complex) {
  list.scan(arr, zero(), add)
}

pub fn cumulative_product(arr: List(Complex)) -> List(Complex) {
  list.scan(arr, multiplicative_identity(), multiply)
}

pub fn absolute_difference(a: Complex, b: Complex) {
  absolute_value(subtract(a, b))
}

pub fn mean(arr: List(Complex)) -> Result(Complex, Nil) {
  case arr {
    [] -> Error(Nil)
    _ ->
      sum(arr)
      |> divide(arr |> list.length |> int.to_float |> from_float)
      |> Ok
  }
}

pub fn median(arr: List(Complex)) -> Result(Complex, Nil) {
  use <- bool.guard(list.is_empty(arr), Error(Nil))
  let length = list.length(arr)
  let mid = length / 2

  case length % 2 == 0 {
    False -> arr |> list.drop(mid) |> list.first
    True -> {
      arr
      |> list.drop(mid - 1)
      |> list.take(2)
      |> mean
    }
  }
}

pub fn is_close(x: Complex, y: Complex, rtol: Float, atol: Float) -> Bool {
  let x = absolute_difference(x, y)
  let y = atol +. rtol *. absolute_value(y)
  x <=. y
}

pub fn all_close(
  arr: List(#(Complex, Complex)),
  rtol: Float,
  atol: Float,
) -> Result(List(Bool), Nil) {
  Ok(list.map(arr, fn(tuple) { is_close(tuple.0, tuple.1, rtol, atol) }))
}

pub fn compare_real(a: Complex, b: Complex) -> Order {
  float.compare(a.real, b.real)
}

pub fn compare_imaginary(a: Complex, b: Complex) -> Order {
  float.compare(a.imaginary, b.imaginary)
}

pub fn conjugate(z: Complex) -> Complex {
  Complex(z.real, 0.0 -. z.imaginary)
}

pub fn to_string(z: Complex) -> String {
  float.to_string(z.real)
  <> case float.compare(z.imaginary, 0.0) {
    Eq -> ""
    Gt -> " + " <> float.to_string(z.imaginary) <> "i"
    Lt -> " - " <> float.to_string(0.0 -. z.imaginary) <> "i"
  }
}
