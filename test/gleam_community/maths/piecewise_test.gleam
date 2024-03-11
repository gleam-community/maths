import gleam_community/maths/piecewise
import gleeunit/should
import gleam/option
import gleam/float
import gleam/int

pub fn float_ceiling_test() {
  // Round 3. digit AFTER decimal point 
  piecewise.ceiling(12.0654, option.Some(3))
  |> should.equal(Ok(12.066))

  // Round 2. digit AFTER decimal point 
  piecewise.ceiling(12.0654, option.Some(2))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  piecewise.ceiling(12.0654, option.Some(1))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  piecewise.ceiling(12.0654, option.Some(0))
  |> should.equal(Ok(13.0))

  // Round 1. digit BEFORE decimal point 
  piecewise.ceiling(12.0654, option.Some(-1))
  |> should.equal(Ok(20.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.ceiling(12.0654, option.Some(-2))
  |> should.equal(Ok(100.0))

  // Round 3. digit BEFORE decimal point 
  piecewise.ceiling(12.0654, option.Some(-3))
  |> should.equal(Ok(1000.0))
}

pub fn float_floor_test() {
  // Round 3. digit AFTER decimal point 
  piecewise.floor(12.0654, option.Some(3))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  piecewise.floor(12.0654, option.Some(2))
  |> should.equal(Ok(12.06))

  // Round 1. digit AFTER decimal point 
  piecewise.floor(12.0654, option.Some(1))
  |> should.equal(Ok(12.0))

  // Round 0. digit BEFORE decimal point 
  piecewise.floor(12.0654, option.Some(0))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  piecewise.floor(12.0654, option.Some(-1))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.floor(12.0654, option.Some(-2))
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.floor(12.0654, option.Some(-3))
  |> should.equal(Ok(0.0))
}

pub fn float_truncate_test() {
  // Round 3. digit AFTER decimal point 
  piecewise.truncate(12.0654, option.Some(3))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  piecewise.truncate(12.0654, option.Some(2))
  |> should.equal(Ok(12.06))

  // Round 1. digit AFTER decimal point 
  piecewise.truncate(12.0654, option.Some(1))
  |> should.equal(Ok(12.0))

  // Round 0. digit BEFORE decimal point 
  piecewise.truncate(12.0654, option.Some(0))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  piecewise.truncate(12.0654, option.Some(-1))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.truncate(12.0654, option.Some(-2))
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.truncate(12.0654, option.Some(-3))
  |> should.equal(Ok(0.0))
}

pub fn math_round_to_nearest_test() {
  // Try with positive values
  piecewise.round(1.5, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(2.0))

  piecewise.round(1.75, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(2.0))

  piecewise.round(2.0, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(2.0))

  piecewise.round(3.5, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(4.0))

  piecewise.round(4.5, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(4.0))

  // Try with negative values
  piecewise.round(-3.5, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(-4.0))

  piecewise.round(-4.5, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(-4.0))

  // Round 3. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(3), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(1), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(0), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(-1), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(-2), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(0.0))

  // Round 3. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(-3), option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(0.0))
}

pub fn math_round_up_test() {
  // Note: Rounding mode "RoundUp" is an alias for the ceiling function
  // Try with positive values
  piecewise.round(0.45, option.Some(0), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(1.0))

  piecewise.round(0.5, option.Some(0), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(1.0))

  piecewise.round(0.45, option.Some(1), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(0.5))

  piecewise.round(0.5, option.Some(1), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(0.5))

  piecewise.round(0.455, option.Some(2), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(0.46))

  piecewise.round(0.505, option.Some(2), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(0.51))

  // Try with negative values
  piecewise.round(-0.45, option.Some(0), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(-0.0))

  piecewise.round(-0.5, option.Some(0), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(-0.0))

  piecewise.round(-0.45, option.Some(1), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(-0.4))

  piecewise.round(-0.5, option.Some(1), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(-0.5))

  piecewise.round(-0.455, option.Some(2), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(-0.45))

  piecewise.round(-0.505, option.Some(2), option.Some(piecewise.RoundUp))
  |> should.equal(Ok(-0.5))
}

pub fn math_round_down_test() {
  // Note: Rounding mode "RoundDown" is an alias for the floor function
  // Try with positive values
  piecewise.round(0.45, option.Some(0), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(0.0))

  piecewise.round(0.5, option.Some(0), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(0.0))

  piecewise.round(0.45, option.Some(1), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(0.4))

  piecewise.round(0.5, option.Some(1), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(0.5))

  piecewise.round(0.455, option.Some(2), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(0.45))

  piecewise.round(0.505, option.Some(2), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(0.5))

  // Try with negative values
  piecewise.round(-0.45, option.Some(0), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(-1.0))

  piecewise.round(-0.5, option.Some(0), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(-1.0))

  piecewise.round(-0.45, option.Some(1), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(-0.5))

  piecewise.round(-0.5, option.Some(1), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(-0.5))

  piecewise.round(-0.455, option.Some(2), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(-0.46))

  piecewise.round(-0.505, option.Some(2), option.Some(piecewise.RoundDown))
  |> should.equal(Ok(-0.51))
}

pub fn math_round_to_zero_test() {
  // Note: Rounding mode "RoundToZero" is an alias for the truncate function
  // Try with positive values
  piecewise.round(0.5, option.Some(0), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.0))

  piecewise.round(0.75, option.Some(0), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.0))

  piecewise.round(0.45, option.Some(1), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.4))

  piecewise.round(0.57, option.Some(1), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.5))

  piecewise.round(0.4575, option.Some(2), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.45))

  piecewise.round(0.5075, option.Some(2), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.5))

  // Try with negative values
  piecewise.round(-0.5, option.Some(0), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.0))

  piecewise.round(-0.75, option.Some(0), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(0.0))

  piecewise.round(-0.45, option.Some(1), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(-0.4))

  piecewise.round(-0.57, option.Some(1), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(-0.5))

  piecewise.round(-0.4575, option.Some(2), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(-0.45))

  piecewise.round(-0.5075, option.Some(2), option.Some(piecewise.RoundToZero))
  |> should.equal(Ok(-0.5))
}

pub fn math_round_ties_away_test() {
  // Try with positive values
  piecewise.round(1.4, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(1.0))

  piecewise.round(1.5, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(2.0))

  piecewise.round(2.5, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(3.0))

  // Try with negative values
  piecewise.round(-1.4, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(-1.0))

  piecewise.round(-1.5, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(-2.0))

  piecewise.round(-2.0, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(-2.0))

  piecewise.round(-2.5, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(-3.0))

  // Round 3. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(3), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(1), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(0), option.Some(piecewise.RoundTiesAway))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  piecewise.round(
    12.0654,
    option.Some(-1),
    option.Some(piecewise.RoundTiesAway),
  )
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.round(
    12.0654,
    option.Some(-2),
    option.Some(piecewise.RoundTiesAway),
  )
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.round(
    12.0654,
    option.Some(-3),
    option.Some(piecewise.RoundTiesAway),
  )
  |> should.equal(Ok(0.0))
}

pub fn math_round_ties_up_test() {
  // Try with positive values
  piecewise.round(1.4, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(1.0))

  piecewise.round(1.5, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(2.0))

  piecewise.round(2.5, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(3.0))

  // Try with negative values
  piecewise.round(-1.4, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(-1.0))

  piecewise.round(-1.5, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(-1.0))

  piecewise.round(-2.0, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(-2.0))

  piecewise.round(-2.5, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(-2.0))

  // Round 3. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(3), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(12.065))

  // Round 2. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(2), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(12.07))

  // Round 1. digit AFTER decimal point 
  piecewise.round(12.0654, option.Some(1), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(12.1))

  // Round 0. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(0), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(12.0))

  // Round 1. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(-1), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(10.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(-2), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(0.0))

  // Round 2. digit BEFORE decimal point 
  piecewise.round(12.0654, option.Some(-3), option.Some(piecewise.RoundTiesUp))
  |> should.equal(Ok(0.0))
}

pub fn math_round_edge_cases_test() {
  // The default number of digits is 0 if None is provided
  piecewise.round(12.0654, option.None, option.Some(piecewise.RoundNearest))
  |> should.equal(Ok(12.0))

  // The default rounding mode is piecewise.RoundNearest if None is provided 
  piecewise.round(12.0654, option.None, option.None)
  |> should.equal(Ok(12.0))
}

pub fn float_absolute_value_test() {
  piecewise.float_absolute_value(20.0)
  |> should.equal(20.0)

  piecewise.float_absolute_value(-20.0)
  |> should.equal(20.0)
}

pub fn int_absolute_value_test() {
  piecewise.int_absolute_value(20)
  |> should.equal(20)

  piecewise.int_absolute_value(-20)
  |> should.equal(20)
}

pub fn float_absolute_difference_test() {
  piecewise.float_absolute_difference(20.0, 15.0)
  |> should.equal(5.0)

  piecewise.float_absolute_difference(-20.0, -15.0)
  |> should.equal(5.0)

  piecewise.float_absolute_difference(20.0, -15.0)
  |> should.equal(35.0)

  piecewise.float_absolute_difference(-20.0, 15.0)
  |> should.equal(35.0)

  piecewise.float_absolute_difference(0.0, 0.0)
  |> should.equal(0.0)

  piecewise.float_absolute_difference(1.0, 2.0)
  |> should.equal(1.0)

  piecewise.float_absolute_difference(2.0, 1.0)
  |> should.equal(1.0)

  piecewise.float_absolute_difference(-1.0, 0.0)
  |> should.equal(1.0)

  piecewise.float_absolute_difference(0.0, -1.0)
  |> should.equal(1.0)

  piecewise.float_absolute_difference(10.0, 20.0)
  |> should.equal(10.0)

  piecewise.float_absolute_difference(-10.0, -20.0)
  |> should.equal(10.0)

  piecewise.float_absolute_difference(-10.5, 10.5)
  |> should.equal(21.0)
}

pub fn int_absolute_difference_test() {
  piecewise.int_absolute_difference(20, 15)
  |> should.equal(5)

  piecewise.int_absolute_difference(-20, -15)
  |> should.equal(5)

  piecewise.int_absolute_difference(20, -15)
  |> should.equal(35)

  piecewise.int_absolute_difference(-20, 15)
  |> should.equal(35)
}

pub fn float_sign_test() {
  piecewise.float_sign(100.0)
  |> should.equal(1.0)

  piecewise.float_sign(0.0)
  |> should.equal(0.0)

  piecewise.float_sign(-100.0)
  |> should.equal(-1.0)
}

pub fn float_flip_sign_test() {
  piecewise.float_flip_sign(100.0)
  |> should.equal(-100.0)

  piecewise.float_flip_sign(0.0)
  |> should.equal(-0.0)

  piecewise.float_flip_sign(-100.0)
  |> should.equal(100.0)
}

pub fn float_copy_sign_test() {
  piecewise.float_copy_sign(100.0, 10.0)
  |> should.equal(100.0)

  piecewise.float_copy_sign(-100.0, 10.0)
  |> should.equal(100.0)

  piecewise.float_copy_sign(100.0, -10.0)
  |> should.equal(-100.0)

  piecewise.float_copy_sign(-100.0, -10.0)
  |> should.equal(-100.0)
}

pub fn int_sign_test() {
  piecewise.int_sign(100)
  |> should.equal(1)

  piecewise.int_sign(0)
  |> should.equal(0)

  piecewise.int_sign(-100)
  |> should.equal(-1)
}

pub fn int_flip_sign_test() {
  piecewise.int_flip_sign(100)
  |> should.equal(-100)

  piecewise.int_flip_sign(0)
  |> should.equal(-0)

  piecewise.int_flip_sign(-100)
  |> should.equal(100)
}

pub fn int_copy_sign_test() {
  piecewise.int_copy_sign(100, 10)
  |> should.equal(100)

  piecewise.int_copy_sign(-100, 10)
  |> should.equal(100)

  piecewise.int_copy_sign(100, -10)
  |> should.equal(-100)

  piecewise.int_copy_sign(-100, -10)
  |> should.equal(-100)
}

pub fn float_minimum_test() {
  piecewise.minimum(0.75, 0.5, float.compare)
  |> should.equal(0.5)

  piecewise.minimum(0.5, 0.75, float.compare)
  |> should.equal(0.5)

  piecewise.minimum(-0.75, 0.5, float.compare)
  |> should.equal(-0.75)

  piecewise.minimum(-0.75, 0.5, float.compare)
  |> should.equal(-0.75)
}

pub fn int_minimum_test() {
  piecewise.minimum(75, 50, int.compare)
  |> should.equal(50)

  piecewise.minimum(50, 75, int.compare)
  |> should.equal(50)

  piecewise.minimum(-75, 50, int.compare)
  |> should.equal(-75)

  piecewise.minimum(-75, 50, int.compare)
  |> should.equal(-75)
}

pub fn float_maximum_test() {
  piecewise.maximum(0.75, 0.5, float.compare)
  |> should.equal(0.75)

  piecewise.maximum(0.5, 0.75, float.compare)
  |> should.equal(0.75)

  piecewise.maximum(-0.75, 0.5, float.compare)
  |> should.equal(0.5)

  piecewise.maximum(-0.75, 0.5, float.compare)
  |> should.equal(0.5)
}

pub fn int_maximum_test() {
  piecewise.maximum(75, 50, int.compare)
  |> should.equal(75)

  piecewise.maximum(50, 75, int.compare)
  |> should.equal(75)

  piecewise.maximum(-75, 50, int.compare)
  |> should.equal(50)

  piecewise.maximum(-75, 50, int.compare)
  |> should.equal(50)
}

pub fn float_minmax_test() {
  piecewise.minmax(0.75, 0.5, float.compare)
  |> should.equal(#(0.5, 0.75))

  piecewise.minmax(0.5, 0.75, float.compare)
  |> should.equal(#(0.5, 0.75))

  piecewise.minmax(-0.75, 0.5, float.compare)
  |> should.equal(#(-0.75, 0.5))

  piecewise.minmax(-0.75, 0.5, float.compare)
  |> should.equal(#(-0.75, 0.5))
}

pub fn int_minmax_test() {
  piecewise.minmax(75, 50, int.compare)
  |> should.equal(#(50, 75))

  piecewise.minmax(50, 75, int.compare)
  |> should.equal(#(50, 75))

  piecewise.minmax(-75, 50, int.compare)
  |> should.equal(#(-75, 50))

  piecewise.minmax(-75, 50, int.compare)
  |> should.equal(#(-75, 50))
}

pub fn float_list_minimum_test() {
  // An empty lists returns an error
  []
  |> piecewise.list_minimum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> piecewise.list_minimum(float.compare)
  |> should.equal(Ok(1.5))
}

pub fn int_list_minimum_test() {
  // An empty lists returns an error
  []
  |> piecewise.list_minimum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> piecewise.list_minimum(int.compare)
  |> should.equal(Ok(1))
}

pub fn float_list_maximum_test() {
  // An empty lists returns an error
  []
  |> piecewise.list_maximum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> piecewise.list_maximum(float.compare)
  |> should.equal(Ok(4.5))
}

pub fn int_list_maximum_test() {
  // An empty lists returns an error
  []
  |> piecewise.list_maximum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> piecewise.list_maximum(int.compare)
  |> should.equal(Ok(4))
}

pub fn float_list_arg_maximum_test() {
  // An empty lists returns an error
  []
  |> piecewise.arg_maximum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> piecewise.arg_maximum(float.compare)
  |> should.equal(Ok([0, 1]))
}

pub fn int_list_arg_maximum_test() {
  // An empty lists returns an error
  []
  |> piecewise.arg_maximum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> piecewise.arg_maximum(int.compare)
  |> should.equal(Ok([0, 1]))
}

pub fn float_list_arg_minimum_test() {
  // An empty lists returns an error
  []
  |> piecewise.arg_minimum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> piecewise.arg_minimum(float.compare)
  |> should.equal(Ok([4]))
}

pub fn int_list_arg_minimum_test() {
  // An empty lists returns an error
  []
  |> piecewise.arg_minimum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> piecewise.arg_minimum(int.compare)
  |> should.equal(Ok([4]))
}

pub fn float_list_extrema_test() {
  // An empty lists returns an error
  []
  |> piecewise.extrema(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> piecewise.extrema(float.compare)
  |> should.equal(Ok(#(1.0, 4.0)))

  // Valid input returns a result
  [1.0, 4.0, 2.0, 5.0, 0.0]
  |> piecewise.extrema(float.compare)
  |> should.equal(Ok(#(0.0, 5.0)))
}

pub fn int_list_extrema_test() {
  // An empty lists returns an error
  []
  |> piecewise.extrema(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> piecewise.extrema(int.compare)
  |> should.equal(Ok(#(1, 4)))

  // Valid input returns a result
  [1, 4, 2, 5, 0]
  |> piecewise.extrema(int.compare)
  |> should.equal(Ok(#(0, 5)))
}
