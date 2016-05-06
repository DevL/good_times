defmodule GoodTimes.Convert do
  @vsn GoodTimes.version

  @moduledoc """
  Convert to and from dates, datetimes, and times.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> to_date
      {2015, 2, 27}
      iex> {2015, 2, 27} |> from_date
      {{2015, 2, 27}, {0, 0, 0}}
  """

  @doc """
  Converts a date to a datetime with the time set to 00:00:00.

  ## Examples

      iex> {2015, 2, 27} |> from_date
      {{2015, 2, 27}, {0, 0, 0}}

      iex> %Date{year: 2016, month: 4, day: 1} |> from_date
      {{2016, 4, 1}, {0, 0, 0}}
  """
  @spec from_date(Calendar.Date.t) :: GoodTimes.datetime
  @spec from_date(GoodTimes.date) :: GoodTimes.datetime
  def from_date(%Date{year: year, month: month, day: day, calendar: Calendar.ISO}) do
    {{year, month, day}, {0, 0, 0}}
  end
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

  @doc """
  Returns the date portion of a datetime as a Calendar.Date.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> to_elixir_date
      %Date{year: 2015, month: 2, day: 27, calendar: Calendar.ISO}
  """
  @spec to_elixir_date(GoodTimes.datetime) :: Date.t
  def to_elixir_date({{year, month, day}, _}) do
    %Date{year: year, month: month, day: day}
  end

  @doc """
  Returns the time portion of a datetime as a Calendar.Time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> to_elixir_time
      %Time{hour: 18, minute: 30, second: 45}
  """
  @spec to_elixir_time(GoodTimes.datetime) :: Time.t
  def to_elixir_time({_, {hour, minute, second}}) do
    %Time{hour: hour, minute: minute, second: second}
  end

  @doc """
  Returns the datetime as a Calendar.DateTime.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> to_elixir_datetime
      %DateTime{year: 2015, month: 2, day: 27, hour: 18, minute: 30, second: 45, microsecond: 0, calendar: Calendar.ISO, std_offset: nil, time_zone: nil, utc_offset: nil, zone_abbr: nil}
  """
  @spec to_elixir_datetime(GoodTimes.datetime) :: DateTime.t
  def to_elixir_datetime({{year, month, day}, {hour, minute, second}}) do
    %DateTime{
      calendar: Calendar.ISO, year: year, month: month, day: day,
      hour: hour, minute: minute, second: second, microsecond: 0,
      std_offset: nil, time_zone: nil, utc_offset: nil, zone_abbr: nil
    }
  end
end
