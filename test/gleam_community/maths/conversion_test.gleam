import gleam_community/maths/elementary
import gleam_community/maths/predicates
import gleam_community/maths/conversion
import gleeunit/should

pub fn float_to_degree_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  conversion.radians_to_degrees(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  conversion.radians_to_degrees(2.0 *. elementary.pi())
  |> predicates.is_close(360.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_to_radian_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  conversion.degrees_to_radians(0.0)
  |> predicates.is_close(0.0, 0.0, tol)
  |> should.be_true()

  conversion.degrees_to_radians(360.0)
  |> predicates.is_close(2.0 *. elementary.pi(), 0.0, tol)
  |> should.be_true()
}

pub fn float_to_int_test() {
  conversion.float_to_int(12.0654)
  |> should.equal(12)
}

pub fn int_to_float_test() {
  conversion.int_to_float(-1)
  |> should.equal(-1.0)

  conversion.int_to_float(1)
  |> should.equal(1.0)
}
