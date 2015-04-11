# GoodTimes

[![Build Status](https://travis-ci.org/DevL/good_times.svg?branch=master)](https://travis-ci.org/DevL/good_times)
[![Inline docs](http://inch-ci.org/github/DevL/good_times.svg?branch=master)](http://inch-ci.org/github/DevL/good_times)
[![Hex.pm](https://img.shields.io/hexpm/v/good_times.svg)](https://hex.pm/packages/good_times)

Expressive and easy to use datetime functions.

> Unbelivably nice...I'm proud that we have this.
>
> -- _Josh Adams, [Elixir sips](http://elixirsips.com) episode 145_

## Examples

```elixir
iex> import GoodTimes
nil
iex> now
{{2015, 3, 16}, {16, 58, 25}}
iex> 10 |> seconds_from_now
{{2015, 3, 16}, {16, 58, 35}}
iex> 60 |> seconds_ago
{{2015, 3, 16}, {16, 57, 25}}
iex> import GoodTimes.Convert
nil
iex> now |> to_date
{2015, 3, 16}
iex> import GoodTimes.Date
nil
iex> yesterday
{2015, 3, 15}
iex> tomorrow |> at {12, 30, 0}
{{2015, 3, 17}, {12, 30, 0}}
iex> import GoodTimes.Boundary
nil
iex> now |> end_of_week
{{2015, 3, 22}, {23, 59, 59}}
iex> import GoodTimes.Generate
nil
iex> all_days_after({{2016, 2, 28}, {10, 0, 0}}) |> Enum.take 3
[{{2016, 2, 28}, {10, 0, 0}}, {{2016, 2, 29}, {10, 0, 0}},
 {{2016, 3, 1}, {10, 0, 0}}]
```

## Usage

Update your `mix.exs` file and run `mix deps.get`.
```elixir
defp deps do
  [{:good_times, "~> 1.0.0"}]
end
```

Import the module or modules holding the functions you want to use.
```elixir
defmodule MyModule do
  import GoodTimes            # core functions.
  import GoodTimes.Boundary   # find boundaries between time units.
  import GoodTimes.Convert    # convert between dates, datetimes and times.
  import GoodTimes.Date       # functions operating on and returning dates.
  import GoodTimes.Generate   # functions generating streams of time units.
```

For more information, see [the full documentation](http://hexdocs.pm/good_times/).

## Known limitations

As GoodTimes uses [Erlangs calendar module](http://erlang.org/doc/man/calendar.html), dates and times before year 0 aren't supported.
