defmodule GoodTimes do
  @vsn "1.0.0-pre"
  @doc false
  def version, do: @vsn

  @moduledoc """
  Convenient and expressive functions dealing with dates and times.

  This is the core module of the GoodTimes library.
  Unless explicitly stated, all functions operate on and return an
  Erlang datetime based on the Coordinated Universal Time (UTC).

  ## Examples

      iex> now
      {{2015, 2, 27}, {18, 30, 45}}
      iex> an_hour_ago
      {{2015, 2, 27}, {17, 30, 45}}
      iex> a_month_before {{2016, 3, 31}, {9, 30, 0}}
      {{2016, 2, 29}, {9, 30, 0}}
      iex> 2 |> weeks_from_now |> at {12, 15, 0}
      {{2015, 3, 13}, {12, 15, 0}}

  ## Functions overview

  For any given time unit (second, minute, hour, day, week, month, or year),
  there are the following functions available; all returning a datetime that's
  offset the specified amount of time units.

  * <time_units>_after/2
  * <time_units>_before/2
  * <time_units>_from_now/1
  * <time_units>_ago/1

  When only adjusting the datetime by a single time unit, the following
  functions can be used.

  * a_<time_unit>_after/1
  * a_<time_unit>_before/1
  * a_<time_unit>_from_now/0
  * a_<time_unit>_ago/0

  In addition, two other functions are included for convenience.

  * now/0 - returning the current datetime
  * at/2  - merges a given date or datetime with a time

  ## Known limitations

  As the entire library builds upon Erlang's calendar module,
  dates before year 0 are not supported.
  """

  @seconds_per_minute 60
  @seconds_per_hour 60 * @seconds_per_minute
  @seconds_per_day 24 * @seconds_per_hour
  @seconds_per_week 7 * @seconds_per_day
  @months_per_year 12

  @type year  :: non_neg_integer
  @type month :: 1..12
  @type day   :: 1..31
  @type hour   :: 0..23
  @type minute :: 0..59
  @type second :: 0..59
  @type date :: {year, month, day}
  @type time :: {hour, minute, second}
  @type datetime :: {date, time}

  @doc """
  Returns the current UTC time as a datetime.

  ## Examples

      iex> now
      {{2015, 2, 27}, {18, 30, 45}}
  """
  @spec now :: datetime
  def now, do: :calendar.universal_time

  @doc """
  Merges the date from the given date or datetime with the given time.

  ## Examples

      iex> now |> at {10, 30, 15}
      {{2015, 2, 27}, {10, 30, 15}}
      iex> {2015, 2, 27} |> at {10, 30, 15}
      {{2015, 2, 27}, {10, 30, 15}}
  """
  @spec at(date, time) :: datetime
  @spec at(datetime, time) :: datetime
  def at(date_or_datetime, time), do: _at(date_or_datetime, time)
  defp _at({date, _}, time), do: {date, time}
  defp _at(date, time), do: {date, time}

  @doc """
  Returns the UTC date and time the specified seconds after the given datetime.

  ## Examples

      iex> 15 |> seconds_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 31, 0}}
  """
  @spec seconds_after(integer, datetime) :: datetime
  def seconds_after(seconds, datetime) do
    datetime
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(seconds)
    |> :calendar.gregorian_seconds_to_datetime
  end

  @doc """
  Returns the UTC date and time the specified seconds before the given datetime.

  ## Examples

      iex> 15 |> seconds_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 30, 30}}
  """
  @spec seconds_before(integer, datetime) :: datetime
  def seconds_before(seconds, datetime), do: seconds_after(-seconds, datetime)

  @doc """
  Returns the UTC date and time a second after the given datetime.

  ## Examples

      iex> a_second_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 30, 46}}
  """
  @spec a_second_after(datetime) :: datetime
  def a_second_after(datetime), do: seconds_after(1, datetime)

  @doc """
  Returns the UTC date and time a second before the given datetime.

  ## Examples

      iex> a_second_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 30, 44}}
  """
  @spec a_second_before(datetime) :: datetime
  def a_second_before(datetime), do: seconds_before(1, datetime)

  @doc """
  Returns the UTC date and time the specified seconds from now.

  ## Examples

      iex> 15 |> seconds_from_now
      {{2015, 2, 27}, {18, 31, 0}}
  """
  @spec seconds_from_now(integer) :: datetime
  def seconds_from_now(seconds), do: seconds_after(seconds, now)

  @doc """
  Returns the UTC date and time the specified seconds ago.

  ## Examples

      iex> 20 |> seconds_ago
      {{2015, 2, 27}, {18, 30, 25}}
  """
  @spec seconds_ago(integer) :: datetime
  def seconds_ago(seconds), do: seconds_before(seconds, now)

  @doc """
  Returns the UTC date and time a second from now.

  ## Examples

      iex> a_second_from_now
      {{2015, 2, 27}, {18, 30, 46}}
  """
  @spec a_second_from_now :: datetime
  def a_second_from_now, do: seconds_from_now(1)

  @doc """
  Returns the UTC date and time a second ago.

  `a_second_ago # => {{2015, 2, 27}, {18, 30, 44}}`
  """
  @spec a_second_ago :: datetime
  def a_second_ago, do: seconds_ago(1)

  @doc """
  Returns the UTC date and time the specified minutes after the given datetime.

  ## Examples

      iex> 15 |> minutes_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 45, 45}}
  """
  @spec minutes_after(integer, datetime) :: datetime
  def minutes_after(minutes, datetime), do: seconds_after(minutes * @seconds_per_minute, datetime)

  @doc """
  Returns the UTC date and time the specified minutes before the given datetime.

  ## Examples

      iex> 15 |> minutes_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 15, 45}}
  """
  @spec minutes_before(integer, datetime) :: datetime
  def minutes_before(minutes, datetime), do: seconds_before(minutes * @seconds_per_minute, datetime)

  @doc """
  Returns the UTC date and time a minute after the given datetime.

  ## Examples

      iex> a_minute_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 31, 45}}
  """
  @spec a_minute_after(datetime) :: datetime
  def a_minute_after(datetime), do: minutes_after(1, datetime)

  @doc """
  Returns the UTC date and time a minute before the given datetime.

  ## Examples

      iex> a_minute_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {18, 29, 45}}
  """
  @spec a_minute_before(datetime) :: datetime
  def a_minute_before(datetime), do: minutes_before(1, datetime)

  @doc """
  Returns the UTC date and time the specified minutes from now.

  ## Examples

      iex> 10 |> minutes_from_now
      {{2015, 2, 27}, {18, 40, 45}}
  """
  @spec minutes_from_now(integer) :: datetime
  def minutes_from_now(minutes), do: minutes_after(minutes, now)

  @doc """
  Returns the UTC date and time the specified minutes ago.

  ## Examples

      iex> 5 |> minutes_ago
      {{2015, 2, 27}, {18, 25, 45}}
  """
  @spec minutes_ago(integer) :: datetime
  def minutes_ago(minutes), do: minutes_before(minutes, now)

  @doc """
  Returns the UTC date and time a minute from now.

  ## Examples

      iex> a_minute_from_now
      {{2015, 2, 27}, {18, 31, 45}}
  """
  @spec a_minute_from_now :: datetime
  def a_minute_from_now, do: minutes_from_now(1)

  @doc """
  Returns the UTC date and time a minute ago.

  ## Examples

      iex> a_minute_ago
      {{2015, 2, 27}, {18, 29, 45}}
  """
  @spec a_minute_ago :: datetime
  def a_minute_ago, do: minutes_ago(1)

  @doc """
  Returns the UTC date and time the specified hours after the given datetime.

  ## Examples

      iex> 15 |> hours_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 28}, {9, 30, 45}}
  """
  @spec hours_after(integer, datetime) :: datetime
  def hours_after(hours, datetime), do: seconds_after(hours * @seconds_per_hour, datetime)

  @doc """
  Returns the UTC date and time the specified hours before the given datetime.

  ## Examples

      iex> 15 |> hours_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {3, 30, 45}}
  """
  @spec hours_before(integer, datetime) :: datetime
  def hours_before(hours, datetime), do: seconds_before(hours * @seconds_per_hour, datetime)

  @doc """
  Returns the UTC date and time an hour after the given datetime.

  ## Examples

      iex> an_hour_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {19, 30, 45}}
  """
  @spec an_hour_after(datetime) :: datetime
  def an_hour_after(datetime), do: hours_after(1, datetime)

  @doc """
  Returns the UTC date and time an hour before the given datetime.

  ## Examples

      iex> an_hour_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 27}, {17, 30, 45}}
  """
  @spec an_hour_before(datetime) :: datetime
  def an_hour_before(datetime), do: hours_before(1, datetime)

  @doc """
  Returns the UTC date and time the specified hours from now.

  ## Examples

      iex> 6 |> hours_from_now
      {{2015, 2, 28}, {0, 30, 45}}
  """
  @spec hours_from_now(integer) :: datetime
  def hours_from_now(hours), do: hours_after(hours, now)

  @doc """
  Returns the UTC date and time the specified hours ago.

  ## Examples

      iex> 2 |> hours_ago
      {{2015, 2, 27}, {16, 30, 45}}
  """
  @spec hours_ago(integer) :: datetime
  def hours_ago(hours), do: hours_before(hours, now)

  @doc """
  Returns the UTC date and time an hour from now.

  ## Examples

      iex> an_hour_from_now
      {{2015, 2, 27}, {19, 30, 45}}
  """
  @spec an_hour_from_now :: datetime
  def an_hour_from_now, do: hours_from_now(1)

  @doc """
  Returns the UTC date and time an hour ago.

  ## Examples

      iex> an_hour_ago
      {{2015, 2, 27}, {17, 30, 45}}
  """
  @spec an_hour_ago :: datetime
  def an_hour_ago, do: hours_ago(1)

  @doc """
  Returns the UTC date and time the specified days after the given datetime.

  ## Examples

      iex> 3 |> days_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 3, 2}, {18, 30, 45}}
  """
  @spec days_after(integer, datetime) :: datetime
  def days_after(days, datetime), do: seconds_after(days * @seconds_per_day, datetime)

  @doc """
  Returns the UTC date and time the specified days before the given datetime.

  ## Examples

      iex> 3 |> days_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 24}, {18, 30, 45}}
  """
  @spec days_before(integer, datetime) :: datetime
  def days_before(days, datetime), do: seconds_before(days * @seconds_per_day, datetime)

  @doc """
  Returns the UTC date and time a day after the given datetime.

  ## Examples

      iex> a_day_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 28}, {18, 30, 45}}
  """
  @spec a_day_after(datetime) :: datetime
  def a_day_after(datetime), do: days_after(1, datetime)

  @doc """
  Returns the UTC date and time a day before the given datetime.

  ## Examples

      iex> a_day_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 26}, {18, 30, 45}}
  """
  @spec a_day_before(datetime) :: datetime
  def a_day_before(datetime), do: days_before(1, datetime)

  @doc """
  Returns the UTC date and time the specified days from now.

  ## Examples

      iex> 2 |> days_from_now
      {{2015, 3, 1}, {18, 30, 45}}
  """
  @spec days_from_now(integer) :: datetime
  def days_from_now(days), do: days_after(days, now)

  @doc """
  Returns the UTC date and time the specified days ago.

  ## Examples

      iex> 7 |> days_ago
      {{2015, 2, 20}, {18, 30, 45}}
  """
  @spec days_ago(integer) :: datetime
  def days_ago(days), do: days_before(days, now)

  @doc """
  Returns the UTC date and time a day from now.

  ## Examples

      iex> a_day_from_now
      {{2015, 2, 28}, {18, 30, 45}}
  """
  @spec a_day_from_now :: datetime
  def a_day_from_now, do: days_from_now(1)

  @doc """
  Returns the UTC date and time a day ago.

  ## Examples

      iex> a_day_ago
      {{2015, 2, 26}, {18, 30, 45}}
  """
  @spec a_day_ago :: datetime
  def a_day_ago, do: days_ago(1)

  @doc """
  Returns the UTC date and time the specified weeks after the given datetime.

  ## Examples

      iex> 3 |> weeks_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 3, 20}, {18, 30, 45}}
  """
  @spec weeks_after(integer, datetime) :: datetime
  def weeks_after(weeks, datetime), do: seconds_after(weeks * @seconds_per_week, datetime)

  @doc """
  Returns the UTC date and time the specified weeks before the given datetime.

  ## Examples

      iex> 3 |> weeks_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 6}, {18, 30, 45}}
  """
  @spec weeks_before(integer, datetime) :: datetime
  def weeks_before(weeks, datetime), do: seconds_before(weeks * @seconds_per_week, datetime)

  @doc """
  Returns the UTC date and time a week after the given datetime.

  ## Examples

      iex> a_week_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 3, 6}, {18, 30, 45}}
  """
  @spec a_week_after(datetime) :: datetime
  def a_week_after(datetime), do: weeks_after(1, datetime)

  @doc """
  Returns the UTC date and time a week before the given datetime.

  ## Examples

      iex> a_week_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 2, 20}, {18, 30, 45}}
  """
  @spec a_week_before(datetime) :: datetime
  def a_week_before(datetime), do: weeks_before(1, datetime)

  @doc """
  Returns the UTC date and time the specified weeks from now.

  ## Examples

      iex> 2 |> weeks_from_now
      {{2015, 3, 13}, {18, 30, 45}}
  """
  @spec weeks_from_now(integer) :: datetime
  def weeks_from_now(weeks), do: weeks_after(weeks, now)

  @doc """
  Returns the UTC date and time the specified weeks ago.

  ## Examples

      iex> 2 |> weeks_ago
      {{2015, 2, 13}, {18, 30, 45}}
  """
  @spec weeks_ago(integer) :: datetime
  def weeks_ago(weeks), do: weeks_before(weeks, now)

  @doc """
  Returns the UTC date and time a week from now.

  ## Examples

      iex> a_week_from_now
      {{2015, 3, 6}, {18, 30, 45}}
  """
  @spec a_week_from_now :: datetime
  def a_week_from_now, do: weeks_from_now(1)

  @doc """
  Returns the UTC date and time a week ago.

  ## Examples

      iex> a_week_ago
      {{2015, 2, 20}, {18, 30, 45}}
  """
  @spec a_week_ago :: datetime
  def a_week_ago, do: weeks_ago(1)

  @doc """
  Returns the UTC date and time the specified months after the given datetime.

  ## Examples

      iex> 3 |> months_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 5, 27}, {18, 30, 45}}
  """
  @spec months_after(integer, datetime) :: datetime
  def months_after(months, {date, time}), do: {new_date(date, months), time}

  defp new_date(date, months) do
    date
    |> new_year_and_month(months)
    |> adjust_year_and_month
    |> adjust_for_last_day_of_month
  end

  defp new_year_and_month({year, month, day}, months) do
    {year + div(months, 12), month + rem(months, 12), day}
  end

  defp adjust_year_and_month({year, month, day}) when month < 1, do: {year - 1, month + 12, day}
  defp adjust_year_and_month({year, month, day}) when month > 12, do: {year + 1, month - 12, day}
  defp adjust_year_and_month(date), do: date

  defp adjust_for_last_day_of_month(date = {year, month, _}), do: {year, month, valid_day(date)}

  defp valid_day({year, month, day}) do
    [day, :calendar.last_day_of_the_month(year, month)]
    |> Enum.min
  end

  @doc """
  Returns the UTC date and time the specified months before the given datetime.

  ## Examples

      iex> 3 |> months_before {{2015, 2, 27}, {18, 30, 45}}
      {{2014, 11, 27}, {18, 30, 45}}
  """
  @spec months_before(integer, datetime) :: datetime
  def months_before(months, datetime), do: months_after(-months, datetime)

  @doc """
  Returns the UTC date and time a month after the given datetime.

  ## Examples

      iex> a_month_after {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 3, 27}, {18, 30, 45}}
  """
  @spec a_month_after(datetime) :: datetime
  def a_month_after(datetime), do: months_after(1, datetime)

  @doc """
  Returns the UTC date and time a month before the given datetime.

  ## Examples

      iex> a_month_before {{2015, 2, 27}, {18, 30, 45}}
      {{2015, 1, 27}, {18, 30, 45}}
  """
  @spec a_month_before(datetime) :: datetime
  def a_month_before(datetime), do: months_before(1, datetime)

  @doc """
  Returns the UTC date and time the specified months from now.

  ## Examples

      iex> 2 |> months_from_now
      {{2015, 4, 27}, {18, 30, 45}}
  """
  @spec months_from_now(integer) :: datetime
  def months_from_now(months), do: months_after(months, now)

  @doc """
  Returns the UTC date and time the specified months ago.

  ## Examples

      iex> 2 |> months_ago
      {{2014, 12, 27}, {18, 30, 45}}
  """
  @spec months_ago(integer) :: datetime
  def months_ago(months), do: months_before(months, now)

  @doc """
  Returns the UTC date and time a month from now.

  ## Examples

      iex> a_month_from_now
      {{2015, 3, 27}, {18, 30, 45}}
  """
  @spec a_month_from_now :: datetime
  def a_month_from_now, do: months_from_now(1)

  @doc """
  Returns the UTC date and time a month ago.

  ## Examples

      iex> a_month_ago
      {{2015, 1, 27}, {18, 30, 45}}
  """
  @spec a_month_ago :: datetime
  def a_month_ago, do: months_ago(1)

  @doc """
  Returns the UTC date and time the specified years after the given datetime.

  ## Examples

      iex> 3 |> years_after {{2015, 2, 27}, {18, 30, 45}}
      {{2018, 2, 27}, {18, 30, 45}}
  """
  @spec years_after(integer, datetime) :: datetime
  def years_after(years, datetime), do: months_after(years * @months_per_year, datetime)

  @doc """
  Returns the UTC date and time the specified years before the given datetime.

  ## Examples

      iex> 3 |> years_before {{2015, 2, 27}, {18, 30, 45}}
      {{2012, 2, 27}, {18, 30, 45}}
  """
  @spec years_before(integer, datetime) :: datetime
  def years_before(years, datetime), do: months_before(years * @months_per_year, datetime)

  @doc """
  Returns the UTC date and time a year after the given datetime.

  ## Examples

      iex> a_year_after {{2015, 2, 27}, {18, 30, 45}}
      {{2016, 2, 27}, {18, 30, 45}}
  """
  @spec a_year_after(datetime) :: datetime
  def a_year_after(datetime), do: years_after(1, datetime)

  @doc """
  Returns the UTC date and time a year before the given datetime.

  ## Examples

      iex> a_year_before {{2015, 2, 27}, {18, 30, 45}}
      {{2014, 2, 27}, {18, 30, 45}}
  """
  @spec a_year_before(datetime) :: datetime
  def a_year_before(datetime), do: years_before(1, datetime)

  @doc """
  Returns the UTC date and time the specified years from now.

  ## Examples

      iex> 2 |> years_from_now
      {{2017, 2, 27}, {18, 30, 45}}
  """
  @spec years_from_now(integer) :: datetime
  def years_from_now(years), do: years_after(years, now)

  @doc """
  Returns the UTC date and time the specified years ago.

  ## Examples

      iex> 2 |> years_ago
      {{2013, 2, 27}, {18, 30, 45}}
  """
  @spec years_ago(integer) :: datetime
  def years_ago(years), do: years_before(years, now)

  @doc """
  Returns the UTC date and time a year from now.

  ## Examples

      iex> a_year_from_now
      {{2016, 2, 27}, {18, 30, 45}}
  """
  @spec a_year_from_now :: datetime
  def a_year_from_now, do: years_from_now(1)

  @doc """
  Returns the UTC date and time a year ago.

  ## Examples

      iex> a_year_ago
      {{2014, 2, 27}, {18, 30, 45}}
  """
  @spec a_year_ago :: datetime
  def a_year_ago, do: years_ago(1)
end
