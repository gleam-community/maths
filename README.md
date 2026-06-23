# gleam-community/maths

[![Package Version](https://img.shields.io/hexpm/v/gleam_community_maths)](https://hex.pm/packages/gleam_community_maths)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gleam_community_maths/)

A Gleam mathematics library for scalar maths, statistics, metrics,
combinatorics, numerical sequences, special functions, and complex numbers.

The library supports both targets: Erlang and JavaScript.

## Quickstart

```gleam
import gleam/float
import gleam/list
import gleam/yielder
import gleam_community/maths
import gleam_community/complex
import gleeunit/should

pub fn example() {
  // Evaluate the sine function
  let result = maths.sin(maths.pi())
  // Set the relative and absolute tolerance
  let assert Ok(absolute_tol) = float.power(10.0, -6.0)
  let relative_tol = 0.0
  // Check that the value is very close to 0.0
  // That is, if `result` is within +/- 10^(-6)
  maths.is_close(result, 0.0, relative_tol, absolute_tol)
  |> should.be_true()

  // Find the greatest common divisor
  maths.gcd(54, 24)
  |> should.equal(6)

  // Determine if 999983 is a prime number
  maths.is_prime(999_983)
  |> should.equal(True)

  // Find the minimum and maximum of a list
  maths.extrema([10.0, 3.0, 50.0, 20.0, 3.0], float.compare)
  |> should.equal(Ok(#(3.0, 50.0)))

  // Determine if a number is fractional
  maths.is_fractional(0.3333)
  |> should.equal(True)

  // Generate all k = 2 combinations of [1, 2, 3]
  let assert Ok(combinations) = maths.list_combination([1, 2, 3], 2)
  combinations
  |> yielder.to_list()
  |> should.equal([[1, 2], [1, 3], [2, 3]])

  // Compute the Cosine Similarity between two (orthogonal) "vectors"
  maths.cosine_similarity([#(-1.0, 1.0), #(1.0, 1.0), #(0.0, -1.0)])
  |> should.equal(Ok(0.0))

  // Generate a list of 3 logarithmically-spaced points over a specified
  // interval, i.e., [10^1, 10^3]
  let assert Ok(logspace) = maths.logarithmic_space(1.0, 3.0, 3, True, 10.0)
  let pairs = logspace |> list.zip([10.0, 100.0, 1000.0])
  pairs
  |> list.all(fn(x) { x.0 == x.1 })
  |> should.be_true()

  let z = complex.Complex(3.0, 4.0)

  // Compute the distance from `z` to zero in the complex plane
  complex.absolute_value(z)
  |> should.equal(5.0)

  // Complex functions return complex values
  complex.multiply(z, complex.imaginary_unit())
  |> should.equal(complex.Complex(-4.0, 3.0))
}
```

## Installation

`gleam_community` packages are published to [hex.pm](https://hex.pm/packages/gleam_community_maths)
with the prefix `gleam_community_`. You can add them to your Gleam projects directly:

```sh
gleam add gleam_community_maths
```

## Library Conventions

The library uses a few rules of thumb for edge cases:

- Plain-value-returning functions: functions that return a plain value and
  internally encounter division by zero use zero for that division when the
  result can still be meaningfully carried forward. This follows Gleam's direct
  division-by-zero convention. For example, `complex.divide` and
  `complex.reciprocal` return a complex number whose real and imaginary parts
  are both `0.0` when the complex denominator is zero.
- Result-returning functions: functions that return `Result` use `Error(Nil)`
  when returning zero would be misleading, when the calculation cannot be
  meaningfully carried forward, or when there is no meaningful value to return.
  Examples include `maths.euclidean_modulo` when the divisor is zero,
  `maths.tan` at values where the tangent is undefined,
  `maths.cosine_similarity` when one vector has zero length,
  `maths.natural_logarithm` for values outside the logarithm's domain, and
  `maths.standard_deviation` when there is not enough data.
- Predicate functions: checks return `Bool`. If the check cannot be meaningfully
  answered, the function returns `False`; for example, `maths.is_divisible`
  returns `False` when the divisor is zero.
- Sequence builder functions: range builders such as `maths.step_range` and
  `maths.yield_step_range` return lists or yielders. A zero increment cannot
  make progress, so these functions return empty sequences.
