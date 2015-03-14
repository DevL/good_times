# GoodTimes

[![Build Status](https://travis-ci.org/magplus/good_times.svg?branch=master)](https://travis-ci.org/magplus/good_times)
[![Inline docs](http://inch-ci.org/github/magplus/good_times.svg?branch=master)](http://inch-ci.org/github/magplus/good_times)
[![Hex.pm](https://img.shields.io/hexpm/v/good_times.svg)](https://hex.pm/packages/good_times)

Expressive and easy to use datetime functions.

## Examples

```
iex(1)> import GoodTimes
nil
iex(2)> now
{{2015, 2, 26}, {15, 39, 55}}
iex(3)> 10 |> seconds_from_now
{{2015, 2, 26}, {15, 40, 05}}
iex(4)> 60 |> seconds_ago
{{2015, 2, 26}, {15, 38, 55}
```

## Usage

Update your `mix.exs` file and run `mix deps.get`.
```elixir
defp deps do
  [{:good_times, "~> 1.0.0"}]
end
```

Import the GoodTimes functions.
```elixir
defmodule MyModule do
  import GoodTimes
```

For more information, see [the full documentation](http://hexdocs.pm/good_times/).

## Known limitations

As GoodTimes uses [Erlangs calendar module](http://erlang.org/doc/man/calendar.html), dates and times before year 0 aren't supported.
