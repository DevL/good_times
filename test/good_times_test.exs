defmodule GoodTimesTest do
  use ExUnit.Case
  import GoodTimes

  test "now" do
    assert now == :calendar.universal_time
  end

  @a_datetime {{2015, 2, 27}, {18, 30, 45}}
  test "seconds_after" do
    expected = {0, {0, 0, 10}}
    actual = difference @a_datetime, seconds_after(10, @a_datetime)

    assert actual == expected
  end

  test "seconds_before" do
    expected = {-1, {23, 59, 50}}
    actual = difference @a_datetime, seconds_before(10, @a_datetime)

    assert actual == expected
  end

  test "a_second_after" do
    expected = {0, {0, 0, 1}}
    actual = difference @a_datetime, a_second_after(@a_datetime)

    assert actual == expected
  end

  test "a_second_before" do
    expected = {-1, {23, 59, 59}}
    actual = difference @a_datetime, a_second_before(@a_datetime)

    assert actual == expected
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

  test "a_second_from_now" do
    expected = {0, {0, 0, 1}}
    actual = difference now, a_second_from_now

    assert actual == expected
  end

  test "a_second_ago" do
    expected = {-1, {23, 59, 59}}
    actual = difference now, a_second_ago

    assert actual == expected
  end

  test "minutes_after" do
    expected = {0, {0, 10, 0}}
    actual = difference @a_datetime, minutes_after(10, @a_datetime)

    assert actual == expected
  end

  test "minutes_before" do
    expected = {-1, {23, 50, 0}}
    actual = difference @a_datetime, minutes_before(10, @a_datetime)

    assert actual == expected
  end

  test "a_minute_after" do
    expected = {0, {0, 1, 0}}
    actual = difference @a_datetime, a_minute_after(@a_datetime)

    assert actual == expected
  end

  test "a_minute_before" do
    expected = {-1, {23, 59, 0}}
    actual = difference @a_datetime, a_minute_before(@a_datetime)

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

  test "a_minute_from_now" do
    expected = {0, {0, 1, 0}}
    actual = difference now, a_minute_from_now

    assert actual == expected
  end

  test "a_minute_ago" do
    expected = {-1, {23, 59, 0}}
    actual = difference now, a_minute_ago

    assert actual == expected
  end

  test "hours_after" do
    expected = {0, {10, 0, 0}}
    actual = difference @a_datetime, hours_after(10, @a_datetime)

    assert actual == expected
  end

  test "hours_before" do
    expected = {-1, {14, 0, 0}}
    actual = difference @a_datetime, hours_before(10, @a_datetime)

    assert actual == expected
  end

  test "an_hour_after" do
    expected = {0, {1, 0, 0}}
    actual = difference @a_datetime, an_hour_after(@a_datetime)

    assert actual == expected
  end

  test "an_hour_before" do
    expected = {-1, {23, 0, 0}}
    actual = difference @a_datetime, an_hour_before(@a_datetime)

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

  test "an_hour_from_now" do
    expected = {0, {1, 0, 0}}
    actual = difference now, an_hour_from_now

    assert actual == expected
  end

  test "an_hour_ago" do
    expected = {-1, {23, 0, 0}}
    actual = difference now, an_hour_ago

    assert actual == expected
  end

  test "days_after" do
    expected = {3, {0, 0, 0}}
    actual = difference @a_datetime, days_after(3, @a_datetime)

    assert actual == expected
  end

  test "days_before" do
    expected = {-3, {0, 0, 0}}
    actual = difference @a_datetime, days_before(3, @a_datetime)

    assert actual == expected
  end

  test "a_day_after" do
    expected = {1, {0, 0, 0}}
    actual = difference @a_datetime, a_day_after(@a_datetime)

    assert actual == expected
  end

  test "a_day_before" do
    expected = {-1, {0, 0, 0}}
    actual = difference @a_datetime, a_day_before(@a_datetime)

    assert actual == expected
  end

  test "days_from_now" do
    expected = {3, {0, 0, 0}}
    actual = difference now, days_from_now(3)

    assert actual == expected
  end

  test "days_ago" do
    expected = {-7, {0, 0, 0}}
    actual = difference now, days_ago(7)

    assert actual == expected
  end

  test "a_day_from_now" do
    expected = {1, {0, 0, 0}}
    actual = difference now, a_day_from_now

    assert actual == expected
  end

  test "a_day_ago" do
    expected = {-1, {0, 0, 0}}
    actual = difference now, a_day_ago

    assert actual == expected
  end

  defp difference(t1, t2) do
    :calendar.time_difference t1, t2
  end
end
