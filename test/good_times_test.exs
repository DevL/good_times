defmodule GoodTimesTest do
  use ExUnit.Case
  import GoodTimes

  test "now" do
    assert now == :calendar.universal_time
  end

  @a_datetime {{2015, 2, 27}, {18, 30, 45}}
  test "seconds_after" do
    assert_difference @a_datetime, seconds_after(10, @a_datetime), {0, {0, 0, 10}}
  end

  test "seconds_before" do
    assert_difference @a_datetime, seconds_before(10, @a_datetime), {-1, {23, 59, 50}}
  end

  test "a_second_after" do
    assert_difference @a_datetime, a_second_after(@a_datetime), {0, {0, 0, 1}}
  end

  test "a_second_before" do
    assert_difference @a_datetime, a_second_before(@a_datetime), {-1, {23, 59, 59}}
  end

  test "seconds_from_now" do
    assert_difference seconds_from_now(10), {0, {0, 0, 10}}
  end

  test "seconds_ago" do
    assert_difference seconds_ago(15), {-1, {23, 59, 45}}
  end

  test "a_second_from_now" do
    assert_difference a_second_from_now, {0, {0, 0, 1}}
  end

  test "a_second_ago" do
    assert_difference a_second_ago, {-1, {23, 59, 59}}
  end

  test "minutes_after" do
    assert_difference @a_datetime, minutes_after(10, @a_datetime), {0, {0, 10, 0}}
  end

  test "minutes_before" do
    assert_difference @a_datetime, minutes_before(10, @a_datetime), {-1, {23, 50, 0}}
  end

  test "a_minute_after" do
    assert_difference @a_datetime, a_minute_after(@a_datetime), {0, {0, 1, 0}}
  end

  test "a_minute_before" do
    assert_difference @a_datetime, a_minute_before(@a_datetime), {-1, {23, 59, 0}}
  end

  test "minutes_from_now" do
    assert_difference minutes_from_now(5), {0, {0, 5, 0}}
  end

  test "minutes_ago" do
    assert_difference minutes_ago(20), {-1, {23, 40, 0}}
  end

  test "a_minute_from_now" do
    assert_difference a_minute_from_now, {0, {0, 1, 0}}
  end

  test "a_minute_ago" do
    assert_difference a_minute_ago, {-1, {23, 59, 0}}
  end

  test "hours_after" do
    assert_difference @a_datetime, hours_after(10, @a_datetime), {0, {10, 0, 0}}
  end

  test "hours_before" do
    assert_difference @a_datetime, hours_before(10, @a_datetime), {-1, {14, 0, 0}}
  end

  test "an_hour_after" do
    assert_difference @a_datetime, an_hour_after(@a_datetime), {0, {1, 0, 0}}
  end

  test "an_hour_before" do
    assert_difference @a_datetime, an_hour_before(@a_datetime), {-1, {23, 0, 0}}
  end

  test "hours_from_now" do
    assert_difference hours_from_now(2), {0, {2, 0, 0}}
  end

  test "hours_ago" do
    assert_difference hours_ago(4), {-1, {20, 0, 0}}
  end

  test "an_hour_from_now" do
    assert_difference an_hour_from_now, {0, {1, 0, 0}}
  end

  test "an_hour_ago" do
    assert_difference an_hour_ago, {-1, {23, 0, 0}}
  end

  test "days_after" do
    assert_difference @a_datetime, days_after(3, @a_datetime), {3, {0, 0, 0}}
  end

  test "days_before" do
    assert_difference @a_datetime, days_before(3, @a_datetime), {-3, {0, 0, 0}}
  end

  test "a_day_after" do
    assert_difference @a_datetime, a_day_after(@a_datetime), {1, {0, 0, 0}}
  end

  test "a_day_before" do
    assert_difference @a_datetime, a_day_before(@a_datetime), {-1, {0, 0, 0}}
  end

  test "days_from_now" do
    assert_difference days_from_now(3), {3, {0, 0, 0}}
  end

  test "days_ago" do
    assert_difference days_ago(7), {-7, {0, 0, 0}}
  end

  test "a_day_from_now" do
    assert_difference a_day_from_now, {1, {0, 0, 0}}
  end

  test "a_day_ago" do
    assert_difference a_day_ago, {-1, {0, 0, 0}}
  end

  test "weeks_after" do
    assert_difference @a_datetime, weeks_after(4, @a_datetime), {28, {0, 0, 0}}
  end

  test "weeks_before" do
    assert_difference @a_datetime, weeks_before(4, @a_datetime), {-28, {0, 0, 0}}
  end

  test "a_week_after" do
    assert_difference @a_datetime, a_week_after(@a_datetime), {7, {0, 0, 0}}
  end

  test "a_week_before" do
    assert_difference @a_datetime, a_week_before(@a_datetime), {-7, {0, 0, 0}}
  end

  test "weeks_from_now" do
    assert_difference weeks_from_now(4), {28, {0, 0, 0}}
  end

  test "weeks_ago" do
    assert_difference weeks_ago(4), {-28, {0, 0, 0}}
  end

  test "a_week_from_now" do
    assert_difference a_week_from_now, {7, {0, 0, 0}}
  end

  test "a_week_ago" do
    assert_difference a_week_ago, {-7, {0, 0, 0}}
  end

  @last_jan_2015 {{2015, 1, 31}, {12, 0, 0}}
  test "months_after" do
    assert months_after(1, @a_datetime) == {{2015, 3, 27}, {18, 30, 45}}
    assert months_after(1, @last_jan_2015) == {{2015, 2, 28}, {12, 0, 0}}
    assert months_after(12, @last_jan_2015) == {{2016, 1, 31}, {12, 0, 0}}
    assert months_after(13, @last_jan_2015) == {{2016, 2, 29}, {12, 0, 0}}
  end

  test "months_before" do
    assert months_before(1, @a_datetime) == {{2015, 1, 27}, {18, 30, 45}}
    assert months_before(1, @last_jan_2015) == {{2014, 12, 31}, {12, 0, 0}}
    assert months_before(12, @last_jan_2015) == {{2014, 1, 31}, {12, 0, 0}}
    assert months_before(11, @last_jan_2015) == {{2014, 2, 28}, {12, 0, 0}}
  end

  test "a_month_after" do
    assert_difference @a_datetime, a_month_after(@a_datetime), {28, {0, 0, 0}}
  end

  test "a_month_before" do
    assert_difference @a_datetime, a_month_before(@a_datetime), {-31, {0, 0, 0}}
  end

  defp difference(t1, t2) do
    :calendar.time_difference t1, t2
  end

  defp assert_difference(datetime, expected) do
    assert_difference now, datetime, expected
  end

  defp assert_difference(datetime1 , datetime2, expected) do
    actual = difference datetime1, datetime2
    assert actual == expected
  end
end
