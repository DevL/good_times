defmodule GoodTimesProposal do
  @moduledoc """
  Convenient and expressive functions dealing with dates and times.

  GoodTimes provides the flexibility to work with either the Elixir types
  (`Date`, `Time` and `NaiveDateTime`) or Erlang's date, time and datetime
  tuples. Output will match the input.

  For both Elixir and Erlang formats, datetime arithmetic assumes an ISO calendar,
  i.e. 12 months in a year, 28-31 days in a month, 7 days in a week, etc.

  GoodTimes does not support Elixir's non-naïve `DateTime` struct.


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

  - `:precise`, boolean. Whether to assume precision for sub-second units.
    Default is to only assume precision for significant digits.
  - `:not_negative`, boolean. Whether to allow negative units of time. Raises
    ArgumentError if set and a unit of time is negative. Defaults is to allow
    negative values.


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

      iex> ~D[2016-06-03] |> GoodTimes.add(1, :day)
      ~D[2016-06-04]
      iex> ~T[12:30:00] |> GoodTimes.add(15, :seconds)
      ~T[12:30:15]
      iex> ~N[2016-06-03 12:30:00] |> GoodTimes.add(12, :hours)
      ~N[2016-06-04 00:30:00]

  You can add negative units of time, unless `:not_negative` is set. Also see
  `subtract/2` and `subtract/3`.

      iex> ~D[2016-06-03] |> GoodTimes.add(-1, :day)
      ~D[2016-06-02]
      iex> ~D[2016-06-03] |> GoodTimes.add(-1, :day, not_negative: true)
      ArgumentError

  Time can have sub-second units. We only assume precision for significant digits,
  unless you set the option `precise: true`.

      iex> ~T[12:30:00] |> GoodTimes.add(5, :milliseconds)
      ~T[12:30:00.005]
      iex> ~T[12:30:00] |> GoodTimes.add(500, :milliseconds)
      ~T[12:30:00.5]
      iex> ~T[12:30:00] |> GoodTimes.add(500_000, :microseconds, precise: true)
      ~T[12:30:00.500000]

  You can add different units, and mix positive and negative units of time.

      iex> ~D[2016-06-03] |> GoodTimes.add(day: 1, year: 2)
      ~D[2018-06-04]
      iex> ~T[12:30:00] |> GoodTimes.add(hours: 4, minute: -1)
      ~T[16:29:00]
      iex> ~N[2016-06-03 12:30:00] |> GoodTimes.add(months: 2, hours: 15)
      ~N[2016-08-04 03:30:00]
      iex> ~D[2016-06-03] |> GoodTimes.add(day: -1, year: 2)
      ArgumentError

  Date and Time will only add units relevant to them.

      iex> ~D[2016-06-03] |> GoodTimes.add(1, :second)
      ArgumentError
      iex> ~T[12:30:00] |> GoodTimes.add(1, :day)
      ArgumentError

  We can also add to dates, times and datetimes in Erlang tuple format. If so,
  the function will return in the same format.

      iex> {2016, 6, 3} |> GoodTimes.add(1, :day)
      {2016, 6, 4}
      iex> {12, 30, 0} |> GoodTimes.add(15, :seconds)
      {12, 30, 15}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> GoodTimes.add(12, :hours)
      {{2016, 6, 4}, {0, 30, 0}}

      iex> {2016, 6, 3} |> GoodTimes.add(-1, :day)
      {2016, 6, 2}

      iex> {2016, 6, 3} |> GoodTimes.add(day: 1, year: 2)
      {2018, 6, 4}
      iex> {12, 30, 0} |> GoodTimes.add(hours: 4, minute: -1)
      {16, 29, 0}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> GoodTimes.add(months: 2, hours: 15)
      {{2016, 8, 4}, {3, 30, 0}}

  Sub-second units are not supported for Erlang time tuples.

      iex> {2016, 6, 3} |> GoodTimes.add(1, :second)
      ArgumentError
      iex> {12, 30, 0} |> GoodTimes.add(1, :day)
      ArgumentError
      iex> {12, 30, 0} |> GoodTimes.add(1, :millisecond)
      ArgumentError

  You can retrieve the current NaiveDateTime with `now/0`. This is a breaking
  change from the 1.x behaviour. Get an Erlang datetime tuple with `now/1`.

      iex> GoodTimes.now
      ~N[2016-06-04 00:27:44]
      iex> GoodTimes.now(:erl)
      {{2016, 6, 4} {0, 27, 44}}

  Functionality in `GoodTimes.Date` have been moved to the main module, and
  behave similar to `now/0` and `now/1`. The functions in `GoodTimes.Date`
  retain their old behaviour (returning Erlang date tuples), but are deprecated.

      iex> GoodTimes.today
      ~D[2016-06-04]
      iex> GoodTimes.yesterday
      ~D[2016-06-03]
      iex> GoodTimes.tomorrow
      ~D[2016-06-05]
      iex> GoodTimes.today(:erl)
      {2016, 6, 4}
      iex> GoodTimes.yesterday(:erl)
      {2016, 6, 3}
      iex> GoodTimes.tomorrow(:erl)
      {2016, 6, 5}

  You can construct a datetime from a date and time, or change the time of a
  datetime with `at/2`. It is possible to mix formats, but output will match
  the first argument.

      iex> GoodTimes.at(~D[2016-06-04], ~T[12:30:00])
      ~N[2016-06-04 12:30:00]
      iex> GoodTimes.at(~N[2016-06-04 00:00:00], ~T[12:30:00])
      ~N[2016-06-04 12:30:00]
      iex> GoodTimes.at({2016, 6, 4}, {12, 30, 0})
      {{2016, 6, 4}, {12, 30, 0}}
      iex> GoodTimes.at({{2016, 6, 4}, {0, 0, 0}}, {12, 30, 0})
      {{2016, 6, 4}, {12, 30, 0}}
      iex> GoodTimes.at(~N[2016-06-04 00:00:00], {12, 30, 0})
      ~N[2016-06-04 12:30:00]
      iex> GoodTimes.at({2016, 6, 4}, ~T[12:30:00])
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

      iex> ~D[2016-06-03] |> GoodTimes.add(1, :day)
      ~D[2016-06-04]
      iex> ~T[12:30:00] |> GoodTimes.add(15, :seconds)
      ~T[12:30:15]
      iex> ~N[2016-06-03 12:30:00] |> GoodTimes.add(12, :hours)
      ~N[2016-06-04 00:30:00]

  You can add negative units of time, unless `:not_negative` is set.
  Also see `subtract/2` and `subtract/3`.

      iex> ~D[2016-06-03] |> GoodTimes.add(-1, :day)
      ~D[2016-06-02]
      iex> ~D[2016-06-03] |> GoodTimes.add(-1, :day, not_negative: true)
      ArgumentError

  Time can have sub-second units. We only assume precision for significant digits,
  unless you set the option `precise: true`.

      iex> ~T[12:30:00] |> GoodTimes.add(5, :milliseconds)
      ~T[12:30:00.005]
      iex> ~T[12:30:00] |> GoodTimes.add(500, :milliseconds)
      ~T[12:30:00.5]
      iex> ~T[12:30:00] |> GoodTimes.add(500_000, :microseconds, precise: true)
      ~T[12:30:00.500000]

  You can add different units, and mix positive and negative units of time.

      iex> ~D[2016-06-03] |> GoodTimes.add(day: 1, year: 2)
      ~D[2018-06-04]
      iex> ~T[12:30:00] |> GoodTimes.add(hours: 4, minute: -1)
      ~T[16:29:00]
      iex> ~N[2016-06-03 12:30:00] |> GoodTimes.add(months: 2, hours: 15)
      ~N[2016-08-04 03:30:00]
      iex> ~D[2016-06-03] |> GoodTimes.add(day: -1, year: 2)
      ArgumentError

  Date and Time will only add units relevant to them.

      iex> ~D[2016-06-03] |> GoodTimes.add(1, :second)
      ArgumentError
      iex> ~T[12:30:00] |> GoodTimes.add(1, :day)
      ArgumentError

  We can also add to dates, times and datetimes in Erlang tuple format. If so,
  the function will return in the same format.

      iex> {2016, 6, 3} |> GoodTimes.add(1, :day)
      {2016, 6, 4}
      iex> {12, 30, 0} |> GoodTimes.add(15, :seconds)
      {12, 30, 15}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> GoodTimes.add(12, :hours)
      {{2016, 6, 4}, {0, 30, 0}}

      iex> {2016, 6, 3} |> GoodTimes.add(-1, :day)
      {2016, 6, 2}

      iex> {2016, 6, 3} |> GoodTimes.add(day: 1, year: 2)
      {2018, 6, 4}
      iex> {12, 30, 0} |> GoodTimes.add(hours: 4, minute: -1)
      {16, 29, 0}
      iex> {{2016, 6, 3}, {12, 30, 0}} |> GoodTimes.add(months: 2, hours: 15)
      {{2016, 8, 4}, {3, 30, 0}}

  Sub-second units are not supported for Erlang time tuples.

      iex> {2016, 6, 3} |> GoodTimes.add(1, :second)
      ArgumentError
      iex> {12, 30, 0} |> GoodTimes.add(1, :day)
      ArgumentError
      iex> {12, 30, 0} |> GoodTimes.add(1, :millisecond)
      ArgumentError
  """
  @spec add(moment, integer, unit) :: moment
  @spec add(moment, integer, unit, Keyword.t) :: moment
  def add(moment, n, unit, opts \\ [])
  def add(moment, n, unit, opts) do
    if opts[:not_negative] && n < 0 do
      raise ArgumentError, "Negative unit of time when :not_negative specified"
    else
      case {moment, unit} do
        {%Time{}, _} when unit in @all_time_units ->
          add_time(moment, n, unit, opts)
        {{h, m, s}, unit} when unit in @time_units and h in 0..23 and m in 0..59 and s in 0..60 ->
          add_time(moment, n, unit, opts)
        {{_,_,_}, unit} when unit in @subsecond_units ->
          raise ArgumentError, "Cannot add #{unit} to Erlang time tuples"
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
          raise ArgumentError, "Sub-second units are not supported for Erlang datetime tuples"
        {{{_,_,_}, {_,_,_}}, _} ->
          add_datetime(moment, n, unit, opts)
      end
    end
  end

  defp add_time(%Time{} = time, n, unit, opts) when unit in [:microsecond, :microseconds] do
    {us, _precision} = time.microsecond
    total_us = us + n
    seconds = div(total_us, 1_000_000)
    new_us = rem(total_us, 1_000_000)
    new_time = add_time(time, seconds, :seconds, opts)

    %{new_time | microsecond: {new_us, opts[:precision] || 6 - trailing_zeroes(n)}}
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


  defp trailing_zeroes(n) do
    Enum.find(6..0, fn exp -> trunc(n / :math.pow(10, exp)) * :math.pow(10, exp) == n end)
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
    new_date(date, n)
  defp add_date({_,_,_} = date, n, unit, opts) when unit in [:year, :years], do:
    add_date(date, n * 12, :months, opts)

  defp new_date(date, months) do
    date
    |> new_year_and_month(months)
    |> adjust_for_new_year
    |> adjust_for_last_day_of_month
  end

  defp new_year_and_month({year, month, day}, months) do
    {year + div(months, 12), month + rem(months, 12), day}
  end

  defp adjust_for_new_year({year, month, day}) when month < 1, do: {year - 1, month + 12, day}
  defp adjust_for_new_year({year, month, day}) when month > 12, do: {year + 1, month - 12, day}
  defp adjust_for_new_year(date), do: date

  defp adjust_for_last_day_of_month({year, month, day}) do
    {year, month, Enum.min([day, :calendar.last_day_of_the_month(year, month)])}
  end

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

  # def add(%Date{} = date, n, unit, opts) when unit in [:month, :months], do: ...
  # def add(%Date{} = date, n, unit, opts) when unit in [:year, :years], do: ...

  @spec add(moment, Keyword.t) :: moment
  def add(_moment, _units_and_options) do
  end

  @spec subtract(moment, integer, unit) :: moment
  @spec subtract(moment, integer, unit, Keyword.t) :: moment
  def subtract(_moment, _n, _unit, _opts \\ []) do
  end

  @spec subtract(moment, Keyword.t) :: moment
  def subtract(_moment, _units_and_options) do
  end

  @spec now() :: NaiveDateTime.t
  @spec now(format) :: datetime
  def now(_format \\ :elixir) do
  end

  # GoodTimes.Date is deprecated, functions are moved to main module
  @spec today(format) :: date
  def today(_format \\ :elixir) do
  end

  @spec tomorrow(format) :: date
  def tomorrow(_format \\ :elixir) do
  end

  @spec yesterday(format) :: date
  def yesterday(_format \\ :elixir) do
  end

  @spec at(date, time) :: datetime
  @spec at(datetime, time) :: datetime
  def at(_moment, _time) do
  end


  #############
  # DEPRECATED API, PRE-2.0

  @doc """
  Returns the UTC date and time the specified seconds after the given datetime.

  ## Examples

      iex> 15 |> seconds_after({{2015, 2, 27}, {18, 30, 45}})
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

      iex> 15 |> seconds_before({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 27}, {18, 30, 30}}
  """
  @spec seconds_before(integer, datetime) :: datetime
  def seconds_before(seconds, datetime), do: seconds_after(-seconds, datetime)

  @doc """
  Returns the UTC date and time a second after the given datetime.

  ## Examples

      iex> a_second_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 27}, {18, 30, 46}}
  """
  @spec a_second_after(datetime) :: datetime
  def a_second_after(datetime), do: seconds_after(1, datetime)

  @doc """
  Returns the UTC date and time a second before the given datetime.

  ## Examples

      iex> a_second_before({{2015, 2, 27}, {18, 30, 45}})
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

      iex> a_second_ago
      {{2015, 2, 27}, {18, 30, 44}}
  """
  @spec a_second_ago :: datetime
  def a_second_ago, do: seconds_ago(1)

  @doc """
  Returns the UTC date and time the specified minutes after the given datetime.

  ## Examples

      iex> 15 |> minutes_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 27}, {18, 45, 45}}
  """
  @spec minutes_after(integer, datetime) :: datetime
  def minutes_after(minutes, datetime), do: seconds_after(minutes * @seconds_per_minute, datetime)

  @doc """
  Returns the UTC date and time the specified minutes before the given datetime.

  ## Examples

      iex> 15 |> minutes_before({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 27}, {18, 15, 45}}
  """
  @spec minutes_before(integer, datetime) :: datetime
  def minutes_before(minutes, datetime), do: seconds_before(minutes * @seconds_per_minute, datetime)

  @doc """
  Returns the UTC date and time a minute after the given datetime.

  ## Examples

      iex> a_minute_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 27}, {18, 31, 45}}
  """
  @spec a_minute_after(datetime) :: datetime
  def a_minute_after(datetime), do: minutes_after(1, datetime)

  @doc """
  Returns the UTC date and time a minute before the given datetime.

  ## Examples

      iex> a_minute_before({{2015, 2, 27}, {18, 30, 45}})
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

      iex> 15 |> hours_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 28}, {9, 30, 45}}
  """
  @spec hours_after(integer, datetime) :: datetime
  def hours_after(hours, datetime), do: seconds_after(hours * @seconds_per_hour, datetime)

  @doc """
  Returns the UTC date and time the specified hours before the given datetime.

  ## Examples

      iex> 15 |> hours_before({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 27}, {3, 30, 45}}
  """
  @spec hours_before(integer, datetime) :: datetime
  def hours_before(hours, datetime), do: seconds_before(hours * @seconds_per_hour, datetime)

  @doc """
  Returns the UTC date and time an hour after the given datetime.

  ## Examples

      iex> an_hour_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 27}, {19, 30, 45}}
  """
  @spec an_hour_after(datetime) :: datetime
  def an_hour_after(datetime), do: hours_after(1, datetime)

  @doc """
  Returns the UTC date and time an hour before the given datetime.

  ## Examples

      iex> an_hour_before({{2015, 2, 27}, {18, 30, 45}})
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

      iex> 3 |> days_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 3, 2}, {18, 30, 45}}
  """
  @spec days_after(integer, datetime) :: datetime
  def days_after(days, datetime), do: seconds_after(days * @seconds_per_day, datetime)

  @doc """
  Returns the UTC date and time the specified days before the given datetime.

  ## Examples

      iex> 3 |> days_before({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 24}, {18, 30, 45}}
  """
  @spec days_before(integer, datetime) :: datetime
  def days_before(days, datetime), do: seconds_before(days * @seconds_per_day, datetime)

  @doc """
  Returns the UTC date and time a day after the given datetime.

  ## Examples

      iex> a_day_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 28}, {18, 30, 45}}
  """
  @spec a_day_after(datetime) :: datetime
  def a_day_after(datetime), do: days_after(1, datetime)

  @doc """
  Returns the UTC date and time a day before the given datetime.

  ## Examples

      iex> a_day_before({{2015, 2, 27}, {18, 30, 45}})
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

      iex> 3 |> weeks_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 3, 20}, {18, 30, 45}}
  """
  @spec weeks_after(integer, datetime) :: datetime
  def weeks_after(weeks, datetime), do: seconds_after(weeks * @seconds_per_week, datetime)

  @doc """
  Returns the UTC date and time the specified weeks before the given datetime.

  ## Examples

      iex> 3 |> weeks_before({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 2, 6}, {18, 30, 45}}
  """
  @spec weeks_before(integer, datetime) :: datetime
  def weeks_before(weeks, datetime), do: seconds_before(weeks * @seconds_per_week, datetime)

  @doc """
  Returns the UTC date and time a week after the given datetime.

  ## Examples

      iex> a_week_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 3, 6}, {18, 30, 45}}
  """
  @spec a_week_after(datetime) :: datetime
  def a_week_after(datetime), do: weeks_after(1, datetime)

  @doc """
  Returns the UTC date and time a week before the given datetime.

  ## Examples

      iex> a_week_before({{2015, 2, 27}, {18, 30, 45}})
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

      iex> 3 |> months_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 5, 27}, {18, 30, 45}}
  """
  @spec months_after(integer, datetime) :: datetime
  def months_after(months, {date, time}), do: {new_date(date, months), time}

  @doc """
  Returns the UTC date and time the specified months before the given datetime.

  ## Examples

      iex> 3 |> months_before({{2015, 2, 27}, {18, 30, 45}})
      {{2014, 11, 27}, {18, 30, 45}}
  """
  @spec months_before(integer, datetime) :: datetime
  def months_before(months, datetime), do: months_after(-months, datetime)

  @doc """
  Returns the UTC date and time a month after the given datetime.

  ## Examples

      iex> a_month_after({{2015, 2, 27}, {18, 30, 45}})
      {{2015, 3, 27}, {18, 30, 45}}
  """
  @spec a_month_after(datetime) :: datetime
  def a_month_after(datetime), do: months_after(1, datetime)

  @doc """
  Returns the UTC date and time a month before the given datetime.

  ## Examples

      iex> a_month_before({{2015, 2, 27}, {18, 30, 45}})
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

      iex> 3 |> years_after({{2015, 2, 27}, {18, 30, 45}})
      {{2018, 2, 27}, {18, 30, 45}}
  """
  @spec years_after(integer, datetime) :: datetime
  def years_after(years, datetime), do: months_after(years * @months_per_year, datetime)

  @doc """
  Returns the UTC date and time the specified years before the given datetime.

  ## Examples

      iex> 3 |> years_before({{2015, 2, 27}, {18, 30, 45}})
      {{2012, 2, 27}, {18, 30, 45}}
  """
  @spec years_before(integer, datetime) :: datetime
  def years_before(years, datetime), do: months_before(years * @months_per_year, datetime)

  @doc """
  Returns the UTC date and time a year after the given datetime.

  ## Examples

      iex> a_year_after({{2015, 2, 27}, {18, 30, 45}})
      {{2016, 2, 27}, {18, 30, 45}}
  """
  @spec a_year_after(datetime) :: datetime
  def a_year_after(datetime), do: years_after(1, datetime)

  @doc """
  Returns the UTC date and time a year before the given datetime.

  ## Examples

      iex> a_year_before({{2015, 2, 27}, {18, 30, 45}})
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
