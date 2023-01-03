//// Small examples ALSO used in the docs...

import gleam/int
import gleam/list
import gleam/pair
import gleam_stats/stats
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn example_sum_test() {
  // An empty list returns an error
  []
  |> stats.sum()
  |> should.equal(0.)

  // Valid input returns a result
  [1., 2., 3.]
  |> stats.sum()
  |> should.equal(6.)
}

pub fn example_mean_test() {
  // An empty list returns an error
  []
  |> stats.mean()
  |> should.be_error()

  // Valid input returns a result
  [1., 2., 3.]
  |> stats.mean()
  |> should.equal(Ok(2.))
}

pub fn example_median_test() {
  // An empty list returns an error
  []
  |> stats.median()
  |> should.be_error()

  // Valid input returns a result
  [1., 2., 3.]
  |> stats.median()
  |> should.equal(Ok(2.))

  [1., 2., 3., 4.]
  |> stats.median()
  |> should.equal(Ok(2.5))
}

pub fn example_hmean_test() {
  // An empty list returns an error
  []
  |> stats.hmean()
  |> should.be_error()

  // List with negative numbers returns an error
  [-1., -3., -6.]
  |> stats.hmean()
  |> should.be_error()

  // Valid input returns a result
  [1., 3., 6.]
  |> stats.hmean()
  |> should.equal(Ok(2.))
}

pub fn example_gmean_test() {
  // An empty list returns an error
  []
  |> stats.gmean()
  |> should.be_error()
  // List with negative numbers returns an error
  [-1., -3., -6.]
  |> stats.gmean()
  |> should.be_error()
  // Valid input returns a result
  [1., 3., 9.]
  |> stats.gmean()
  |> should.equal(Ok(3.))
}

pub fn example_var_test() {
  // Degrees of freedom
  let ddof: Int = 1

  // An empty list returns an error
  []
  |> stats.var(ddof)
  |> should.be_error()

  // Valid input returns a result
  [1., 2., 3.]
  |> stats.var(ddof)
  |> should.equal(Ok(1.))
}

pub fn example_std_test() {
  // Degrees of freedom
  let ddof: Int = 1

  // An empty list returns an error
  []
  |> stats.std(ddof)
  |> should.be_error()

  // Valid input returns a result
  [1., 2., 3.]
  |> stats.std(ddof)
  |> should.equal(Ok(1.))
}

pub fn example_moment_test() {
  // An empty list returns an error
  []
  |> stats.moment(0)
  |> should.be_error()

  // 0th moment about the mean is 1. per definition
  [0., 1., 2., 3., 4.]
  |> stats.moment(0)
  |> should.equal(Ok(1.))

  // 1st moment about the mean is 0. per definition
  [0., 1., 2., 3., 4.]
  |> stats.moment(1)
  |> should.equal(Ok(0.))

  // 2nd moment about the mean
  [0., 1., 2., 3., 4.]
  |> stats.moment(2)
  |> should.equal(Ok(2.))
}

pub fn example_skewness_test() {
  // An empty list returns an error
  []
  |> stats.skewness()
  |> should.be_error()

  // No skewness 
  // -> Zero skewness
  [1., 2., 3., 4.]
  |> stats.skewness()
  |> should.equal(Ok(0.))

  // Right-skewed distribution 
  // -> Positive skewness
  [1., 1., 1., 2.]
  |> stats.skewness()
  |> fn(x: Result(Float, String)) -> Bool {
    case x {
      Ok(x) -> x >. 0.
      _ -> False
    }
  }
  |> should.be_true()
}

pub fn example_kurtosis_test() {
  // An empty list returns an error
  []
  |> stats.skewness()
  |> should.be_error()

  // No tail 
  // -> Fisher's definition gives kurtosis -3 
  [1., 1., 1., 1.]
  |> stats.kurtosis()
  |> should.equal(Ok(-3.))

  // Distribution with a tail 
  // -> Higher kurtosis 
  [1., 1., 1., 2.]
  |> stats.kurtosis()
  |> fn(x: Result(Float, String)) -> Bool {
    case x {
      Ok(x) -> x >. -3.
      _ -> False
    }
  }
  |> should.be_true()
}

pub fn example_zscore_test() {
  // An empty list returns an error
  []
  // Use degrees of freedom = 1
  |> stats.zscore(1)
  |> should.be_error()

  [1., 2., 3.]
  // Use degrees of freedom = 1
  |> stats.zscore(1)
  |> should.equal(Ok([-1., 0., 1.]))
}

pub fn example_percentile_test() {
  // An empty list returns an error
  []
  |> stats.percentile(40)
  |> should.be_error()

  // Calculate 40th percentile 
  [15., 20., 35., 40., 50.]
  |> stats.percentile(40)
  |> should.equal(Ok(29.))
}

pub fn example_iqr_test() {
  // An empty list returns an error
  []
  |> stats.iqr()
  |> should.be_error()

  // Valid input returns a result
  [1., 2., 3., 4., 5.]
  |> stats.iqr()
  |> should.equal(Ok(3.))
}

pub fn example_freedman_diaconis_rule_test() {
  // An empty list returns an error
  []
  |> stats.freedman_diaconis_rule()
  |> should.be_error()

  // Calculate histogram bin widths
  list.range(0, 1000)
  |> list.map(fn(x: Int) -> Float { int.to_float(x) })
  |> stats.freedman_diaconis_rule()
  |> should.equal(Ok(10.))
}

pub fn example_range_test() {
  // Create a range
  let range = stats.Range(0., 1.)
  // Retrieve min and max values
  let stats.Range(min, max) = range
  min
  |> should.equal(0.)
  max
  |> should.equal(1.)
}

pub fn example_bin_test() {
  // Create a bin
  let bin: stats.Bin = #(stats.Range(0., 1.), 999)
  // Retrieve min and max values
  let stats.Range(min, max) = pair.first(bin)
  min
  |> should.equal(0.)
  max
  |> should.equal(1.)
  // Retrieve count
  let count = pair.second(bin)
  count
  |> should.equal(999)
}

pub fn example_histogram_test() {
  // An empty lists returns an error
  []
  |> stats.histogram(1.)
  |> should.be_error()
  // Create the bins of a histogram given a list of values
  list.range(0, 100)
  |> list.map(fn(x: Int) -> Float { int.to_float(x) })
  // Below 25. is the bin width
  // The Freedman-Diaconis’s Rule can be used to determine a decent value
  |> stats.histogram(25.)
  |> should.equal(Ok([
    #(stats.Range(0., 25.), 25),
    #(stats.Range(25., 50.), 25),
    #(stats.Range(50., 75.), 25),
    #(stats.Range(75., 100.), 25),
  ]))
}

pub fn example_correlation_test() {
  // An empty lists returns an error
  stats.correlation([], [])
  |> should.be_error()

  // Lists with fewer than 2 elements return an error
  stats.correlation([1.0], [1.0])
  |> should.be_error()

  // Lists of uneqal length return an error
  stats.correlation([1.0, 2.0, 3.0], [1.0, 2.0])
  |> should.be_error()

  // Perfect positive correlation
  let xarr0: List(Float) =
    list.range(0, 100)
    |> list.map(fn(x: Int) -> Float { int.to_float(x) })
  let yarr0: List(Float) =
    list.range(0, 100)
    |> list.map(fn(x: Int) -> Float { int.to_float(x) })
  stats.correlation(xarr0, yarr0)
  |> should.equal(Ok(1.))

  // Perfect negative correlation
  let xarr0: List(Float) =
    list.range(0, 100)
    |> list.map(fn(x: Int) -> Float { -1. *. int.to_float(x) })
  let yarr0: List(Float) =
    list.range(0, 100)
    |> list.map(fn(x: Int) -> Float { int.to_float(x) })
  stats.correlation(xarr0, yarr0)
  |> should.equal(Ok(-1.))
}

pub fn example_trim_test() {
  // An empty lists returns an error
  []
  |> stats.trim(0, 0)
  |> should.be_error()

  // Trim the list to only the middle part of list
  [1., 2., 3., 4., 5., 6.]
  |> stats.trim(1, 4)
  |> should.equal(Ok([2., 3., 4., 5.]))
}

pub fn example_isclose_test() {
  let val: Float = 99.
  let ref_val: Float = 100.
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol: Float = 0.01
  let atol: Float = 0.10
  stats.isclose(val, ref_val, rtol, atol)
  |> should.be_true()
}

pub fn example_allclose_test() {
  let val: Float = 99.
  let ref_val: Float = 100.
  let xarr: List(Float) = list.repeat(val, 42)
  let yarr: List(Float) = list.repeat(ref_val, 42)
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let rtol: Float = 0.01
  let atol: Float = 0.10
  stats.allclose(xarr, yarr, rtol, atol)
  |> fn(zarr: Result(List(Bool), String)) -> Result(Bool, Nil) {
    case zarr {
      Ok(arr) ->
        arr
        |> list.all(fn(a: Bool) -> Bool { a })
        |> Ok
      _ ->
        Nil
        |> Error
    }
  }
  |> should.equal(Ok(True))
}

pub fn example_amax_test() {
  // An empty lists returns an error
  []
  |> stats.amax()
  |> should.be_error()

  // Valid input returns a result
  [4., 4., 3., 2., 1.]
  |> stats.amax()
  |> should.equal(Ok(4.))
}

pub fn example_amin_test() {
  // An empty lists returns an error
  []
  |> stats.amin()
  |> should.be_error()

  // Valid input returns a result
  [4., 4., 3., 2., 1.]
  |> stats.amin()
  |> should.equal(Ok(1.))
}

pub fn example_argmax_test() {
  // An empty lists returns an error
  []
  |> stats.argmax()
  |> should.be_error()

  // Valid input returns a result
  [4., 4., 3., 2., 1.]
  |> stats.argmax()
  |> should.equal(Ok([0, 1]))
}

pub fn example_argmin_test() {
  // An empty lists returns an error
  []
  |> stats.argmin()
  |> should.be_error()

  // Valid input returns a result
  [4., 4., 3., 2., 1.]
  |> stats.argmin()
  |> should.equal(Ok([4]))
}
