import gleam/float
import gleam/list
import gleam/yielder
import gleam_community/maths
import gleeunit/should

pub fn yield_linear_space_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  let assert Ok(linspace) = maths.yield_linear_space(10.0, 50.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([10.0, 20.0, 30.0, 40.0, 50.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.yield_linear_space(10.0, 20.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([10.0, 12.5, 15.0, 17.5, 20.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  // ----> Without endpoint included
  let assert Ok(linspace) = maths.yield_linear_space(10.0, 50.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([10.0, 18.0, 26.0, 34.0, 42.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.yield_linear_space(10.0, 20.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([10.0, 12.0, 14.0, 16.0, 18.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  let assert Ok(linspace) = maths.yield_linear_space(10.0, -50.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace
        |> yielder.to_list()
        |> list.zip([10.0, -2.0, -14.0, -26.0, -38.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.yield_linear_space(10.0, -20.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace
        |> yielder.to_list()
        |> list.zip([10.0, 2.5, -5.0, -12.5, -20.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative start
  let assert Ok(linspace) = maths.yield_linear_space(-10.0, 50.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([-10.0, 2.0, 14.0, 26.0, 38.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.yield_linear_space(-10.0, 20.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([-10.0, -2.5, 5.0, 12.5, 20.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when start == stop and steps > 0, then 
  // the value (start/stop) is just repeated, since the
  // step increment will be 0 
  let assert Ok(linspace) = maths.yield_linear_space(10.0, 10.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([10.0, 10.0, 10.0, 10.0, 10.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.yield_linear_space(10.0, 10.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> yielder.to_list() |> list.zip([10.0, 10.0, 10.0, 10.0, 10.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // A negative number of points does not work (-5)
  maths.yield_linear_space(10.0, 50.0, -5, True)
  |> should.be_error()
}

pub fn list_linear_space_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  let assert Ok(linspace) = maths.linear_space(10.0, 50.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([10.0, 20.0, 30.0, 40.0, 50.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.linear_space(10.0, 20.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([10.0, 12.5, 15.0, 17.5, 20.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  // ----> Without endpoint included
  let assert Ok(linspace) = maths.linear_space(10.0, 50.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([10.0, 18.0, 26.0, 34.0, 42.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.linear_space(10.0, 20.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([10.0, 12.0, 14.0, 16.0, 18.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative stop
  let assert Ok(linspace) = maths.linear_space(10.0, -50.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace
        |> list.zip([10.0, -2.0, -14.0, -26.0, -38.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.linear_space(10.0, -20.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace
        |> list.zip([10.0, 2.5, -5.0, -12.5, -20.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Try with negative start
  let assert Ok(linspace) = maths.linear_space(-10.0, 50.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([-10.0, 2.0, 14.0, 26.0, 38.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.linear_space(-10.0, 20.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([-10.0, -2.5, 5.0, 12.5, 20.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when start == stop and steps > 0, then 
  // the value (start/stop) is just repeated, since the
  // step increment will be 0 
  let assert Ok(linspace) = maths.linear_space(10.0, 10.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([10.0, 10.0, 10.0, 10.0, 10.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(linspace) = maths.linear_space(10.0, 10.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      linspace |> list.zip([10.0, 10.0, 10.0, 10.0, 10.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // A negative number of points does not work (-5)
  maths.linear_space(10.0, 50.0, -5, True)
  |> should.be_error()
}

pub fn yield_logarithmic_space_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop
  let assert Ok(logspace) =
    maths.yield_logarithmic_space(1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    maths.all_close(
      logspace |> yielder.to_list() |> list.zip([10.0, 100.0, 1000.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop 
  let assert Ok(logspace) =
    maths.yield_logarithmic_space(1.0, -3.0, 3, True, 10.0)
  let assert Ok(result) =
    maths.all_close(
      logspace |> yielder.to_list() |> list.zip([10.0, 0.1, 0.001]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, negative start
  let assert Ok(logspace) =
    maths.yield_logarithmic_space(-1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    maths.all_close(
      logspace |> yielder.to_list() |> list.zip([0.1, 10.0, 1000.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop
  let assert Ok(logspace) =
    maths.yield_logarithmic_space(1.0, 3.0, 3, False, 10.0)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> yielder.to_list()
        |> list.zip([10.0, 46.41588834, 215.443469]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when start == stop and steps > 0, then 
  // the value (start/stop) is just repeated, since the
  // step increment will be 0 
  let assert Ok(logspace) =
    maths.yield_logarithmic_space(5.0, 5.0, 5, True, 5.0)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> yielder.to_list()
        |> list.zip([3125.0, 3125.0, 3125.0, 3125.0, 3125.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()
  let assert Ok(logspace) =
    maths.yield_logarithmic_space(5.0, 5.0, 5, False, 5.0)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> yielder.to_list()
        |> list.zip([3125.0, 3125.0, 3125.0, 3125.0, 3125.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // A negative number of points does not work (-3)
  maths.yield_logarithmic_space(1.0, 3.0, -3, True, 10.0)
  |> should.be_error()

  // A negative base does not work (-10)
  maths.yield_logarithmic_space(1.0, 3.0, 3, True, -10.0)
  |> should.be_error()
}

pub fn list_logarithmic_space_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = maths.logarithmic_space(1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    maths.all_close(logspace |> list.zip([10.0, 100.0, 1000.0]), 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop 
  let assert Ok(logspace) = maths.logarithmic_space(1.0, -3.0, 3, True, 10.0)
  let assert Ok(result) =
    maths.all_close(logspace |> list.zip([10.0, 0.1, 0.001]), 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, negative start
  let assert Ok(logspace) = maths.logarithmic_space(-1.0, 3.0, 3, True, 10.0)
  let assert Ok(result) =
    maths.all_close(logspace |> list.zip([0.1, 10.0, 1000.0]), 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = maths.logarithmic_space(1.0, 3.0, 3, False, 10.0)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> list.zip([10.0, 46.41588834, 215.443469]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when start == stop and steps > 0, then 
  // the value (start/stop) is just repeated, since the
  // step increment will be 0 
  let assert Ok(logspace) = maths.logarithmic_space(5.0, 5.0, 5, True, 5.0)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> list.zip([3125.0, 3125.0, 3125.0, 3125.0, 3125.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()
  let assert Ok(logspace) = maths.logarithmic_space(5.0, 5.0, 5, False, 5.0)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> list.zip([3125.0, 3125.0, 3125.0, 3125.0, 3125.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // A negative number of points does not work (-3)
  maths.logarithmic_space(1.0, 3.0, -3, True, 10.0)
  |> should.be_error()

  // A negative base does not work (-10)
  maths.logarithmic_space(1.0, 3.0, 3, True, -10.0)
  |> should.be_error()
}

pub fn yield_geometric_space_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = maths.yield_geometric_space(10.0, 1000.0, 3, True)
  let assert Ok(result) =
    maths.all_close(
      logspace |> yielder.to_list() |> list.zip([10.0, 100.0, 1000.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop  
  let assert Ok(logspace) = maths.yield_geometric_space(10.0, 0.001, 3, True)
  let assert Ok(result) =
    maths.all_close(
      logspace |> yielder.to_list() |> list.zip([10.0, 0.1, 0.001]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, negative start
  let assert Ok(logspace) = maths.yield_geometric_space(0.1, 1000.0, 3, True)
  let assert Ok(result) =
    maths.all_close(
      logspace |> yielder.to_list() |> list.zip([0.1, 10.0, 1000.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = maths.yield_geometric_space(10.0, 1000.0, 3, False)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> yielder.to_list()
        |> list.zip([10.0, 46.41588834, 215.443469]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when start == stop and steps > 0, then 
  // the value (start/stop) is just repeated, since the
  // step increment will be 0
  let assert Ok(logspace) = maths.yield_geometric_space(5.0, 5.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> yielder.to_list()
        |> list.zip([5.0, 5.0, 5.0, 5.0, 5.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(logspace) = maths.yield_geometric_space(5.0, 5.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> yielder.to_list()
        |> list.zip([5.0, 5.0, 5.0, 5.0, 5.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Test invalid input (start and stop can't be less than or equal to 0.0)
  maths.yield_geometric_space(0.0, 1000.0, 3, False)
  |> should.be_error()

  maths.yield_geometric_space(-1000.0, 0.0, 3, False)
  |> should.be_error()

  // A negative number of points does not work
  maths.yield_geometric_space(-1000.0, 0.0, -3, False)
  |> should.be_error()
}

pub fn list_geometric_space_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  // ---> With endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = maths.geometric_space(10.0, 1000.0, 3, True)
  let assert Ok(result) =
    maths.all_close(logspace |> list.zip([10.0, 100.0, 1000.0]), 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive start, negative stop  
  let assert Ok(logspace) = maths.geometric_space(10.0, 0.001, 3, True)
  let assert Ok(result) =
    maths.all_close(logspace |> list.zip([10.0, 0.1, 0.001]), 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // - Positive stop, negative start
  let assert Ok(logspace) = maths.geometric_space(0.1, 1000.0, 3, True)
  let assert Ok(result) =
    maths.all_close(logspace |> list.zip([0.1, 10.0, 1000.0]), 0.0, tol)
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // ----> Without endpoint included
  // - Positive start, stop
  let assert Ok(logspace) = maths.geometric_space(10.0, 1000.0, 3, False)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> list.zip([10.0, 46.41588834, 215.443469]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when start == stop and steps > 0, then 
  // the value (start/stop) is just repeated, since the
  // step increment will be 0
  let assert Ok(logspace) = maths.geometric_space(5.0, 5.0, 5, True)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> list.zip([5.0, 5.0, 5.0, 5.0, 5.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  let assert Ok(logspace) = maths.geometric_space(5.0, 5.0, 5, False)
  let assert Ok(result) =
    maths.all_close(
      logspace
        |> list.zip([5.0, 5.0, 5.0, 5.0, 5.0]),
      0.0,
      tol,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Test invalid input (start and stop can't be less than or equal to 0.0)
  maths.geometric_space(0.0, 1000.0, 3, False)
  |> should.be_error()

  maths.geometric_space(-1000.0, 0.0, 3, False)
  |> should.be_error()

  // A negative number of points does not work
  maths.geometric_space(-1000.0, 0.0, -3, False)
  |> should.be_error()
}

pub fn list_step_range_test() {
  // Positive start, stop, step
  maths.step_range(1.0, 5.0, 1.0)
  |> should.equal([1.0, 2.0, 3.0, 4.0])

  maths.step_range(1.0, 5.0, 0.5)
  |> should.equal([1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5])

  maths.step_range(1.0, 2.0, 0.25)
  |> should.equal([1.0, 1.25, 1.5, 1.75])

  // Reverse (switch start/stop largest/smallest value)
  maths.step_range(5.0, 1.0, 1.0)
  |> should.equal([])

  // Reverse negative step
  maths.step_range(5.0, 1.0, -1.0)
  |> should.equal([5.0, 4.0, 3.0, 2.0])

  // Positive start, negative stop, step
  maths.step_range(5.0, -1.0, -1.0)
  |> should.equal([5.0, 4.0, 3.0, 2.0, 1.0, 0.0])

  // Negative start, stop, step
  maths.step_range(-5.0, -1.0, -1.0)
  |> should.equal([])

  // Negative start, stop, positive step
  maths.step_range(-5.0, -1.0, 1.0)
  |> should.equal([-5.0, -4.0, -3.0, -2.0])
}

pub fn yield_step_range_test() {
  // Positive start, stop, step
  maths.yield_step_range(1.0, 5.0, 1.0)
  |> yielder.to_list()
  |> should.equal([1.0, 2.0, 3.0, 4.0])

  maths.yield_step_range(1.0, 5.0, 0.5)
  |> yielder.to_list()
  |> should.equal([1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5])

  maths.yield_step_range(1.0, 2.0, 0.25)
  |> yielder.to_list()
  |> should.equal([1.0, 1.25, 1.5, 1.75])

  // Reverse (switch start/stop largest/smallest value)
  maths.yield_step_range(5.0, 1.0, 1.0)
  |> yielder.to_list()
  |> should.equal([])

  // Reverse negative step
  maths.yield_step_range(5.0, 1.0, -1.0)
  |> yielder.to_list()
  |> should.equal([5.0, 4.0, 3.0, 2.0])

  // Positive start, negative stop, step
  maths.yield_step_range(5.0, -1.0, -1.0)
  |> yielder.to_list()
  |> should.equal([5.0, 4.0, 3.0, 2.0, 1.0, 0.0])

  // Negative start, stop, step
  maths.yield_step_range(-5.0, -1.0, -1.0)
  |> yielder.to_list()
  |> should.equal([])

  // Negative start, stop, positive step
  maths.yield_step_range(-5.0, -1.0, 1.0)
  |> yielder.to_list()
  |> should.equal([-5.0, -4.0, -3.0, -2.0])
}

pub fn yield_symmetric_space_test() {
  let assert Ok(tolerance) = float.power(10.0, -6.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(sym_space) = maths.yield_symmetric_space(0.0, 5.0, 5)
  sym_space
  |> yielder.to_list()
  |> should.equal([-5.0, -2.5, 0.0, 2.5, 5.0])

  let assert Ok(sym_space) = maths.yield_symmetric_space(0.0, 5.0, 5)
  sym_space
  |> yielder.to_list()
  |> should.equal([-5.0, -2.5, 0.0, 2.5, 5.0])

  // Negative center
  let assert Ok(sym_space) = maths.yield_symmetric_space(-10.0, 5.0, 5)
  sym_space
  |> yielder.to_list()
  |> should.equal([-15.0, -12.5, -10.0, -7.5, -5.0])

  // Negative Radius (simply reverses the order of the values)
  let assert Ok(sym_space) = maths.yield_symmetric_space(0.0, -5.0, 5)
  sym_space
  |> yielder.to_list()
  |> should.equal([5.0, 2.5, 0.0, -2.5, -5.0])

  // Uneven number of points
  let assert Ok(sym_space) = maths.yield_symmetric_space(0.0, 2.0, 4)
  let assert Ok(result) =
    maths.all_close(
      sym_space
        |> yielder.to_list()
        |> list.zip([-2.0, -0.6666666666666667, 0.6666666666666665, 2.0]),
      0.0,
      tolerance,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when radius == 0 and steps > 0, then 
  // the value center value is just repeated, since the
  // step increment will be 0
  let assert Ok(sym_space) = maths.yield_symmetric_space(10.0, 0.0, 4)
  sym_space
  |> yielder.to_list()
  |> should.equal([10.0, 10.0, 10.0, 10.0])

  // A negative number of points does not work (-5)
  maths.yield_symmetric_space(0.0, 5.0, -5)
  |> should.be_error()
}

pub fn list_symmetric_space_test() {
  let assert Ok(tolerance) = float.power(10.0, -6.0)

  // Check that the function agrees, at some arbitrary input
  // points, with known function values
  let assert Ok(sym_space) = maths.symmetric_space(0.0, 5.0, 5)
  sym_space
  |> should.equal([-5.0, -2.5, 0.0, 2.5, 5.0])

  let assert Ok(sym_space) = maths.symmetric_space(0.0, 5.0, 5)
  sym_space
  |> should.equal([-5.0, -2.5, 0.0, 2.5, 5.0])

  // Negative center
  let assert Ok(sym_space) = maths.symmetric_space(-10.0, 5.0, 5)
  sym_space
  |> should.equal([-15.0, -12.5, -10.0, -7.5, -5.0])

  // Negative Radius (simply reverses the order of the values)
  let assert Ok(sym_space) = maths.symmetric_space(0.0, -5.0, 5)
  sym_space
  |> should.equal([5.0, 2.5, 0.0, -2.5, -5.0])

  // Uneven number of points
  let assert Ok(sym_space) = maths.symmetric_space(0.0, 2.0, 4)
  let assert Ok(result) =
    maths.all_close(
      sym_space
        |> list.zip([-2.0, -0.6666666666666667, 0.6666666666666665, 2.0]),
      0.0,
      tolerance,
    )
  result
  |> list.all(fn(x) { x == True })
  |> should.be_true()

  // Check that when radius == 0 and steps > 0, then 
  // the value center value is just repeated, since the
  // step increment will be 0
  let assert Ok(sym_space) = maths.symmetric_space(10.0, 0.0, 4)
  sym_space
  |> should.equal([10.0, 10.0, 10.0, 10.0])

  // A negative number of points does not work (-5)
  maths.symmetric_space(0.0, 5.0, -5)
  |> should.be_error()
}
