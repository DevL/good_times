defmodule GoodTimes.Sigil do
  @vsn GoodTimes.version

  @moduledoc """
  Provides sigils for constructing dates, times, and datetimes.
  """

  @doc """
  Handles the sigil ~d. Returns a date tuple.

  ## Examples

      iex> ~d(2015-03-21)
      {2015, 03, 21}
  """
  def sigil_d(date_string, []) do
    date_string |> parse_into_tuple("-")
  end

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

  ## Examples

      iex> ~D(2015-03-21 11:51:24)
      {{2015, 03, 21}, {11, 51, 24}}
  """
  def sigil_D(datetime_string, []) do
    [date, time] = String.split(datetime_string)
    {sigil_d(date, []), sigil_t(time, [])}
  end

  defp parse_into_tuple(string, separator) do
    string
    |> String.split(separator)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end
end
