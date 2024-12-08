import gleam/float
import gleam/int
import gleam_community/maths
import gleeunit/should

pub fn ceiling_test() {
  // Round 3. digit AFTER decimal point 
  maths.round_up(12.0654, 3)
  |> should.equal(12.066)

  // Round 2. digit AFTER decimal point 
  maths.round_up(12.0654, 2)
  |> should.equal(12.07)

  // Round 1. digit AFTER decimal point 
  maths.round_up(12.0654, 1)
  |> should.equal(12.1)

  // Round 0. digit BEFORE decimal point 
  maths.round_up(12.0654, 0)
  |> should.equal(13.0)

  // Round 1. digit BEFORE decimal point 
  maths.round_up(12.0654, -1)
  |> should.equal(20.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_up(12.0654, -2)
  |> should.equal(100.0)

  // Round 3. digit BEFORE decimal point 
  maths.round_up(12.0654, -3)
  |> should.equal(1000.0)
}

pub fn floor_test() {
  // Round 3. digit AFTER decimal point 
  maths.round_down(12.0654, 3)
  |> should.equal(12.065)

  // Round 2. digit AFTER decimal point 
  maths.round_down(12.0654, 2)
  |> should.equal(12.06)

  // Round 1. digit AFTER decimal point 
  maths.round_down(12.0654, 1)
  |> should.equal(12.0)

  // Round 0. digit BEFORE decimal point 
  maths.round_down(12.0654, 0)
  |> should.equal(12.0)

  // Round 1. digit BEFORE decimal point 
  maths.round_down(12.0654, -1)
  |> should.equal(10.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_down(12.0654, -2)
  |> should.equal(0.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_down(12.0654, -3)
  |> should.equal(0.0)
}

pub fn truncate_test() {
  // Round 3. digit AFTER decimal point 
  maths.round_to_zero(12.0654, 3)
  |> should.equal(12.065)

  // Round 2. digit AFTER decimal point 
  maths.round_to_zero(12.0654, 2)
  |> should.equal(12.06)

  // Round 1. digit AFTER decimal point 
  maths.round_to_zero(12.0654, 1)
  |> should.equal(12.0)

  // Round 0. digit BEFORE decimal point 
  maths.round_to_zero(12.0654, 0)
  |> should.equal(12.0)

  // Round 1. digit BEFORE decimal point 
  maths.round_to_zero(12.0654, -1)
  |> should.equal(10.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_to_zero(12.0654, -2)
  |> should.equal(0.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_to_zero(12.0654, -3)
  |> should.equal(0.0)
}

pub fn math_round_to_nearest_test() {
  // Try with positive values
  maths.round_to_nearest(1.5, 0)
  |> should.equal(2.0)

  maths.round_to_nearest(1.75, 0)
  |> should.equal(2.0)

  maths.round_to_nearest(2.0, 0)
  |> should.equal(2.0)

  maths.round_to_nearest(3.5, 0)
  |> should.equal(4.0)

  maths.round_to_nearest(4.5, 0)
  |> should.equal(4.0)

  // Try with negative values
  maths.round_to_nearest(-3.5, 0)
  |> should.equal(-4.0)

  maths.round_to_nearest(-4.5, 0)
  |> should.equal(-4.0)

  // // Round 3. digit AFTER decimal point 
  maths.round_to_nearest(12.0654, 3)
  |> should.equal(12.065)

  // Round 2. digit AFTER decimal point 
  maths.round_to_nearest(12.0654, 2)
  |> should.equal(12.07)

  // Round 1. digit AFTER decimal point 
  maths.round_to_nearest(12.0654, 1)
  |> should.equal(12.1)

  // Round 0. digit BEFORE decimal point 
  maths.round_to_nearest(12.0654, 0)
  |> should.equal(12.0)

  // Round 1. digit BEFORE decimal point 
  maths.round_to_nearest(12.0654, -1)
  |> should.equal(10.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_to_nearest(12.0654, -2)
  |> should.equal(0.0)

  // Round 3. digit BEFORE decimal point 
  maths.round_to_nearest(12.0654, -3)
  |> should.equal(0.0)
}

pub fn math_round_up_test() {
  // Try with positive values
  maths.round_up(0.45, 0)
  |> should.equal(1.0)

  maths.round_up(0.5, 0)
  |> should.equal(1.0)

  maths.round_up(0.45, 1)
  |> should.equal(0.5)

  maths.round_up(0.5, 1)
  |> should.equal(0.5)

  maths.round_up(0.455, 2)
  |> should.equal(0.46)

  maths.round_up(0.505, 2)
  |> should.equal(0.51)

  // Try with negative values
  maths.round_up(-0.45, 0)
  |> should.equal(-0.0)

  maths.round_up(-0.5, 0)
  |> should.equal(-0.0)

  maths.round_up(-0.45, 1)
  |> should.equal(-0.4)

  maths.round_up(-0.5, 1)
  |> should.equal(-0.5)

  maths.round_up(-0.455, 2)
  |> should.equal(-0.45)

  maths.round_up(-0.505, 2)
  |> should.equal(-0.5)
}

pub fn math_round_down_test() {
  // Try with positive values
  maths.round_down(0.45, 0)
  |> should.equal(0.0)

  maths.round_down(0.5, 0)
  |> should.equal(0.0)

  maths.round_down(0.45, 1)
  |> should.equal(0.4)

  maths.round_down(0.5, 1)
  |> should.equal(0.5)

  maths.round_down(0.455, 2)
  |> should.equal(0.45)

  maths.round_down(0.505, 2)
  |> should.equal(0.5)

  // Try with negative values
  maths.round_down(-0.45, 0)
  |> should.equal(-1.0)

  maths.round_down(-0.5, 0)
  |> should.equal(-1.0)

  maths.round_down(-0.45, 1)
  |> should.equal(-0.5)

  maths.round_down(-0.5, 1)
  |> should.equal(-0.5)

  maths.round_down(-0.455, 2)
  |> should.equal(-0.46)

  maths.round_down(-0.505, 2)
  |> should.equal(-0.51)
}

pub fn math_round_to_zero_test() {
  // Note: Rounding mode "RoundToZero" is an alias for the truncate function
  // Try with positive values
  maths.round_to_zero(0.5, 0)
  |> should.equal(0.0)

  maths.round_to_zero(0.75, 0)
  |> should.equal(0.0)

  maths.round_to_zero(0.45, 1)
  |> should.equal(0.4)

  maths.round_to_zero(0.57, 1)
  |> should.equal(0.5)

  maths.round_to_zero(0.4575, 2)
  |> should.equal(0.45)

  maths.round_to_zero(0.5075, 2)
  |> should.equal(0.5)

  // Try with negative values
  maths.round_to_zero(-0.5, 0)
  |> should.equal(0.0)

  maths.round_to_zero(-0.75, 0)
  |> should.equal(0.0)

  maths.round_to_zero(-0.45, 1)
  |> should.equal(-0.4)

  maths.round_to_zero(-0.57, 1)
  |> should.equal(-0.5)

  maths.round_to_zero(-0.4575, 2)
  |> should.equal(-0.45)

  maths.round_to_zero(-0.5075, 2)
  |> should.equal(-0.5)
}

pub fn math_round_ties_away_test() {
  // Try with positive values
  maths.round_ties_away(1.4, 0)
  |> should.equal(1.0)

  maths.round_ties_away(1.5, 0)
  |> should.equal(2.0)

  maths.round_ties_away(2.5, 0)
  |> should.equal(3.0)

  // Try with negative values
  maths.round_ties_away(-1.4, 0)
  |> should.equal(-1.0)

  maths.round_ties_away(-1.5, 0)
  |> should.equal(-2.0)

  maths.round_ties_away(-2.0, 0)
  |> should.equal(-2.0)

  maths.round_ties_away(-2.5, 0)
  |> should.equal(-3.0)

  // Round 3. digit AFTER decimal point 
  maths.round_ties_away(12.0654, 3)
  |> should.equal(12.065)

  // Round 2. digit AFTER decimal point 
  maths.round_ties_away(12.0654, 2)
  |> should.equal(12.07)

  // Round 1. digit AFTER decimal point 
  maths.round_ties_away(12.0654, 1)
  |> should.equal(12.1)

  // Round 0. digit BEFORE decimal point 
  maths.round_ties_away(12.0654, 0)
  |> should.equal(12.0)

  // Round 1. digit BEFORE decimal point 
  maths.round_ties_away(12.0654, -1)
  |> should.equal(10.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_ties_away(12.0654, -2)
  |> should.equal(0.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_ties_away(12.0654, -3)
  |> should.equal(0.0)
}

pub fn math_round_ties_up_test() {
  // Try with positive values
  maths.round_ties_up(1.4, 0)
  |> should.equal(1.0)

  maths.round_ties_up(1.5, 0)
  |> should.equal(2.0)

  maths.round_ties_up(2.5, 0)
  |> should.equal(3.0)

  // Try with negative values
  maths.round_ties_up(-1.4, 0)
  |> should.equal(-1.0)

  maths.round_ties_up(-1.5, 0)
  |> should.equal(-1.0)

  maths.round_ties_up(-2.0, 0)
  |> should.equal(-2.0)

  maths.round_ties_up(-2.5, 0)
  |> should.equal(-2.0)

  // Round 3. digit AFTER decimal point 
  maths.round_ties_up(12.0654, 3)
  |> should.equal(12.065)

  // Round 2. digit AFTER decimal point 
  maths.round_ties_up(12.0654, 2)
  |> should.equal(12.07)

  // Round 1. digit AFTER decimal point 
  maths.round_ties_up(12.0654, 1)
  |> should.equal(12.1)

  // Round 0. digit BEFORE decimal point 
  maths.round_ties_up(12.0654, 0)
  |> should.equal(12.0)

  // Round 1. digit BEFORE decimal point 
  maths.round_ties_up(12.0654, -1)
  |> should.equal(10.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_ties_up(12.0654, -2)
  |> should.equal(0.0)

  // Round 2. digit BEFORE decimal point 
  maths.round_ties_up(12.0654, -3)
  |> should.equal(0.0)
}

pub fn absolute_difference_test() {
  maths.absolute_difference(20.0, 15.0)
  |> should.equal(5.0)

  maths.absolute_difference(-20.0, -15.0)
  |> should.equal(5.0)

  maths.absolute_difference(20.0, -15.0)
  |> should.equal(35.0)

  maths.absolute_difference(-20.0, 15.0)
  |> should.equal(35.0)

  maths.absolute_difference(0.0, 0.0)
  |> should.equal(0.0)

  maths.absolute_difference(1.0, 2.0)
  |> should.equal(1.0)

  maths.absolute_difference(2.0, 1.0)
  |> should.equal(1.0)

  maths.absolute_difference(-1.0, 0.0)
  |> should.equal(1.0)

  maths.absolute_difference(0.0, -1.0)
  |> should.equal(1.0)

  maths.absolute_difference(10.0, 20.0)
  |> should.equal(10.0)

  maths.absolute_difference(-10.0, -20.0)
  |> should.equal(10.0)

  maths.absolute_difference(-10.5, 10.5)
  |> should.equal(21.0)
}

pub fn int_absolute_difference_test() {
  maths.int_absolute_difference(20, 15)
  |> should.equal(5)

  maths.int_absolute_difference(-20, -15)
  |> should.equal(5)

  maths.int_absolute_difference(20, -15)
  |> should.equal(35)

  maths.int_absolute_difference(-20, 15)
  |> should.equal(35)
}

pub fn sign_test() {
  maths.sign(100.0)
  |> should.equal(1.0)

  maths.sign(0.0)
  |> should.equal(0.0)

  maths.sign(-100.0)
  |> should.equal(-1.0)
}

pub fn flip_sign_test() {
  maths.flip_sign(100.0)
  |> should.equal(-100.0)

  maths.flip_sign(0.0)
  |> should.equal(-0.0)

  maths.flip_sign(-100.0)
  |> should.equal(100.0)
}

pub fn copy_sign_test() {
  maths.copy_sign(100.0, 10.0)
  |> should.equal(100.0)

  maths.copy_sign(-100.0, 10.0)
  |> should.equal(100.0)

  maths.copy_sign(100.0, -10.0)
  |> should.equal(-100.0)

  maths.copy_sign(-100.0, -10.0)
  |> should.equal(-100.0)
}

pub fn int_sign_test() {
  maths.int_sign(100)
  |> should.equal(1)

  maths.int_sign(0)
  |> should.equal(0)

  maths.int_sign(-100)
  |> should.equal(-1)
}

pub fn int_flip_sign_test() {
  maths.int_flip_sign(100)
  |> should.equal(-100)

  maths.int_flip_sign(0)
  |> should.equal(-0)

  maths.int_flip_sign(-100)
  |> should.equal(100)
}

pub fn int_copy_sign_test() {
  maths.int_copy_sign(100, 10)
  |> should.equal(100)

  maths.int_copy_sign(-100, 10)
  |> should.equal(100)

  maths.int_copy_sign(100, -10)
  |> should.equal(-100)

  maths.int_copy_sign(-100, -10)
  |> should.equal(-100)
}

pub fn minmax_test() {
  maths.minmax(0.75, 0.5, float.compare)
  |> should.equal(#(0.5, 0.75))

  maths.minmax(0.5, 0.75, float.compare)
  |> should.equal(#(0.5, 0.75))

  maths.minmax(-0.75, 0.5, float.compare)
  |> should.equal(#(-0.75, 0.5))

  maths.minmax(-0.75, 0.5, float.compare)
  |> should.equal(#(-0.75, 0.5))
}

pub fn int_minmax_test() {
  maths.minmax(75, 50, int.compare)
  |> should.equal(#(50, 75))

  maths.minmax(50, 75, int.compare)
  |> should.equal(#(50, 75))

  maths.minmax(-75, 50, int.compare)
  |> should.equal(#(-75, 50))

  maths.minmax(-75, 50, int.compare)
  |> should.equal(#(-75, 50))
}

pub fn list_minimum_test() {
  // An empty lists returns an error
  []
  |> maths.list_minimum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> maths.list_minimum(float.compare)
  |> should.equal(Ok(1.5))
}

pub fn int_list_minimum_test() {
  // An empty lists returns an error
  []
  |> maths.list_minimum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> maths.list_minimum(int.compare)
  |> should.equal(Ok(1))
}

pub fn list_maximum_test() {
  // An empty lists returns an error
  []
  |> maths.list_maximum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> maths.list_maximum(float.compare)
  |> should.equal(Ok(4.5))
}

pub fn int_list_maximum_test() {
  // An empty lists returns an error
  []
  |> maths.list_maximum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> maths.list_maximum(int.compare)
  |> should.equal(Ok(4))
}

pub fn list_arg_maximum_test() {
  // An empty lists returns an error
  []
  |> maths.arg_maximum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> maths.arg_maximum(float.compare)
  |> should.equal(Ok([0, 1]))
}

pub fn int_list_arg_maximum_test() {
  // An empty lists returns an error
  []
  |> maths.arg_maximum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> maths.arg_maximum(int.compare)
  |> should.equal(Ok([0, 1]))
}

pub fn list_arg_minimum_test() {
  // An empty lists returns an error
  []
  |> maths.arg_minimum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.5, 4.5, 3.5, 2.5, 1.5]
  |> maths.arg_minimum(float.compare)
  |> should.equal(Ok([4]))
}

pub fn int_list_arg_minimum_test() {
  // An empty lists returns an error
  []
  |> maths.arg_minimum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> maths.arg_minimum(int.compare)
  |> should.equal(Ok([4]))
}

pub fn list_extrema_test() {
  // An empty lists returns an error
  []
  |> maths.extrema(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> maths.extrema(float.compare)
  |> should.equal(Ok(#(1.0, 4.0)))

  // Valid input returns a result
  [1.0, 4.0, 2.0, 5.0, 0.0]
  |> maths.extrema(float.compare)
  |> should.equal(Ok(#(0.0, 5.0)))
}

pub fn int_list_extrema_test() {
  // An empty lists returns an error
  []
  |> maths.extrema(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> maths.extrema(int.compare)
  |> should.equal(Ok(#(1, 4)))

  // Valid input returns a result
  [1, 4, 2, 5, 0]
  |> maths.extrema(int.compare)
  |> should.equal(Ok(#(0, 5)))
}
