# gleam-community/maths

[![Package Version](https://img.shields.io/hexpm/v/gleam_community_maths)](https://hex.pm/packages/gleam_community_maths)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gleam_community_maths/)

A basic mathematics library that contains some of the most fundamental mathematics functions and utilities.

The library supports both targets: Erlang and JavaScript.

## Quickstart

```gleam
import gleam_community/maths/float as floatx
import gleam_community/maths/int as intx
import gleam_community/maths/float_list
import gleam_community/maths/int_list

pub fn main() {
  // Evaluate the sine function
  floatx.sin(floatx.pi())
  // Returns Float: 0.0

  // Find the greatest common divisor
  intx.gcd(54, 24)
  // Returns   Int: 6

  // Find the minimum and maximum of a list
  float_list.extrema([10.0, 3.0, 50.0, 20.0, 3.0])
  // Returns Tuple: Ok(#(3.0, 50.0))

  // Find the list indices of the largest values 
  int_list.argmax([10, 3, 50, 20, 3])
  // Returns  List: Ok([1, 4])  
}

```

## Installation

`gleam_community` packages are published to [hex.pm](https://hex.pm/packages/gleam_community_maths)
with the prefix `gleam_community_`. You can add them to your Gleam projects directly:

```sh
gleam add gleam_community_maths
```