defmodule GoodTimes.Sugar do
  @moduledoc """
  Sugary convenience functions to manipulate datetimes.
  """

  import GoodTimesProposal, only: [now: 1, add: 3, subtract: 3]

  @type datetime :: GoodTimesProposal.moment
  @type date :: GoodTimesProposal.date


  ## SECONDS

  @doc """
  Add seconds. Equivalent to `add(datetime, integer, :seconds)`
  """
  @spec seconds_after(integer, datetime) :: datetime
  def seconds_after(seconds, datetime), do: add(datetime, seconds, :seconds)

  @doc """
  Subtract seconds. Equivalent to `subtract(datetime, integer, :seconds)`
  """
  @spec seconds_before(integer, datetime) :: datetime
  def seconds_before(seconds, datetime), do: seconds_after(-seconds, datetime)

  @doc """
  Add one second. Equivalent to `add(datetime, 1, :second)`
  """
  @spec a_second_after(datetime) :: datetime
  def a_second_after(datetime), do: seconds_after(1, datetime)

  @doc """
  Subtract one second. Equivalent to `subtract(datetime, 1, :second)`
  """
  @spec a_second_before(datetime) :: datetime
  def a_second_before(datetime), do: seconds_before(1, datetime)

  @doc """
  Add seconds to now. Equivalent to `add(now(format), seconds, :seconds)`
  """
  @spec seconds_from_now(integer) :: datetime
  @spec seconds_from_now(integer, :elixir | :erl) :: datetime
  def seconds_from_now(seconds, format \\ :elixir), do: seconds_after(seconds, now(format))

  @doc """
  Subtract seconds from now. Equivalent to `subtract(now(format), seconds, :seconds)`
  """
  @spec seconds_ago(integer) :: datetime
  @spec seconds_ago(integer, :elixir | :erl) :: datetime
  def seconds_ago(seconds, format \\ :elixir), do: seconds_from_now(-seconds, format)

  @doc """
  Add one second to now. Equivalent to `add(now(format), 1, :second)`
  """
  @spec a_second_from_now :: datetime
  @spec a_second_from_now(:elixir | :erl) :: datetime
  def a_second_from_now(format \\ :elixir), do: seconds_from_now(1, format)

  @doc """
  Subtract one second from now. Equivalent to `subtract(now(format), 1, :second)`
  """
  @spec a_second_ago :: datetime
  @spec a_second_ago(:elixir | :erl) :: datetime
  def a_second_ago(format \\ :elixir), do: seconds_ago(1, format)


  ## MINUTES

  @doc """
  Add minutes. Equivalent to `add(datetime, integer, :minutes)`
  """
  @spec minutes_after(integer, datetime) :: datetime
  def minutes_after(minutes, datetime), do: add(datetime, minutes, :minutes)

  @doc """
  Subtract minutes. Equivalent to `subtract(datetime, integer, :minutes)`
  """
  @spec minutes_before(integer, datetime) :: datetime
  def minutes_before(minutes, datetime), do: minutes_after(-minutes, datetime)

  @doc """
  Add one minute. Equivalent to `add(datetime, 1, :minute)`
  """
  @spec a_minute_after(datetime) :: datetime
  def a_minute_after(datetime), do: minutes_after(1, datetime)

  @doc """
  Subtract one minute. Equivalent to `subtract(datetime, 1, :minute)`
  """
  @spec a_minute_before(datetime) :: datetime
  def a_minute_before(datetime), do: minutes_before(1, datetime)

  @doc """
  Add minutes to now. Equivalent to `add(now(format), minutes, :minutes)`
  """
  @spec minutes_from_now(integer) :: datetime
  @spec minutes_from_now(integer, :elixir | :erl) :: datetime
  def minutes_from_now(minutes, format \\ :elixir), do: minutes_after(minutes, now(format))

  @doc """
  Subtract minutes from now. Equivalent to `subtract(now(format), minutes, :minutes)`
  """
  @spec minutes_ago(integer) :: datetime
  @spec minutes_ago(integer, :elixir | :erl) :: datetime
  def minutes_ago(minutes, format \\ :elixir), do: minutes_from_now(-minutes, format)

  @doc """
  Add one minute to now. Equivalent to `add(now(format), 1, :minute)`
  """
  @spec a_minute_from_now :: datetime
  @spec a_minute_from_now(:elixir | :erl) :: datetime
  def a_minute_from_now(format \\ :elixir), do: minutes_from_now(1, format)

  @doc """
  Subtract one minute from now. Equivalent to `subtract(now(format), 1, :minute)`
  """
  @spec a_minute_ago :: datetime
  @spec a_minute_ago(:elixir | :erl) :: datetime
  def a_minute_ago(format \\ :elixir), do: minutes_ago(1, format)


  ## HOURS

  @doc """
  Add hours. Equivalent to `add(datetime, integer, :hours)`
  """
  @spec hours_after(integer, datetime) :: datetime
  def hours_after(hours, datetime), do: add(datetime, hours, :hours)

  @doc """
  Subtract hours. Equivalent to `subtract(datetime, integer, :hours)`
  """
  @spec hours_before(integer, datetime) :: datetime
  def hours_before(hours, datetime), do: hours_after(-hours, datetime)

  @doc """
  Add one hour. Equivalent to `add(datetime, 1, :hour)`
  """
  @spec an_hour_after(datetime) :: datetime
  def an_hour_after(datetime), do: hours_after(1, datetime)

  @doc """
  Subtract one hour. Equivalent to `subtract(datetime, 1, :hour)`
  """
  @spec an_hour_before(datetime) :: datetime
  def an_hour_before(datetime), do: hours_before(1, datetime)

  @doc """
  Add hours to now. Equivalent to `add(now(format), hours, :hours)`
  """
  @spec hours_from_now(integer) :: datetime
  @spec hours_from_now(integer, :elixir | :erl) :: datetime
  def hours_from_now(hours, format \\ :elixir), do: hours_after(hours, now(format))

  @doc """
  Subtract hours from now. Equivalent to `subtract(now(format), hours, :hours)`
  """
  @spec hours_ago(integer) :: datetime
  @spec hours_ago(integer, :elixir | :erl) :: datetime
  def hours_ago(hours, format \\ :elixir), do: hours_from_now(-hours, format)

  @doc """
  Add one hour to now. Equivalent to `add(now(format), 1, :hour)`
  """
  @spec an_hour_from_now :: datetime
  @spec an_hour_from_now(:elixir | :erl) :: datetime
  def an_hour_from_now(format \\ :elixir), do: hours_from_now(1, format)

  @doc """
  Subtract one hour from now. Equivalent to `subtract(now(format), 1, :hour)`
  """
  @spec an_hour_ago :: datetime
  @spec an_hour_ago(:elixir | :erl) :: datetime
  def an_hour_ago(format \\ :elixir), do: hours_ago(1, format)


  ## DAYS

  @doc """
  Add days. Equivalent to `add(datetime, integer, :days)`
  """
  @spec days_after(integer, datetime) :: datetime
  def days_after(days, datetime), do: add(datetime, days, :days)

  @doc """
  Subtract days. Equivalent to `subtract(datetime, integer, :days)`
  """
  @spec days_before(integer, datetime) :: datetime
  def days_before(days, datetime), do: days_after(-days, datetime)

  @doc """
  Add one day. Equivalent to `add(datetime, 1, :day)`
  """
  @spec a_day_after(datetime) :: datetime
  def a_day_after(datetime), do: days_after(1, datetime)

  @doc """
  Subtract one day. Equivalent to `subtract(datetime, 1, :day)`
  """
  @spec a_day_before(datetime) :: datetime
  def a_day_before(datetime), do: days_before(1, datetime)

  @doc """
  Add days to now. Equivalent to `add(now(format), days, :days)`
  """
  @spec days_from_now(integer) :: datetime
  @spec days_from_now(integer, :elixir | :erl) :: datetime
  def days_from_now(days, format \\ :elixir), do: days_after(days, now(format))

  @doc """
  Subtract days from now. Equivalent to `subtract(now(format), days, :days)`
  """
  @spec days_ago(integer) :: datetime
  @spec days_ago(integer, :elixir | :erl) :: datetime
  def days_ago(days, format \\ :elixir), do: days_from_now(-days, format)

  @doc """
  Add one day to now. Equivalent to `add(now(format), 1, :day)`
  """
  @spec a_day_from_now :: datetime
  @spec a_day_from_now(:elixir | :erl) :: datetime
  def a_day_from_now(format \\ :elixir), do: days_from_now(1, format)

  @doc """
  Subtract one day from now. Equivalent to `subtract(now(format), 1, :day)`
  """
  @spec a_day_ago :: datetime
  @spec a_day_ago(:elixir | :erl) :: datetime
  def a_day_ago(format \\ :elixir), do: days_ago(1, format)


  ## WEEKS

  @doc """
  Add weeks. Equivalent to `add(datetime, integer, :weeks)`
  """
  @spec weeks_after(integer, datetime) :: datetime
  def weeks_after(weeks, datetime), do: add(datetime, weeks, :weeks)

  @doc """
  Subtract weeks. Equivalent to `subtract(datetime, integer, :weeks)`
  """
  @spec weeks_before(integer, datetime) :: datetime
  def weeks_before(weeks, datetime), do: weeks_after(-weeks, datetime)

  @doc """
  Add one week. Equivalent to `add(datetime, 1, :week)`
  """
  @spec a_week_after(datetime) :: datetime
  def a_week_after(datetime), do: weeks_after(1, datetime)

  @doc """
  Subtract one week. Equivalent to `subtract(datetime, 1, :week)`
  """
  @spec a_week_before(datetime) :: datetime
  def a_week_before(datetime), do: weeks_before(1, datetime)

  @doc """
  Add weeks to now. Equivalent to `add(now(format), weeks, :weeks)`
  """
  @spec weeks_from_now(integer) :: datetime
  @spec weeks_from_now(integer, :elixir | :erl) :: datetime
  def weeks_from_now(weeks, format \\ :elixir), do: weeks_after(weeks, now(format))

  @doc """
  Subtract weeks from now. Equivalent to `subtract(now(format), weeks, :weeks)`
  """
  @spec weeks_ago(integer) :: datetime
  @spec weeks_ago(integer, :elixir | :erl) :: datetime
  def weeks_ago(weeks, format \\ :elixir), do: weeks_from_now(-weeks, format)

  @doc """
  Add one week to now. Equivalent to `add(now(format), 1, :week)`
  """
  @spec a_week_from_now :: datetime
  @spec a_week_from_now(:elixir | :erl) :: datetime
  def a_week_from_now(format \\ :elixir), do: weeks_from_now(1, format)

  @doc """
  Subtract one week from now. Equivalent to `subtract(now(format), 1, :week)`
  """
  @spec a_week_ago :: datetime
  @spec a_week_ago(:elixir | :erl) :: datetime
  def a_week_ago(format \\ :elixir), do: weeks_ago(1, format)


  ## MONTHS

  @doc """
  Add months. Equivalent to `add(datetime, integer, :months)`
  """
  @spec months_after(integer, datetime) :: datetime
  def months_after(months, datetime), do: add(datetime, months, :months)

  @doc """
  Subtract months. Equivalent to `subtract(datetime, integer, :months)`
  """
  @spec months_before(integer, datetime) :: datetime
  def months_before(months, datetime), do: months_after(-months, datetime)

  @doc """
  Add one month. Equivalent to `add(datetime, 1, :month)`
  """
  @spec a_month_after(datetime) :: datetime
  def a_month_after(datetime), do: months_after(1, datetime)

  @doc """
  Subtract one month. Equivalent to `subtract(datetime, 1, :month)`
  """
  @spec a_month_before(datetime) :: datetime
  def a_month_before(datetime), do: months_before(1, datetime)

  @doc """
  Add months to now. Equivalent to `add(now(format), months, :months)`
  """
  @spec months_from_now(integer) :: datetime
  @spec months_from_now(integer, :elixir | :erl) :: datetime
  def months_from_now(months, format \\ :elixir), do: months_after(months, now(format))

  @doc """
  Subtract months from now. Equivalent to `subtract(now(format), months, :months)`
  """
  @spec months_ago(integer) :: datetime
  @spec months_ago(integer, :elixir | :erl) :: datetime
  def months_ago(months, format \\ :elixir), do: months_from_now(-months, format)

  @doc """
  Add one month to now. Equivalent to `add(now(format), 1, :month)`
  """
  @spec a_month_from_now :: datetime
  @spec a_month_from_now(:elixir | :erl) :: datetime
  def a_month_from_now(format \\ :elixir), do: months_from_now(1, format)

  @doc """
  Subtract one month from now. Equivalent to `subtract(now(format), 1, :month)`
  """
  @spec a_month_ago :: datetime
  @spec a_month_ago(:elixir | :erl) :: datetime
  def a_month_ago(format \\ :elixir), do: months_ago(1, format)


  ## YEARS

  @doc """
  Add years. Equivalent to `add(datetime, integer, :years)`
  """
  @spec years_after(integer, datetime) :: datetime
  def years_after(years, datetime), do: add(datetime, years, :years)

  @doc """
  Subtract years. Equivalent to `subtract(datetime, integer, :years)`
  """
  @spec years_before(integer, datetime) :: datetime
  def years_before(years, datetime), do: years_after(-years, datetime)

  @doc """
  Add one year. Equivalent to `add(datetime, 1, :year)`
  """
  @spec a_year_after(datetime) :: datetime
  def a_year_after(datetime), do: years_after(1, datetime)

  @doc """
  Subtract one year. Equivalent to `subtract(datetime, 1, :year)`
  """
  @spec a_year_before(datetime) :: datetime
  def a_year_before(datetime), do: years_before(1, datetime)

  @doc """
  Add years to now. Equivalent to `add(now(format), years, :years)`
  """
  @spec years_from_now(integer) :: datetime
  @spec years_from_now(integer, :elixir | :erl) :: datetime
  def years_from_now(years, format \\ :elixir), do: years_after(years, now(format))

  @doc """
  Subtract years from now. Equivalent to `subtract(now(format), years, :years)`
  """
  @spec years_ago(integer) :: datetime
  @spec years_ago(integer, :elixir | :erl) :: datetime
  def years_ago(years, format \\ :elixir), do: years_from_now(-years, format)

  @doc """
  Add one year to now. Equivalent to `add(now(format), 1, :year)`
  """
  @spec a_year_from_now :: datetime
  @spec a_year_from_now(:elixir | :erl) :: datetime
  def a_year_from_now(format \\ :elixir), do: years_from_now(1, format)

  @doc """
  Subtract one year from now. Equivalent to `subtract(now(format), 1, :year)`
  """
  @spec a_year_ago :: datetime
  @spec a_year_ago(:elixir | :erl) :: datetime
  def a_year_ago(format \\ :elixir), do: years_ago(1, format)


  ## DATES

  @doc """
  One day before now, converted to date. Equivalent to
  `now |> subtract(1, :day) |> NaiveDateTime.to_date` or
  `{date, _} = now(:erl) |> subtract(1, :day)`
  """
  @spec yesterday :: Date.t
  @spec yesterday(:elixir | :erl) :: date
  def yesterday, do: yesterday(:elixir)
  def yesterday(:elixir) do
    now(:elixir)
    |> subtract(1, :day)
    |> NaiveDateTime.to_date
  end
  def yesterday(:erl) do
    {date, _} = now(:erl)
      |> subtract(1, :day)
    date
  end

  @doc """
  Now, converted to date. Equivalent to `now |> NaiveDateTime.to_date` or `{date, _} = now(:erl)`
  """
  @spec today :: Date.t
  @spec today(:elixir | :erl) :: date
  def today, do: today(:elixir)
  def today(:elixir) do
    now(:elixir)
    |> NaiveDateTime.to_date
  end
  def today(:erl) do
    {date, _} = now(:erl)
    date
  end

  @doc """
  One day after now, converted to date. Equivalent to
  `now |> add(1, :day) |> NaiveDateTime.to_date` or
  `{date, _} = now(:erl) |> add(1, :day)`
  """
  @spec tomorrow :: Date.t
  @spec tomorrow(:elixir | :erl) :: date
  def tomorrow, do: tomorrow(:elixir)
  def tomorrow(:elixir) do
    now(:elixir)
    |> add(1, :day)
    |> NaiveDateTime.to_date
  end
  def tomorrow(:erl) do
    {date, _} = now(:erl)
      |> add(1, :day)
    date
  end
end
