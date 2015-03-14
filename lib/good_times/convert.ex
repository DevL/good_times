defmodule GoodTimes.Convert do
  @vsn GoodTimes.version

  @moduledoc """
  Convert to and from dates, datetimes, and times.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> to_date
      {2015, 2, 27}
      iex> {2015, 2, 27} |> from_date
      {{2015, 2, 27}, {18, 30, 45}}
  """

  @doc """
  Converts a date to a datetime with the time set to 00:00:00.

  ## Examples

      iex> {2015, 2, 27} |> from_date
      {{2015, 2, 27}, {0, 0, 0}}
  """
  @spec from_date(GoodTimes.date) :: GoodTimes.datetime
  def from_date(date), do: {date, {0, 0, 0}}

  @doc """
  Returns the date portion of a datetime.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> to_date
      {2015, 2, 27}
  """
  @spec to_date(GoodTimes.datetime) :: GoodTimes.date
  def to_date({date, _}), do: date

  @doc """
  Returns the time portion of a datetime.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> to_time
      {18, 30, 45}
  """
  @spec to_time(GoodTimes.datetime) :: GoodTimes.time
  def to_time({_, time}), do: time
end
