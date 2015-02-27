defmodule GoodTimes do
  @seconds_per_minute 60
  @seconds_per_hour 3600
  @seconds_per_day 86400

  def now, do: :calendar.universal_time

  def seconds_from_now(seconds) do
    now
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(seconds)
    |> :calendar.gregorian_seconds_to_datetime
  end

  def seconds_ago(seconds), do: seconds_from_now(-seconds)

  def minutes_from_now(minutes), do: seconds_from_now(minutes * @seconds_per_minute)

  def minutes_ago(minutes), do: seconds_ago(minutes * @seconds_per_minute)

  def hours_from_now(hours), do: seconds_from_now(hours * @seconds_per_hour)

  def hours_ago(hours), do: seconds_ago(hours * @seconds_per_hour)

  def days_from_now(days), do: seconds_from_now(days * @seconds_per_day)

  def days_ago(days), do: seconds_ago(days * @seconds_per_day)
end
