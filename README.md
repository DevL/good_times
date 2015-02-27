# GoodTimes

[![Build Status](https://travis-ci.org/magplus/good-times.svg?branch=master)](https://travis-ci.org/magplus/good-times)

Easy to use time functions.

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
  [{:good_times, "~> 0.1.0"}]
end
```

Import the GoodTimes functions.
```elixir
defmodule MyModule do
  import GoodTimes
```

