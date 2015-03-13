defmodule GoodTimes.Boundary do
  @vsn GoodTimes.version

  @moduledoc """
  Find the boundaries of a unit of time, i.e. the first/last second of a minute,
  an hour, day, week, month or year.

  All functions take the form `beginning_of_<time unit>/1` and `end_of_<time unit>/1`.
  They operate on and return an Erlang datetime based on the Coordinated Universal
  Time (UTC).

  Example:

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_month
      {{2015, 2, 28}, {23, 59, 59}}

  """


  @doc """
  Returns the UTC date and time at the start of the given datetime's minute.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_minute
      {{2015, 2, 27}, {18, 30, 0}}
  """
  @spec beginning_of_minute(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_minute({date, {hour, minute, _}}) do
    {date, {hour, minute, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's minute.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_minute
      {{2015, 2, 27}, {18, 30, 59}}
  """
  @spec end_of_minute(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_minute({date, {hour, minute, _}}) do
    {date, {hour, minute, 59}}
  end


  @doc """
  Returns the UTC date and time at the start of the given datetime's hour.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_hour
      {{2015, 2, 27}, {18, 0, 0}}
  """
  @spec beginning_of_hour(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_hour({date, {hour, _, _}}) do
    {date, {hour, 0, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's hour.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_hour
      {{2015, 2, 27}, {18, 59, 59}}
  """
  @spec end_of_hour(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_hour({date, {hour, _, _}}) do
    {date, {hour, 59, 59}}
  end


  @doc """
  Returns the UTC date and time at the start of the given datetime's day.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_day
      {{2015, 2, 27}, {0, 0, 0}}
  """
  @spec beginning_of_day(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_day({date, _}) do
    {date, {0, 0, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's day.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_day
      {{2015, 2, 27}, {23, 59, 59}}
  """
  @spec end_of_day(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_day({date, _}) do
    {date, {23, 59, 59}}
  end


  @doc """
  Returns the UTC date and time at the start of the given datetime's week.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_week
      {{2015, 2, 27}, {0, 0, 0}}
  """
  @spec beginning_of_week(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_week(datetime) do
    datetime
    |> GoodTimes.Generate.all_days_before
    |> find_weekday(1)
    |> GoodTimes.at {0, 0, 0}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's week.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_week
      {{2015, 2, 27}, {23, 59, 59}}
  """
  @spec end_of_week(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_week(datetime) do
    datetime
    |> GoodTimes.Generate.all_days_after
    |> find_weekday(7)
    |> GoodTimes.at {23, 59, 59}
  end

  defp find_weekday(stream, weekday) do
    stream |> Enum.find(fn {date, _} -> weekday == :calendar.day_of_the_week date  end)
  end


  @doc """
  Returns the UTC date and time at the start of the given datetime's month.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_month
      {{2015, 2, 1}, {0, 0, 0}}
  """
  @spec beginning_of_month(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_month({{year, month, _}, _}) do
    {{year, month, 1}, {0, 0, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's month.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_month
      {{2015, 2, 28}, {23, 59, 59}}
  """
  @spec end_of_month(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_month({{year, month, _}, _}) do
    {{year, month, :calendar.last_day_of_the_month(year, month)}, {23, 59, 59}}
  end


  @doc """
  Returns the UTC date and time at the start of the given datetime's year.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_year
      {{2015, 1, 1}, {0, 0, 0}}
  """
  @spec beginning_of_year(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_year({{year, _, _}, _}) do
    {{year, 1, 1}, {0, 0, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's year.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_year
      {{2015, 12, 31}, {23, 59, 59}}
  """
  @spec end_of_year(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_year({{year, _, _}, _}) do
    {{year, 12, 31}, {23, 59, 59}}
  end
end
