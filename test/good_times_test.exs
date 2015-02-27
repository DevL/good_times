defmodule GoodTimesTest do
  use ExUnit.Case
  import GoodTimes

  test "now" do
    assert now == :calendar.universal_time
  end

  test "seconds_from_now" do
    expected = {0, {0, 0, 10}}
    actual = difference now, seconds_from_now(10)

    assert actual == expected
  end

  test "seconds_ago" do
    expected = {-1, {23, 59, 45}}
    actual = difference now, seconds_ago(15)

    assert actual == expected
  end

  test "minutes_from_now" do
    expected = {0, {0, 5, 0}}
    actual = difference now, minutes_from_now(5)

    assert actual == expected
  end

  test "minutes_ago" do
    expected = {-1, {23, 40, 0}}
    actual = difference now, minutes_ago(20)

    assert actual == expected
  end

  test "hours_from_now" do
    expected = {0, {2, 0, 0}}
    actual = difference now, hours_from_now(2)

    assert actual == expected
  end

  test "hours_ago" do
    expected = {-1, {20, 0, 0}}
    actual = difference now, hours_ago(4)

    assert actual == expected
  end

  defp difference(t1, t2) do
    :calendar.time_difference t1, t2
  end
end
