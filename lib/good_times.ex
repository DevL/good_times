defmodule GoodTimes do
  @moduledoc """
  Convenience time functions.

  Unless explicitly stated, all functions operate on and return an
  Erlang datetime based on the Coordinated Universal Time (UTC).
  """

  @seconds_per_minute 60
  @seconds_per_hour 60*60
  @seconds_per_day 24*60*60

  @type year  :: non_neg_integer
  @type month :: 1..12
  @type day   :: 1..31
  @type hour   :: 0..23
  @type minute :: 0..59
  @type second :: 0..59
  @type datetime :: {{year, month, day}, {hour, minute, second}}

  @doc """
  Returns the current UTC time as a datetime.

  ## Examples

      iex> now
      {{2015, 2, 27}, {18, 30, 45}}
  """
  @spec now :: datetime
  def now, do: :calendar.universal_time

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
end
