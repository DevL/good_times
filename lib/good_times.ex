defmodule GoodTimes do
  @seconds_per_minute 60

  def now, do: :calendar.universal_time

  def seconds_from_now(seconds) do
    now
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(seconds)
    |> :calendar.gregorian_seconds_to_datetime
  end

  def seconds_ago(seconds), do: seconds_from_now(-seconds)

  def minutes_from_now(minutes) do
    seconds_from_now(minutes * @seconds_per_minute)
  end

  def minutes_ago(minutes), do: seconds_ago(minutes * @seconds_per_minute)
end
