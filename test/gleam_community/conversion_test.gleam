import gleam/float
import gleam_community/maths
import gleeunit/should

pub fn to_degree_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  maths.radians_to_degrees(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.radians_to_degrees(2.0 *. maths.pi())
  |> maths.is_close(360.0, 0.0, tol)
  |> should.be_true()
}

pub fn to_radian_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  maths.degrees_to_radians(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.degrees_to_radians(360.0)
  |> maths.is_close(2.0 *. maths.pi(), 0.0, tol)
  |> should.be_true()
}

pub fn cartesian_to_polar_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Test: Cartesian (1, 0) -> Polar (1, 0)
  let #(r, theta) = maths.cartesian_to_polar(1.0, 0.0)
  r
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  theta
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Test: Cartesian (0, 1) -> Polar (1, pi/2)
  let #(r, theta) = maths.cartesian_to_polar(0.0, 1.0)
  r
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  theta
  |> maths.is_close(maths.pi() /. 2.0, 0.0, tol)
  |> should.be_true()

  // Test: Cartesian (-1, 0) -> Polar (1, pi)
  let #(r, theta) = maths.cartesian_to_polar(-1.0, 0.0)
  r
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  theta
  |> maths.is_close(maths.pi(), 0.0, tol)
  |> should.be_true()

  // Test: Cartesian (0, -1) -> Polar (1, -pi/2)
  let #(r, theta) = maths.cartesian_to_polar(0.0, -1.0)
  r
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  theta
  |> maths.is_close(-1.0 *. maths.pi() /. 2.0, 0.0, tol)
  |> should.be_true()
}

pub fn polar_to_cartesian_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Test: Polar (1, 0) -> Cartesian (1, 0)
  let #(x, y) = maths.polar_to_cartesian(1.0, 0.0)
  x
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  y
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Test: Polar (1, pi/2) -> Cartesian (0, 1)
  let #(x, y) = maths.polar_to_cartesian(1.0, maths.pi() /. 2.0)
  x
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  y
  |> maths.is_close(1.0, 0.0, tol)
  |> should.be_true()

  // Test: Polar (1, pi) -> Cartesian (-1, 0)
  let #(x, y) = maths.polar_to_cartesian(1.0, maths.pi())
  x
  |> maths.is_close(-1.0, 0.0, tol)
  |> should.be_true()

  y
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  // Test: Polar (1, -pi/2) -> Cartesian (0, -1)
  let #(x, y) = maths.polar_to_cartesian(1.0, -1.0 *. maths.pi() /. 2.0)
  x
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  y
  |> maths.is_close(-1.0, 0.0, tol)
  |> should.be_true()
}
