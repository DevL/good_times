defmodule GoodTimes.Seconds do
  import GoodTimes.Now
  alias GoodTimes.Now
  @doc """
  Returns the UTC date and time the specified seconds after the given datetime.

  ## Examples

      iex> 15 |> seconds_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 31, 0}}
  """
  @spec seconds_after(integer, Now.datetime) :: Now.datetime
  def seconds_after(seconds, datetime) do
    datetime
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(seconds)
    |> :calendar.gregorian_seconds_to_datetime
  end

  @doc """
  Returns the UTC date and time the specified seconds before the given datetime.

  ## Examples

      iex> 15 |> seconds_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 30, 30}}
  """
  @spec seconds_before(integer, Now.datetime) :: Now.datetime
  def seconds_before(seconds, datetime), do: seconds_after(-seconds, datetime)

  @doc """
  Returns the UTC date and time the specified seconds from now.

  ## Examples

      iex> 15 |> seconds_from_now
      {{2015, 2, 27}, {18, 31, 0}}
  """
  @spec seconds_from_now(integer) :: Now.datetime
  def seconds_from_now(seconds), do: seconds_after(seconds, now)

  @doc """
  Returns the UTC date and time the specified seconds ago.

  ## Examples

      iex> 20 |> seconds_ago
      {{2015, 2, 27}, {18, 30, 25}}
  """
  @spec seconds_ago(integer) :: Now.datetime
  def seconds_ago(seconds), do: seconds_before(seconds, now)
end
