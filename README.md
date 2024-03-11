# gleam-community/maths

[![Package Version](https://img.shields.io/hexpm/v/gleam_community_maths)](https://hex.pm/packages/gleam_community_maths)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gleam_community_maths/)

A basic mathematics library that contains some of the most fundamental mathematics functions and utilities.

The library supports both targets: Erlang and JavaScript.

## Quickstart

```gleam
import gleam_community/maths/arithmetics
import gleam_community/maths/combinatorics
import gleam_community/maths/elementary
import gleam_community/maths/piecewise
import gleam_community/maths/predicates
import gleam/float
import gleam/int

pub fn main() {
  // Evaluate the sine function
  elementary.sin(elementary.pi())
  // Returns Float: 0.0

  // Find the greatest common divisor
  arithmetics.gcd(54, 24)
  // Returns Int: 6

  // Find the minimum and maximum of a list
  piecewise.extrema([10.0, 3.0, 50.0, 20.0, 3.0], float.compare)
  // Returns Tuple: Ok(#(3.0, 50.0))

  // Find the list indices of the smallest value 
  piecewise.arg_minimum([10, 3, 50, 20, 3], int.compare)
  // Returns List: Ok([1, 4])

  // Determine if a number is fractional
  predicates.is_fractional(0.3333)
  // Returns Bool: True

  // Determine if 28 is a power of 3
  predicates.is_power(28, 3)
  // Returns Bool: False

  // Generate all k = 1 combinations of [1, 2]
  combinatorics.list_combination([1, 2], 1)
  // Returns List: Ok([[1], [2]])
}
```

## Installation

`gleam_community` packages are published to [hex.pm](https://hex.pm/packages/gleam_community_maths)
with the prefix `gleam_community_`. You can add them to your Gleam projects directly:

```sh
gleam add gleam_community_maths
```
