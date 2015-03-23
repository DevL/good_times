defmodule GoodTimes.Sigil do
  @vsn GoodTimes.version
  import GoodTimes.Convert, only: [to_date: 1]

  @moduledoc """
  Provides sigils for constructing dates, times, and datetimes.
  """

  @doc """
  Handles the sigil ~t. Returns a time tuple.

  ## Examples

      iex> ~t(11:51:24)
      {11, 51, 24}
  """
  def sigil_t(time_string, []) do
    time_string |> parse_into_tuple(":")
  end

  @doc """
  Handles the sigil ~D. Returns a datetime tuple.

  Capable of parsing strings that comprise of
  both a date and a time or just a date.

  Use the modifier 'd' to return a date tuple.

  ## Examples

      iex> ~D(2015-03-21 11:51:24)
      {{2015, 03, 21}, {11, 51, 24}}

      iex> ~D(2015-03-21)
      {{2015, 03, 21}, {0, 0, 0}}

      iex> ~D(2015-03-21 11:51:24)d
      {{2015, 03, 21}}

      iex> ~D(2015-03-21)d
      {2015, 03, 21}
  """
  def sigil_D(string, []) do
    string
    |> String.split
    |> convert
  end

  def sigil_D(string, [?d]) do
    sigil_D(string, []) |> to_date
  end

  defp convert([date, time]) do
    {
      date |> parse_into_tuple("-"),
      time |> parse_into_tuple(":")
    }
  end

  defp convert([date]) do
    {
      date |> parse_into_tuple("-"),
      {0, 0, 0}
    }
  end

  defp parse_into_tuple(string, separator) do
    string
    |> String.split(separator)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end
end
