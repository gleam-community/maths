import gleam/float
import gleam/list
import gleam/result
import gleam_community/maths
import gleeunit/should

pub fn float_beta_function_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  // Invalid input gives an error
  maths.beta(-0.5, 0.5)
  |> should.be_error()

  maths.beta(0.5, -0.5)
  |> should.be_error()

  maths.beta(0.0, 1.0)
  |> should.be_error()

  maths.beta(1.0, 0.0)
  |> should.be_error()

  maths.beta(-1.0, 2.0)
  |> should.be_error()

  // Valid input returns a result
  maths.beta(0.5, 0.5)
  |> result.unwrap(-999.0)
  |> maths.is_close(3.1415926535897927, 0.0, tol)
  |> should.be_true()

  maths.beta(-0.5, 1.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(-2.0, 0.0, tol)
  |> should.be_true()

  maths.beta(5.0, 5.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.0015873015873015873, 0.0, tol)
  |> should.be_true()
}

pub fn float_beta_function_identity_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  // The beta function is symmetric
  let assert Ok(beta_xy) = maths.beta(2.5, 4.0)
  let assert Ok(beta_yx) = maths.beta(4.0, 2.5)
  beta_xy
  |> maths.is_close(beta_yx, tol, 0.0)
  |> should.be_true()

  // The beta function agrees with the gamma-function identity
  let assert Ok(gamma_x) = maths.gamma(2.5)
  let assert Ok(gamma_y) = maths.gamma(4.0)
  let assert Ok(gamma_sum) = maths.gamma(6.5)
  beta_xy
  |> maths.is_close(gamma_x *. gamma_y /. gamma_sum, tol, 0.0)
  |> should.be_true()

  // Large values are evaluated without direct gamma multiplication overflow
  let assert Ok(beta_scale) = float.power(10.0, -67.0)
  maths.beta(100.0, 120.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(5.011519154109174 *. beta_scale, tol, 0.0)
  |> should.be_true()
}

pub fn float_error_function_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Valid input returns a result
  maths.erf(-0.5)
  |> maths.is_close(-0.5204998778130465, 0.0, tol)
  |> should.be_true()

  maths.erf(0.5)
  |> maths.is_close(0.5204998778130465, 0.0, tol)
  |> should.be_true()

  maths.erf(1.0)
  |> maths.is_close(0.8427007929497148, 0.0, tol)
  |> should.be_true()

  maths.erf(2.0)
  |> maths.is_close(0.9953222650189527, 0.0, tol)
  |> should.be_true()

  maths.erf(10.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_complementary_error_function_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  maths.erfc(-2.0)
  |> maths.is_close(1.9953222650189528, 0.0, tol)
  |> should.be_true()

  maths.erfc(-0.5)
  |> maths.is_close(1.5204998778130465, 0.0, tol)
  |> should.be_true()

  maths.erfc(0.0)
  |> should.equal(1.0)

  maths.erfc(0.5)
  |> maths.is_close(0.4795001221869535, 0.0, tol)
  |> should.be_true()

  maths.erfc(1.0)
  |> maths.is_close(0.15729920705028513, 0.0, tol)
  |> should.be_true()

  maths.erfc(2.0)
  |> maths.is_close(0.004677734981047265, 0.0, tol)
  |> should.be_true()

  let assert Ok(erfc_tail_scale) = float.power(10.0, -45.0)
  maths.erfc(10.0)
  |> maths.is_close(2.088487583762545 *. erfc_tail_scale, 0.05, 0.0)
  |> should.be_true()

  maths.erf(1.0) +. maths.erfc(1.0)
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_error_function_identity_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  [0.0, 0.5, 1.0, 2.0, 4.0]
  |> list.map(fn(x) {
    let erf_x = maths.erf(x)
    let erfc_x = maths.erfc(x)

    // The error function is odd
    maths.erf(-1.0 *. x)
    |> maths.is_close(-1.0 *. erf_x, 0.0, tol)
    |> should.be_true()

    // The complementary error function satisfies erfc(-x) = 2 - erfc(x)
    maths.erfc(-1.0 *. x)
    |> maths.is_close(2.0 -. erfc_x, 0.0, tol)
    |> should.be_true()

    // The two error functions sum to 1
    erf_x +. erfc_x
    |> maths.is_close(1.0, 0.0, tol)
    |> should.be_true()
  })
}

pub fn float_log_gamma_function_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  // Invalid input gives an error
  maths.log_gamma(-3.0)
  |> should.be_error()

  maths.log_gamma(-2.0)
  |> should.be_error()

  maths.log_gamma(-1.0)
  |> should.be_error()

  maths.log_gamma(0.0)
  |> should.be_error()

  // Valid input returns the logarithm of the absolute gamma value
  maths.log_gamma(-0.5)
  |> result.unwrap(-999.0)
  |> maths.is_close(1.265512123484645, 0.0, tol)
  |> should.be_true()

  maths.log_gamma(0.5)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.5723649429247004, 0.0, tol)
  |> should.be_true()

  maths.log_gamma(1.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.log_gamma(2.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.log_gamma(10.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(12.801827480081467, 0.0, tol)
  |> should.be_true()

  maths.log_gamma(171.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(706.5730622457874, 0.0, tol)
  |> should.be_true()
}

pub fn float_gamma_log_gamma_identity_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  [-2.5, -1.5, -0.5, 0.5, 1.5, 5.0, 10.0]
  |> list.map(fn(x) {
    let assert Ok(gamma_value) = maths.gamma(x)
    let assert Ok(log_gamma_value) = maths.log_gamma(x)

    maths.exponential(log_gamma_value)
    |> maths.is_close(float.absolute_value(gamma_value), tol, 0.0)
    |> should.be_true()
  })
}

pub fn float_gamma_function_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  // Invalid input gives an error
  maths.gamma(-3.0)
  |> should.be_error()

  maths.gamma(-2.0)
  |> should.be_error()

  maths.gamma(-1.0)
  |> should.be_error()

  maths.gamma(0.0)
  |> should.be_error()

  maths.gamma(172.0)
  |> should.be_error()

  // Valid input returns a result
  maths.gamma(-0.5)
  |> result.unwrap(-999.0)
  |> maths.is_close(-3.5449077018110318, tol, 0.0)
  |> should.be_true()

  maths.gamma(0.5)
  |> result.unwrap(-999.0)
  |> maths.is_close(1.7724538509055159, tol, 0.0)
  |> should.be_true()

  maths.gamma(1.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(1.0, tol, 0.0)
  |> should.be_true()

  maths.gamma(2.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(1.0, tol, 0.0)
  |> should.be_true()

  maths.gamma(3.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(2.0, tol, 0.0)
  |> should.be_true()

  maths.gamma(10.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(362_880.0, tol, 0.0)
  |> should.be_true()
}

pub fn float_gamma_recurrence_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  [0.5, 1.5, 3.5, -0.5, -1.5, -2.5]
  |> list.map(fn(x) {
    let assert Ok(gamma_x) = maths.gamma(x)
    let assert Ok(gamma_next) = maths.gamma(x +. 1.0)

    gamma_next
    |> maths.is_close(x *. gamma_x, tol, 0.0)
    |> should.be_true()
  })
}

pub fn float_incomplete_gamma_function_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  // Invalid input gives an error
  // 1st arg is invalid
  maths.incomplete_gamma(-1.0, 1.0)
  |> should.be_error()

  // 2nd arg is invalid
  maths.incomplete_gamma(1.0, -1.0)
  |> should.be_error()

  // Valid input returns a result
  maths.incomplete_gamma(1.0, 0.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.incomplete_gamma(1.0, 2.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.864664716763387308106, 0.0, tol)
  |> should.be_true()

  maths.incomplete_gamma(2.0, 3.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.8008517265285442280826, 0.0, tol)
  |> should.be_true()

  maths.incomplete_gamma(3.0, 4.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(1.523793388892911312363, 0.0, tol)
  |> should.be_true()

  // Series branch
  maths.incomplete_gamma(5.0, 1.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(0.08783632385624784, 0.0, tol)
  |> should.be_true()

  // Continued-fraction branch
  maths.incomplete_gamma(5.0, 10.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(23.297935486152937, 0.0, tol)
  |> should.be_true()

  // The lower incomplete gamma approaches gamma(a) for large x
  maths.incomplete_gamma(0.5, 100.0)
  |> result.unwrap(-999.0)
  |> maths.is_close(1.7724538509055159, 0.0, tol)
  |> should.be_true()
}

pub fn float_incomplete_gamma_identity_test() {
  let assert Ok(tol) = float.power(10.0, -9.0)

  // The lower incomplete gamma function is zero when x = 0
  [0.5, 1.0, 5.0]
  |> list.map(fn(a) {
    maths.incomplete_gamma(a, 0.0)
    |> should.equal(Ok(0.0))
  })

  // For positive integer a, the lower incomplete gamma has a finite-sum form
  let x = 2.0
  let finite_sum = 1.0 +. x +. x *. x /. 2.0 +. x *. x *. x /. 6.0
  let expected = 6.0 *. { 1.0 -. maths.exponential(-1.0 *. x) *. finite_sum }
  maths.incomplete_gamma(4.0, x)
  |> result.unwrap(-999.0)
  |> maths.is_close(expected, 0.0, tol)
  |> should.be_true()

  // For a = 1/2, the lower incomplete gamma is related to the error function
  let assert Ok(erf_tol) = float.power(10.0, -6.0)
  let assert Ok(sqrt_pi) = float.square_root(maths.pi())
  maths.incomplete_gamma(0.5, 0.25)
  |> result.unwrap(-999.0)
  |> maths.is_close(sqrt_pi *. maths.erf(0.5), 0.0, erf_tol)
  |> should.be_true()

  // The lower incomplete gamma approaches gamma(a) for large x
  [3.0, 5.0]
  |> list.map(fn(a) {
    let assert Ok(lower) = maths.incomplete_gamma(a, 100.0)
    let assert Ok(gamma_a) = maths.gamma(a)

    lower
    |> maths.is_close(gamma_a, 0.0, tol)
    |> should.be_true()
  })
}
