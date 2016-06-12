defmodule GoodTimesProposal do
  @moduledoc """
  Convenient and expressive functions dealing with dates and times.

  GoodTimesProposal provides the flexibility to work with either the Elixir types
  (`Date`, `Time` and `NaiveDateTime`) or Erlang's date, time and datetime
  tuples. Output will match the input.

  For both Elixir and Erlang formats, datetime arithmetic assumes an ISO calendar,
  i.e. 12 months in a year, 28-31 days in a month, 7 days in a week, etc.

  GoodTimesProposal does not support Elixir's non-naïve `DateTime` struct.


  ## Deprecation of the 1.x API

  The pre-2.0 functions in the main `GoodTimes` module have been deprecated.
  There is an equivalent way to express each of them in the new API. Deprecation
  warnings will help you move to the new API.

  The exception is `now/0` that has a breaking change. In 1.x it returned an
  Erlang datetime tuple. Since 2.0, it returns a NaiveDateTime struct. You can
  call `now/1` with `:erl` as argument to get the old behaviour.

  Functions in `GoodTimes.Date` have been moved to the main module, with a
  behaviour change similar to `now/0`. They are still available in
  `Goodtimes.Date` with the old behaviour, but are deprecated.

  Functions in `GoodTimes.Convert` have all been deprecated. The `from_date`
  function is essentially `at(date, {0, 0, 0})`, while `to_date` and `to_time`
  have equivalents in NaiveDateTime, and are trivial with pattern matching, or
  with `elem/2` on an Erlang datetime tuple.

  Pre-2.0 functions in `GoodTimes.Boundary` have all been deprecated. Instead
  use `beginning_of/2` and `end_of/2`. They take a datetime and a unit of time.

  Pre-2.0 functions in `GoodTimes.Generate` have all been deprecated. Instead
  use `forward/2` and `backward/2`. They take a datetime and a unit of time.


  ## Options

  - `:precision`, integer 0..6. Specify the precision when adding subsecond units.
    If not set, precision is set for significant digits.


  ## Units

  - :year or :years
  - :month or :months
  - :week or :weeks
  - :day or :days
  - :hour or :hours
  - :minute or :minutes
  - :second or :seconds
  - :millisecond or :milliseconds (only for Calendar structs)
  - :microsecond or :microseconds (only for Calendar structs)


  ## Examples

  You can add a unit of time to a Date, Time or NaiveDateTime.

      iex> ~D[2016-06-03] |> add(1, :day)
      ~D[2016-06-04]
      iex> ~T[12:30:00] |> add(15, :seconds)
      ~T[12:30:15]
      iex> ~N[2016-06-03 12:30:00] |> add(12, :hours)
      ~N[2016-06-04 00:30:00]

  You can add negative units of time. Also see `subtract/2` and `subtract/3`.

      iex> ~D[2016-06-03] |> add(-1, :day)
      ~D[2016-06-02]

  Time and NaiveDateTime can have sub-second units. We only assume precision for
  significant digits, unless you specify it with the `precision` option.

      iex> ~T[12:30:00] |> add(5, :milliseconds)
      ~T[12:30:00.005]
      iex> ~T[12:30:00] |> add(500, :milliseconds)
      ~T[12:30:00.5]
      iex> ~T[12:30:00] |> add(500_000, :microseconds, precision: 6)
      ~T[12:30:00.500000]

  You can add different units, and mix positive and negative units of time.

      iex> ~D[2016-06-03] |> add(day: 1, year: 2)
      ~D[2018-06-04]
      iex> ~T[12:30:00] |> add(hours: 4, minute: -1)
      ~T[16:29:00]
      iex> ~N[2016-06-03 12:30:00] |> add(months: 2, hours: 15)
      ~N[2016-08-04 03:30:00]

  Date and Time will only add units relevant to them.

      iex> ~D[2016-06-03] |> add(1, :second)
      ** (ArgumentError) Cannot add second to date

      iex> ~T[12:30:00] |> add(1, :day)
      ** (ArgumentError) Cannot add day to time

  We can also add to dates, times and datetimes in Erlang tuple format. If so,
  the function will return in the same format.

      iex> {2016, 6, 3} |> add(1, :day)
      {2016, 6, 4}
      iex> {12, 30, 0} |> add(15, :seconds)
      {12, 30, 15}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> add(12, :hours)
      {{2016, 6, 4}, {0, 30, 0}}

      iex> {2016, 6, 3} |> add(-1, :day)
      {2016, 6, 2}

      iex> {2016, 6, 3} |> add(day: 1, year: 2)
      {2018, 6, 4}
      iex> {12, 30, 0} |> add(hours: 4, minute: -1)
      {16, 29, 0}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> add(months: 2, hours: 15)
      {{2016, 8, 4}, {3, 30, 0}}

  Sub-second units are not supported for Erlang time tuples.

      iex> {12, 30, 0} |> add(1, :millisecond)
      ** (ArgumentError) Cannot add millisecond to Erlang time tuple

  You can retrieve the current NaiveDateTime with `now/0`. This is a breaking
  change from the 1.x behaviour. Get an Erlang datetime tuple with `now(:erl)`.

      iex> now
      ~N[2016-06-04 00:27:44]
      iex> now(:erl)
      {{2016, 6, 4} {0, 27, 44}}

  Functionality in `GoodTimes.Date` have been moved to the main module, and
  behave similar to `now/0` and `now/1`. The functions in `GoodTimes.Date`
  retain their old behaviour (returning Erlang date tuples), but are deprecated.

      iex> today
      ~D[2016-06-04]
      iex> yesterday
      ~D[2016-06-03]
      iex> tomorrow
      ~D[2016-06-05]
      iex> today(:erl)
      {2016, 6, 4}
      iex> yesterday(:erl)
      {2016, 6, 3}
      iex> tomorrow(:erl)
      {2016, 6, 5}

  You can construct a datetime from a date and time, or change the time of a
  datetime with `at/2`. It is possible to mix formats, but output will match
  the first argument.

      iex> ~D[2016-06-04] |> at(~T[12:30:00])
      ~N[2016-06-04 12:30:00]
      iex> ~N[2016-06-04 00:00:00] |> at(~T[12:30:00])
      ~N[2016-06-04 12:30:00]
      iex> {2016, 6, 4} |> at({12, 30, 0})
      {{2016, 6, 4}, {12, 30, 0}}
      iex> {{2016, 6, 4}, {0, 0, 0}} |> at( {12, 30, 0})
      {{2016, 6, 4}, {12, 30, 0}}
      iex> ~N[2016-06-04 00:00:00] |> at({12, 30, 0})
      ~N[2016-06-04 12:30:00]
      iex> {2016, 6, 4} |> at(~T[12:30:00])
      {{2016, 6, 4}, {12, 30, 0}}
  """

  @type moment :: date | time | datetime
  @type date :: Date.t | {Calendar.year, Calendar.month, Calendar.day}
  @type time :: Time.t | {Calendar.hour, Calendar.minute, Calendar.second}
  @type datetime :: NaiveDateTime.t | {date, time}
  @type unit :: :year  | :month   | :week    | :day  |
                :years | :months  | :weeks   | :days |
                :hour  | :minute  | :second  |
                :hours | :minutes | :seconds |
                :millisecond      | :microsecond |
                :milliseconds     | :microseconds
  @type format :: :elixir | :erl

  @date_units [:year, :years, :month, :months, :week, :weeks, :day, :days]
  @time_units [:hour, :hours, :minute, :minutes, :second, :seconds]
  @subsecond_units [:millisecond, :milliseconds, :microsecond, :microseconds]
  @all_time_units @time_units ++ @subsecond_units
  @datetime_units @date_units ++ @time_units

  @seconds_per_minute 60
  @seconds_per_hour 60 * @seconds_per_minute
  @seconds_per_day 24 * @seconds_per_hour
  @seconds_per_week 7 * @seconds_per_day
  @months_per_year 12

  @doc """
  Add a duration of time to a date, time or datetime.

  ## Examples

  You can add a unit of time to a Date, Time or NaiveDateTime.

      iex> ~D[2016-06-03] |> add(1, :day)
      ~D[2016-06-04]
      iex> ~T[12:30:00] |> add(15, :seconds)
      ~T[12:30:15]
      iex> ~N[2016-06-03 12:30:00] |> add(12, :hours)
      ~N[2016-06-04 00:30:00]

  You can add negative units of time. Also see `subtract/2` and `subtract/3`.

      iex> ~D[2016-06-03] |> add(-1, :day)
      ~D[2016-06-02]

  Time and NaiveDateTime accept sub-second units. You can specify precision with
  the `precision` option. Default is to use the lower one of the original
  precision or the significant digits of the delta.

      iex> ~T[12:30:00] |> add(5, :milliseconds)
      ~T[12:30:00.005]
      iex> ~T[12:30:00] |> add(500, :milliseconds)
      ~T[12:30:00.5]
      iex> ~T[12:30:00] |> add(500_000, :microseconds, precision: 6)
      ~T[12:30:00.500000]
      iex> ~T[12:30:00] |> add(1, :microseconds, precision: 3)
      ~T[12:30:00.000]

  You can add different units at once.

      iex> ~D[2016-06-03] |> add(day: 1, year: 2)
      ~D[2018-06-04]
      iex> ~T[12:30:00] |> add(hours: 4, minute: -1)
      ~T[16:29:00]
      iex> ~N[2016-06-03 12:30:00] |> add(months: 2, hours: 15)
      ~N[2016-08-04 03:30:00]

  Date and Time will only add units relevant to them.

      iex> ~D[2016-06-03] |> add(1, :second)
      ** (ArgumentError) Cannot add second to date

      iex> ~T[12:30:00] |> add(1, :day)
      ** (ArgumentError) Cannot add day to time

  GoodTimes also accepts dates, times and datetimes in Erlang tuple format.
  The return value will match the input.

      iex> {2016, 6, 3} |> add(1, :day)
      {2016, 6, 4}
      iex> {12, 30, 0} |> add(15, :seconds)
      {12, 30, 15}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> add(12, :hours)
      {{2016, 6, 4}, {0, 30, 0}}

      iex> {2016, 6, 3} |> add(-1, :day)
      {2016, 6, 2}

      iex> {2016, 6, 3} |> add(day: 1, year: 2)
      {2018, 6, 4}
      iex> {12, 30, 0} |> add(hours: 4, minute: -1)
      {16, 29, 0}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> add(months: 2, hours: 15)
      {{2016, 8, 4}, {3, 30, 0}}

  Sub-second units are not supported for Erlang time tuples.

      iex> {12, 30, 0} |> add(1, :millisecond)
      ** (ArgumentError) Cannot add millisecond to Erlang time tuple
  """
  @spec add(moment, integer, unit) :: moment
  @spec add(moment, integer, unit, Keyword.t) :: moment
  def add(moment, n, unit, opts \\ [])
  def add(moment, n, unit, opts) do
    case {moment, unit} do
      {%Time{}, _} when unit in @all_time_units ->
        add_time(moment, n, unit, opts)
      {{h, m, s}, unit} when unit in @time_units and h in 0..23 and m in 0..59 and s in 0..60 ->
        add_time(moment, n, unit, opts)
      {{_,_,_}, unit} when unit in @subsecond_units ->
        raise ArgumentError, "Cannot add #{unit} to Erlang time tuple"
      {%Time{}, unit} ->
        raise ArgumentError, "Cannot add #{unit} to time"
      {{h, m, s}, unit} when h in 0..23 and m in 0..59 and s in 0..60 ->
        raise ArgumentError, "Cannot add #{unit} to time"

      {%Date{}, unit} when unit in @date_units ->
        add_date(moment, n, unit, opts)
      {{y, m, d}, unit} when unit in @date_units and y > 0 and m in 1..12 and d in 1..31 ->
        add_date(moment, n, unit, opts)
      {%Date{}, unit} ->
        raise ArgumentError, "Cannot add #{unit} to date"
      {{y, m, d}, unit} when y > 0 and m in 1..12 and d in 1..31 ->
        raise ArgumentError, "Cannot add #{unit} to date"

      {%NaiveDateTime{}, _} ->
        add_datetime(moment, n, unit, opts)
      {{{_,_,_}, {_,_,_}}, unit} when unit in @subsecond_units ->
        raise ArgumentError, "Cannot add #{unit} to Erlang datetime tuple"
      {{{_,_,_}, {_,_,_}}, _} ->
        add_datetime(moment, n, unit, opts)
    end
  end

  def subtract(moment, n, unit, opts \\ []), do: add(moment, -n, unit, opts)

  defp add_time(%Time{} = time, n, unit, opts) when unit in [:microsecond, :microseconds] do
    {seconds, microseconds} = add_microseconds(time, n, opts)
    %{add_time(time, seconds, :seconds, opts) | microsecond: microseconds}
  end
  defp add_time(%Time{} = time, n, unit, opts) when unit in [:millisecond, :milliseconds], do:
    add_time(time, n * 1000, :microseconds, opts)
  defp add_time(%Time{} = time, n, unit, opts) do
    time
    |> Time.to_erl
    |> add_time(n, unit, opts)
    |> Time.from_erl!(time.microsecond)
  end

  defp add_time(time, n, unit, _opts) when unit in [:second, :seconds] do
    :calendar.time_to_seconds(time) + rem(n, 24*60*60)
    |> :calendar.seconds_to_time
  end
  defp add_time(time, n, unit, opts) when unit in [:minute, :minutes], do:
    add_time(time, n * 60, :seconds, opts)
  defp add_time(time, n, unit, opts) when unit in [:hour, :hours], do:
    add_time(time, n * 60*60, :seconds, opts)

  defp add_microseconds(time, n, opts) do
    {us, old_precision} = time.microsecond
    total_us = us + n
    seconds = div(total_us, 1_000_000)
    new_us = rem(total_us, 1_000_000)
    new_precision = opts[:precision] || Enum.min([old_precision, micro_precision(n)])

    {seconds, {new_us, new_precision}}
  end

  defp micro_precision(n) when n in 0..999_999 do
    n
    |> to_string
    |> String.pad_leading(6, "0")
    |> String.trim_trailing("0")
    |> String.length
  end

  defp add_date(%Date{} = date, n, unit, opts) do
    date
    |> Date.to_erl
    |> add_date(n, unit, opts)
    |> Date.from_erl!
  end
  defp add_date({_,_,_} = date, n, unit, _opts) when unit in [:day, :days] do
    :calendar.date_to_gregorian_days(date) + n
    |> :calendar.gregorian_days_to_date
  end
  defp add_date({_,_,_} = date, n, unit, opts) when unit in [:week, :weeks], do:
    add_date(date, n * 7, :days, opts)
  defp add_date({_,_,_} = date, n, unit, _opts) when unit in [:month, :months], do:
    add_months(date, n)
  defp add_date({_,_,_} = date, n, unit, opts) when unit in [:year, :years], do:
    add_date(date, n * 12, :months, opts)

  defp add_months(date, months) do
    date
    |> simple_add_month(months)
    |> adjust_for_new_year
    |> adjust_for_last_day_of_month
  end

  defp simple_add_month({year, month, day}, months) do
    {year + div(months, 12), month + rem(months, 12), day}
  end

  defp adjust_for_new_year({year, month, day}) when month < 1, do: {year - 1, month + 12, day}
  defp adjust_for_new_year({year, month, day}) when month > 12, do: {year + 1, month - 12, day}
  defp adjust_for_new_year(date), do: date

  defp adjust_for_last_day_of_month({year, month, day}) do
    {year, month, Enum.min([day, :calendar.last_day_of_the_month(year, month)])}
  end

  defp add_datetime(%NaiveDateTime{} = dt, n, unit, opts) when unit in [:microsecond, :microseconds] do
    {seconds, microseconds} = add_microseconds(dt, n, opts)
    %{add_datetime(dt, seconds, :seconds, opts) | microsecond: microseconds}
  end
  defp add_datetime(%NaiveDateTime{} = dt, n, unit, opts) when unit in [:millisecond, :milliseconds], do:
    add_datetime(dt, n*1000, :microseconds, opts)
  defp add_datetime(%NaiveDateTime{} = dt, n, unit, opts) do
    dt
    |> NaiveDateTime.to_erl
    |> add_datetime(n, unit, opts)
    |> NaiveDateTime.from_erl!(dt.microsecond)
  end

  defp add_datetime({{_,_,_}, {_,_,_}} = dt, n, unit, _opts) when unit in [:second, :seconds] do
    :calendar.datetime_to_gregorian_seconds(dt) + n
    |> :calendar.gregorian_seconds_to_datetime
  end
  defp add_datetime(dt, n, unit, opts) when unit in [:minute, :minutes], do:
    add_datetime(dt, n*60, :seconds, opts)
  defp add_datetime(dt, n, unit, opts) when unit in [:hour, :hours], do:
    add_datetime(dt, n*60*60, :seconds, opts)
  defp add_datetime(dt, n, unit, opts) when unit in [:day, :days], do:
    add_datetime(dt, n*60*60*24, :seconds, opts)
  defp add_datetime(dt, n, unit, opts) when unit in [:week, :weeks], do:
    add_datetime(dt, n*60*60*24*7, :seconds, opts)
  defp add_datetime({date, time}, n, unit, _opts) when unit in [:month, :months] do
    {add_months(date, n), time}
  end
  defp add_datetime(dt, n, unit, opts) when unit in [:year, :years], do:
    add_datetime(dt, n*12, :months, opts)

  @spec now() :: NaiveDateTime.t
  @spec now(format) :: datetime
  def now(_format \\ :elixir)
  def now(:elixir), do: NaiveDateTime.from_erl!(now(:erl))
  def now(:erl), do: :calendar.universal_time

  @spec at(date, time) :: datetime
  @spec at(datetime, time) :: datetime
  def at(_moment, _time) do
  end
end
