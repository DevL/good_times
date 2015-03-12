defmodule GoodTimes.Convert do
  @vsn GoodTimes.version

  @moduledoc """
  Converts to and from dates, datetimes, and times.
  """

  @doc """
  """
  @spec datetime_to_date(GoodTimes.datetime) :: GoodTimes.date
  def datetime_to_date({date, _}), do: date


  @doc """
  """
  @spec datetime_to_time(GoodTimes.datetime) :: GoodTimes.time
  def datetime_to_time({_, time}), do: time


  @doc """
  """
  @spec date_to_datetime(GoodTimes.date) :: GoodTimes.datetime
  def date_to_datetime(date), do: {date, {0, 0, 0}}
end
