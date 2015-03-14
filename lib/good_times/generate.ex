defmodule GoodTimes.Generate do
  @vsn GoodTimes.version

  @moduledoc """
  Generate streams of datetimes.

  Generate a stream of datetimes, starting with the input datetime and stepping
  forward or backward by some time unit. All functions operate on an Erlang
  datetime, and returns a `Stream` of datetime elements.

  There are functions stepping a second, minute, hour, week, day, month or year
  at a time. Step forward with `all_<unit>_after/1`, or backward with
  `all_<unit>_before/1`.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_days_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 28}, {18, 30, 45}},
       {{2015, 3, 1}, {18, 30, 45}}]
  """

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping forward one second at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_seconds_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_seconds_after(GoodTimes.datetime) :: Enumerable.t
  def all_seconds_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_second_after/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping backward one second at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_seconds_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 44}},
       {{2015, 2, 27}, {18, 30, 43}}]
  """
  @spec all_seconds_before(GoodTimes.datetime) :: Enumerable.t
  def all_seconds_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_second_before/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping forward one minute at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_minutes_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 31, 45}},
       {{2015, 2, 27}, {18, 32, 45}}]
  """
  @spec all_minutes_after(GoodTimes.datetime) :: Enumerable.t
  def all_minutes_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_minute_after/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping backward one minute at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_minutes_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 29, 45}},
       {{2015, 2, 27}, {18, 28, 45}}]
  """
  @spec all_minutes_before(GoodTimes.datetime) :: Enumerable.t
  def all_minutes_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_minute_before/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping forward one hour at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_hours_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {19, 30, 45}},
       {{2015, 2, 27}, {20, 30, 45}}]
  """
  @spec all_hours_after(GoodTimes.datetime) :: Enumerable.t
  def all_hours_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.an_hour_after/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping backward one hour at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_hours_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {17, 30, 45}},
       {{2015, 2, 27}, {16, 30, 45}}]
  """
  @spec all_hours_before(GoodTimes.datetime) :: Enumerable.t
  def all_hours_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.an_hour_before/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping forward one day at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_days_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 28}, {18, 30, 45}},
       {{2015, 3, 1}, {18, 30, 45}}]
  """
  @spec all_days_after(GoodTimes.datetime) :: Enumerable.t
  def all_days_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_day_after/1
  end


  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping backward one day at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_days_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 26}, {18, 30, 45}},
       {{2015, 2, 25}, {18, 30, 45}}]
  """
  @spec all_days_before(GoodTimes.datetime) :: Enumerable.t
  def all_days_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_day_before/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping forward one week at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_weeks_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 3, 6}, {18, 30, 45}},
       {{2015, 3, 13}, {18, 30, 45}}]
  """
  @spec all_weeks_after(GoodTimes.datetime) :: Enumerable.t
  def all_weeks_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_week_after/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping backward one week at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_weeks_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 20}, {18, 30, 45}},
       {{2015, 2, 13}, {18, 30, 45}}]
  """
  @spec all_weeks_before(GoodTimes.datetime) :: Enumerable.t
  def all_weeks_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_week_before/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping forward one month at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_months_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 3, 27}, {18, 30, 45}},
       {{2015, 4, 27}, {18, 30, 45}}]
  """
  @spec all_months_after(GoodTimes.datetime) :: Enumerable.t
  def all_months_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_month_after/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping backward one month at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_months_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 1, 27}, {18, 30, 45}},
       {{2014, 12, 27}, {18, 30, 45}}]
  """
  @spec all_months_before(GoodTimes.datetime) :: Enumerable.t
  def all_months_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_month_before/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping forward one year at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_years_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2016, 2, 27}, {18, 30, 45}},
       {{2017, 2, 27}, {18, 30, 45}}]
  """
  @spec all_years_after(GoodTimes.datetime) :: Enumerable.t
  def all_years_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_year_after/1
  end

  @doc """
  Returns a `Stream` of datetimes, starting with `datetime`, stepping backward one year at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_years_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2014, 2, 27}, {18, 30, 45}},
       {{2013, 2, 27}, {18, 30, 45}}]
  """
  @spec all_years_before(GoodTimes.datetime) :: Enumerable.t
  def all_years_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_year_before/1
  end
end
