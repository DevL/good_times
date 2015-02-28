defmodule GoodTimes do
  @seconds_per_minute 60
  @seconds_per_hour 3600
  @seconds_per_day 86400

  @type year  :: integer
  @type month :: pos_integer
  @type day   :: pos_integer
  @type hour   :: non_neg_integer
  @type minute :: non_neg_integer
  @type second :: non_neg_integer
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
  Returns the UTC date and time the specified seconds from now.

  ## Examples

      iex> 15 |> seconds_from_now
      {{2015, 2, 27}, {18, 31, 0}}
  """
  @spec seconds_from_now(integer) :: datetime
  def seconds_from_now(seconds) do
    now
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(seconds)
    |> :calendar.gregorian_seconds_to_datetime
  end

  @doc """
  Returns the UTC date and time a second from now.

   ## Examples

      iex> a_second_from_now
      {{2015, 2, 27}, {18, 30, 46}}
  """
  @spec a_second_from_now :: datetime
  def a_second_from_now, do: seconds_from_now(1)

  @doc """
  Returns the UTC date and time the specified seconds ago.

  ## Examples

      iex> 20 |> seconds_ago
      {{2015, 2, 27}, {18, 30, 25}}
  """
  @spec seconds_ago(integer) :: datetime
  def seconds_ago(seconds), do: seconds_from_now(-seconds)

  @doc """
  Returns the UTC date and time a second ago.

  `a_second_ago # => {{2015, 2, 27}, {18, 30, 44}}`
  """
  @spec a_second_ago :: datetime
  def a_second_ago, do: seconds_ago(1)

  @doc """
  Returns the UTC date and time the specified minutes from now.

  ## Examples

      iex> 10 |> minutes_from_now
      {{2015, 2, 27}, {18, 40, 45}}
  """
  @spec minutes_from_now(integer) :: datetime
  def minutes_from_now(minutes), do: seconds_from_now(minutes * @seconds_per_minute)

  @doc """
  Returns the UTC date and time a minute from now.

   ## Examples

      iex> a_minute_from_now
      {{2015, 2, 27}, {18, 31, 45}}
  """
  @spec a_minute_from_now :: datetime
  def a_minute_from_now, do: minutes_from_now(1)

  @doc """
  Returns the UTC date and time the specified minutes ago.

  ## Examples

      iex> 5 |> minutes_ago
      {{2015, 2, 27}, {18, 25, 45}}
  """
  @spec minutes_ago(integer) :: datetime
  def minutes_ago(minutes), do: seconds_ago(minutes * @seconds_per_minute)

  @doc """
  Returns the UTC date and time a minute ago.

   ## Examples

      iex> a_minute_ago
      {{2015, 2, 27}, {18, 29, 45}}
  """
  @spec a_minute_ago :: datetime
  def a_minute_ago, do: minutes_ago(1)

  @doc """
  Returns the UTC date and time the specified hours from now.

  ## Examples

      iex> 6 |> hours_from_now
      {{2015, 2, 28}, {0, 30, 45}}
  """
  @spec hours_from_now(integer) :: datetime
  def hours_from_now(hours), do: seconds_from_now(hours * @seconds_per_hour)

  @doc """
  Returns the UTC date and time the specified hours ago.

  ## Examples

      iex> 2 |> hours_ago
      {{2015, 2, 27}, {16, 30, 45}}
  """
  @spec hours_ago(integer) :: datetime
  def hours_ago(hours), do: seconds_ago(hours * @seconds_per_hour)

  @doc """
  Returns the UTC date and time the specified days from now.

  ## Examples

      iex> 2 |> days_from_now
      {{2015, 3, 1}, {18, 30, 45}}
  """
  @spec days_from_now(integer) :: datetime
  def days_from_now(days), do: seconds_from_now(days * @seconds_per_day)

  @doc """
  Returns the UTC date and time the specified days ago.

  ## Examples

      iex> 7 |> days_ago
      {{2015, 2, 20}, {18, 30, 45}}
  """
  @spec days_ago(integer) :: datetime
  def days_ago(days), do: seconds_ago(days * @seconds_per_day)
end
