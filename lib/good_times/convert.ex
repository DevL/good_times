defmodule GoodTimes.Convert do
  @vsn GoodTimes.version

  @moduledoc """
  Converts to and from dates, datetimes, and times.
  """

  @doc """
  Returns the date portion of a datetime.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> datetime_to_date
      {2015, 2, 27}
  """
  @spec datetime_to_date(GoodTimes.datetime) :: GoodTimes.date
  def datetime_to_date({date, _}), do: date


  @doc """
  Returns the time portion of a datetime.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> datetime_to_time
      {18, 30, 45}
  """
  @spec datetime_to_time(GoodTimes.datetime) :: GoodTimes.time
  def datetime_to_time({_, time}), do: time


  @doc """
  Converts a date to a datetime with the time set to 00:00:00.

  ## Examples

      iex> {2015, 2, 27} |> date_to_datetime
      {{2015, 2, 27}, {0, 0, 0}}
  """
  @spec date_to_datetime(GoodTimes.date) :: GoodTimes.datetime
  def date_to_datetime(date), do: {date, {0, 0, 0}}
end
