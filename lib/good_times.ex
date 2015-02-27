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

  `now # => {{2015, 2, 27}, {18, 30, 45}}`
  """
  @spec now :: datetime
  def now, do: :calendar.universal_time

  @doc """
  Returns the UTC date and time the specified seconds from now.

  `15 |> seconds_from_now # => {{2015, 2, 27}, {18, 31, 0}}`
  """
  @spec seconds_from_now(integer) :: datetime
  def seconds_from_now(seconds) do
    now
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(seconds)
    |> :calendar.gregorian_seconds_to_datetime
  end

  @doc """
  Returns the UTC date and time the specified seconds ago.

  `20 |> seconds_ago # => {{2015, 2, 27}, {18, 30, 25}}`
  """
  @spec seconds_ago(integer) :: datetime
  def seconds_ago(seconds), do: seconds_from_now(-seconds)

  @doc """
  Returns the UTC date and time the specified minutes from now.

  `10 |> minutes_from_now # => {{2015, 2, 27}, {18, 40, 45}}`
  """
  @spec minutes_from_now(integer) :: datetime
  def minutes_from_now(minutes), do: seconds_from_now(minutes * @seconds_per_minute)

  @doc """
  Returns the UTC date and time the specified minutes ago.

  `5 |> minutes_ago # => {{2015, 2, 27}, {18, 25, 45}}`
  """
  @spec minutes_ago(integer) :: datetime
  def minutes_ago(minutes), do: seconds_ago(minutes * @seconds_per_minute)

  @doc """
  Returns the UTC date and time the specified hours from now.

  `6 |> hours_from_now # => {{2015, 2, 28}, {0, 30, 45}}`
  """
  @spec hours_from_now(integer) :: datetime
  def hours_from_now(hours), do: seconds_from_now(hours * @seconds_per_hour)

  @doc """
  Returns the UTC date and time the specified hours ago.

  `2 |> hours_ago # => {{2015, 2, 27}, {16, 30, 45}}`
  """
  @spec hours_ago(integer) :: datetime
  def hours_ago(hours), do: seconds_ago(hours * @seconds_per_hour)

  @doc """
  Returns the UTC date and time the specified days from now.

  `2 |> days_from_now # => {{2015, 3, 1}, {18, 30, 45}}`
  """
  @spec days_from_now(integer) :: datetime
  def days_from_now(days), do: seconds_from_now(days * @seconds_per_day)

  @doc """
  Returns the UTC date and time the specified days ago.

  `7 |> days_ago # => {{2015, 2, 20}, {18, 30, 45}}`
  """
  @spec days_ago(integer) :: datetime
  def days_ago(days), do: seconds_ago(days * @seconds_per_day)
end
