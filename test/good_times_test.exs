defmodule GoodTimesTest do
  use ExUnit.Case
  import GoodTimes

  test "now" do
    assert now == :calendar.universal_time
  end

  test "seconds_from_now" do
    expected = {0, {0, 0, 10}}
    difference = :calendar.time_difference now, seconds_from_now(10)

    assert difference == expected
  end

  test "seconds_ago" do
    expected = {-1, {23, 59, 45}}
    difference = :calendar.time_difference now, seconds_ago(15)

    assert difference == expected
  end
end
