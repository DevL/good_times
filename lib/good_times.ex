defmodule GoodTimes do
  @moduledoc """
  Convenience time functions.

  Unless explicitly stated, all functions operate on and return an
  Erlang datetime based on the Coordinated Universal Time (UTC).
  """

  @doc """
  Returns the current UTC time as a datetime.

  ## Examples

      iex> now
      {{2015, 2, 27}, {18, 30, 45}}
  """
  defdelegate now, to: GoodTimes.Now

  import GoodTimes.Meta
  define_time_unit_functions :second, 1
  define_time_unit_functions :minute, 60
  define_time_unit_functions :hour, 60*60, "an"
  define_time_unit_functions :day, 24*60*60
end
