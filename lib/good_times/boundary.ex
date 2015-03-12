defmodule GoodTimes.Boundary do
  @vsn GoodTimes.version

  @doc """
  Returns the UTC date and time at the start of the given datetime's minute.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_minute
      {{2015, 2, 27}, {18, 30, 0}}
  """
  @spec beginning_of_minute(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_minute({date, {h, m, _}}) do
    {date, {h, m, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's minute.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_minute
      {{2015, 2, 27}, {18, 30, 59}}

  """
  @spec end_of_minute(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_minute({date, {h, m, _}}) do
    {date, {h, m, 59}}
  end


  @doc """
  Returns the UTC date and time at the start of the given datetime's hour.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_hour
      {{2015, 2, 27}, {18, 0, 0}}
  """
  @spec beginning_of_hour(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_hour({date, {h, _, _}}) do
    {date, {h, 0, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's hour.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_hour
      {{2015, 2, 27}, {18, 59, 59}}

  """
  @spec end_of_hour(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_hour({date, {h, _, _}}) do
    {date, {h, 59, 59}}
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
  Returns the UTC date and time at the start of the given datetime's month.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_month
      {{2015, 2, 1}, {0, 0, 0}}
  """
  @spec beginning_of_month(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_month({{y, m, _}, _}) do
    {{y, m, 1}, {0, 0, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's month.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_month
      {{2015, 2, 28}, {23, 59, 59}}

  """
  @spec end_of_month(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_month({{y, m, _}, _}) do
    {{y, m, :calendar.last_day_of_the_month(y, m)}, {23, 59, 59}}
  end


  @doc """
  Returns the UTC date and time at the start of the given datetime's year.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_year
      {{2015, 1, 1}, {0, 0, 0}}
  """
  @spec beginning_of_year(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_year({{y, _, _}, _}) do
    {{y, 1, 1}, {0, 0, 0}}
  end


  @doc """
  Returns the UTC date and time at the end of the given datetime's year.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> end_of_year
      {{2015, 12, 31}, {23, 59, 59}}

  """
  @spec end_of_year(GoodTimes.datetime) :: GoodTimes.datetime
  def end_of_year({{y, _, _}, _}) do
    {{y, 12, 31}, {23, 59, 59}}
  end
end
