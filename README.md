# gleam-community/maths

[![Package Version](https://img.shields.io/hexpm/v/gleam_community_maths)](https://hex.pm/packages/gleam_community_maths)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gleam_community_maths/)

A basic mathematics library that contains some of the most fundamental mathematics functions and utilities.

The library supports both targets: Erlang and JavaScript.

## Quickstart

```gleam
import gleam/float
import gleam/iterator
import gleam/option.{Some}
import gleam_community/maths/arithmetics
import gleam_community/maths/combinatorics.{WithoutRepetitions}
import gleam_community/maths/elementary
import gleam_community/maths/piecewise
import gleam_community/maths/predicates
import gleeunit/should

pub fn example() {
  // Evaluate the sine function
  let result = elementary.sin(elementary.pi())

  // Set the relative and absolute tolerance
  let assert Ok(absolute_tol) = elementary.power(10.0, -6.0)
  let relative_tol = 0.0

  // Check that the value is very close to 0.0
  // That is, if 'result' is within +/- 10^(-6)
  predicates.is_close(result, 0.0, relative_tol, absolute_tol)
  |> should.be_true()

  // Find the greatest common divisor
  arithmetics.gcd(54, 24)
  |> should.equal(6)

  // Find the minimum and maximum of a list
  piecewise.extrema([10.0, 3.0, 50.0, 20.0, 3.0], float.compare)
  |> should.equal(Ok(#(3.0, 50.0)))

  // Determine if a number is fractional
  predicates.is_fractional(0.3333)
  |> should.equal(True)

  // Generate all k = 2 combinations of [1, 2, 3]
  let assert Ok(combinations) =
    combinatorics.list_combination([1, 2, 3], 2, Some(WithoutRepetitions))
  combinations
  |> iterator.to_list()
  |> should.equal([[1, 2], [1, 3], [2, 3]])
}

```

## Installation

`gleam_community` packages are published to [hex.pm](https://hex.pm/packages/gleam_community_maths)
with the prefix `gleam_community_`. You can add them to your Gleam projects directly:

```sh
gleam add gleam_community_maths
```
