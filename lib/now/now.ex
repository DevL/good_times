defmodule GoodTimes.Now do
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
end
