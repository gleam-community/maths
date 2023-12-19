import gleam_community/maths/elementary
import gleam_community/maths/sequences
import gleam_community/maths/predicates
import gleam/list
import gleeunit/should

pub fn float_list_linear_space_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  let assert Ok(linspace) = sequences.linear_space(10.0, 50.0, 5, True)
  let assert Ok(result) =
    predicates.all_close(linspace, [10.0, 20.0, 30.0, 40.0, 50.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = sequences.linear_space(10.0, 20.0, 5, True)
  let assert Ok(result) =
    predicates.all_close(linspace, [10.0, 12.5, 15.0, 17.5, 20.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  // ----> Without endpoint included
  let assert Ok(linspace) = sequences.linear_space(10.0, 50.0, 5, False)
  let assert Ok(result) =
    predicates.all_close(linspace, [10.0, 18.0, 26.0, 34.0, 42.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = sequences.linear_space(10.0, 20.0, 5, False)
  let assert Ok(result) =
    predicates.all_close(linspace, [10.0, 12.0, 14.0, 16.0, 18.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  let assert Ok(linspace) = sequences.linear_space(10.0, -50.0, 5, False)
  let assert Ok(result) =
    predicates.all_close(linspace, [10.0, -2.0, -14.0, -26.0, -38.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = sequences.linear_space(10.0, -20.0, 5, True)
  let assert Ok(result) =
    predicates.all_close(linspace, [10.0, 2.5, -5.0, -12.5, -20.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative start
  let assert Ok(linspace) = sequences.linear_space(-10.0, 50.0, 5, False)
  let assert Ok(result) =
    predicates.all_close(linspace, [-10.0, 2.0, 14.0, 26.0, 38.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = sequences.linear_space(-10.0, 20.0, 5, True)
  let assert Ok(result) =
    predicates.all_close(linspace, [-10.0, -2.5, 5.0, 12.5, 20.0], 0.0, tol)

  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // A negative number of points does not work (-5)
  sequences.linear_space(10.0, 50.0, -5, True)
  |> should.be_error()
}

pub fn float_list_logarithmic_space_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop, base
  let assert Ok(logspace) = sequences.logarithmic_space(1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    predicates.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, stop, negative base
  let assert Ok(logspace) =
    sequences.logarithmic_space(1.0, 3.0, 3, True, -10.0)
  let assert Ok(result) =
    predicates.all_close(logspace, [-10.0, 100.0, -1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop, base 
  let assert Ok(logspace) =
    sequences.logarithmic_space(1.0, -3.0, 3, True, -10.0)
  let assert Ok(result) =
    predicates.all_close(logspace, [-10.0, -0.1, -0.001], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, base, negative stop  
  let assert Ok(logspace) =
    sequences.logarithmic_space(1.0, -3.0, 3, True, 10.0)
  let assert Ok(result) =
    predicates.all_close(logspace, [10.0, 0.1, 0.001], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, base, negative start
  let assert Ok(logspace) =
    sequences.logarithmic_space(-1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    predicates.all_close(logspace, [0.1, 10.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop, base
  let assert Ok(logspace) =
    sequences.logarithmic_space(1.0, 3.0, 3, False, 10.0)
  let assert Ok(result) =
    predicates.all_close(logspace, [10.0, 46.41588834, 215.443469], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // A negative number of points does not work (-3)
  sequences.logarithmic_space(1.0, 3.0, -3, True, 10.0)
  |> should.be_error()
}

pub fn float_list_geometric_space_test() {
  let assert Ok(tol) = elementary.power(-10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = sequences.geometric_space(10.0, 1000.0, 3, True)
  let assert Ok(result) =
    predicates.all_close(logspace, [10.0, 100.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop  
  let assert Ok(logspace) = sequences.geometric_space(10.0, 0.001, 3, True)
  let assert Ok(result) =
    predicates.all_close(logspace, [10.0, 0.1, 0.001], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, negative start
  let assert Ok(logspace) = sequences.geometric_space(0.1, 1000.0, 3, True)
  let assert Ok(result) =
    predicates.all_close(logspace, [0.1, 10.0, 1000.0], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = sequences.geometric_space(10.0, 1000.0, 3, False)
  let assert Ok(result) =
    predicates.all_close(logspace, [10.0, 46.41588834, 215.443469], 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Test invalid input (start and stop can't be equal to 0.0)
  sequences.geometric_space(0.0, 1000.0, 3, False)
  |> should.be_error()

  sequences.geometric_space(-1000.0, 0.0, 3, False)
  |> should.be_error()

  // A negative number of points does not work
  sequences.geometric_space(-1000.0, 0.0, -3, False)
  |> should.be_error()
}

pub fn float_list_arange_test() {
  // Positive start, stop, step
  sequences.arange(1.0, 5.0, 1.0)
  |> should.equal([1.0, 2.0, 3.0, 4.0])

  sequences.arange(1.0, 5.0, 0.5)
  |> should.equal([1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5])

  sequences.arange(1.0, 2.0, 0.25)
  |> should.equal([1.0, 1.25, 1.5, 1.75])

  // Reverse (switch start/stop largest/smallest value)
  sequences.arange(5.0, 1.0, 1.0)
  |> should.equal([])

  // Reverse negative step
  sequences.arange(5.0, 1.0, -1.0)
  |> should.equal([5.0, 4.0, 3.0, 2.0])

  // Positive start, negative stop, step
  sequences.arange(5.0, -1.0, -1.0)
  |> should.equal([5.0, 4.0, 3.0, 2.0, 1.0, 0.0])

  // Negative start, stop, step
  sequences.arange(-5.0, -1.0, -1.0)
  |> should.equal([])

  // Negative start, stop, positive step
  sequences.arange(-5.0, -1.0, 1.0)
  |> should.equal([-5.0, -4.0, -3.0, -2.0])
}
