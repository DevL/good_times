defmodule GoodTimes do
  def now, do: :calendar.universal_time

  def seconds_from_now(seconds) do
    now
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.+(seconds)
    |> :calendar.gregorian_seconds_to_datetime
  end

  def seconds_ago(seconds), do: seconds_from_now(-seconds)
end
