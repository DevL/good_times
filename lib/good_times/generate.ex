defmodule GoodTimes.Generate do
  @moduledoc """
  Generate datetimes, starting from an initial datetime and stepping forward or
  backward by different time units.

  All functions operate on an Erlang datetime, and returns a `Stream` of datetime
  elements. For example, `all_days_after/1`:

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_days_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]

  There are functions defined stepping a second, minute, hour, week, day, month
  or year at a time. Step forward with `all_<unit>_after/1`, and backward with
  `all_<unit>_before/1`.
  """


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going forward one second at a time.

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
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going backward one second at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_seconds_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_seconds_before(GoodTimes.datetime) :: Enumerable.t
  def all_seconds_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_second_before/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going forward one minute at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_minutes_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_minutes_after(GoodTimes.datetime) :: Enumerable.t
  def all_minutes_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_minute_after/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going backward one minute at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_minutes_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_minutes_before(GoodTimes.datetime) :: Enumerable.t
  def all_minutes_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_minute_before/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going forward one hour at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_hours_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_hours_after(GoodTimes.datetime) :: Enumerable.t
  def all_hours_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.an_hour_after/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going backward one hour at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_hours_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_hours_before(GoodTimes.datetime) :: Enumerable.t
  def all_hours_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.an_hour_before/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going forward one day at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_days_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_days_after(GoodTimes.datetime) :: Enumerable.t
  def all_days_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_day_after/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going backward one day at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_days_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_days_before(GoodTimes.datetime) :: Enumerable.t
  def all_days_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_day_before/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going forward one week at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_weeks_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_weeks_after(GoodTimes.datetime) :: Enumerable.t
  def all_weeks_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_week_after/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going backward one week at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_weeks_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_weeks_before(GoodTimes.datetime) :: Enumerable.t
  def all_weeks_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_week_before/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going forward one month at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_months_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_months_after(GoodTimes.datetime) :: Enumerable.t
  def all_months_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_month_after/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going backward one month at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_months_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_months_before(GoodTimes.datetime) :: Enumerable.t
  def all_months_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_month_before/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going forward one year at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_years_after |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_years_after(GoodTimes.datetime) :: Enumerable.t
  def all_years_after(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_year_after/1
  end


  @doc """
  Returns a Stream of UTC dates and times, starting with the given datetime,
  going backward one year at a time.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> all_years_before |> Enum.take 3
      [{{2015, 2, 27}, {18, 30, 45}}, {{2015, 2, 27}, {18, 30, 46}},
       {{2015, 2, 27}, {18, 30, 47}}]
  """
  @spec all_years_before(GoodTimes.datetime) :: Enumerable.t
  def all_years_before(datetime) do
    datetime |> Stream.iterate &GoodTimes.a_year_before/1
  end
end
