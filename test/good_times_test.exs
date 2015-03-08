defmodule GoodTimesTest do
  use ExUnit.Case
  import GoodTimes

  test "now" do
    assert now == :calendar.universal_time
  end

  @a_datetime {{2015, 2, 27}, {18, 30, 45}}
  test "seconds_after" do
    assert seconds_after(10, @a_datetime) == {{2015, 2, 27}, {18, 30, 55}}
  end

  test "seconds_before" do
    assert seconds_before(10, @a_datetime) == {{2015, 2, 27}, {18, 30, 35}}
  end

  test "a_second_after" do
    assert a_second_after(@a_datetime) == {{2015, 2, 27}, {18, 30, 46}}
  end

  test "a_second_before" do
    assert a_second_before(@a_datetime) == {{2015, 2, 27}, {18, 30, 44}}
  end

  test "seconds_from_now" do
    assert seconds_from_now(10) == seconds_after(10, now)
  end

  test "seconds_ago" do
    assert seconds_ago(15) == seconds_before(15, now)
  end

  test "a_second_from_now" do
    assert a_second_from_now == a_second_after now
  end

  test "a_second_ago" do
    assert a_second_ago == a_second_before now
  end

  test "minutes_after" do
    assert minutes_after(10, @a_datetime) == {{2015, 2, 27}, {18, 40, 45}}
  end

  test "minutes_before" do
    assert minutes_before(10, @a_datetime) == {{2015, 2, 27}, {18, 20, 45}}
  end

  test "a_minute_after" do
    assert a_minute_after(@a_datetime) == {{2015, 2, 27}, {18, 31, 45}}
  end

  test "a_minute_before" do
    assert a_minute_before(@a_datetime) == {{2015, 2, 27}, {18, 29, 45}}
  end

  test "minutes_from_now" do
    assert minutes_from_now(5) == minutes_after(5, now)
  end

  test "minutes_ago" do
    assert minutes_ago(20) == minutes_before(20, now)
  end

  test "a_minute_from_now" do
    assert a_minute_from_now == a_minute_after now
  end

  test "a_minute_ago" do
    assert a_minute_ago == a_minute_before now
  end

  test "hours_after" do
    assert hours_after(10, @a_datetime) == {{2015, 2, 28}, {4, 30, 45}}
  end

  test "hours_before" do
    assert hours_before(10, @a_datetime) == {{2015, 2, 27}, {8, 30, 45}}
  end

  test "an_hour_after" do
    assert an_hour_after(@a_datetime) == {{2015, 2, 27}, {19, 30, 45}}
  end

  test "an_hour_before" do
    assert an_hour_before(@a_datetime) == {{2015, 2, 27}, {17, 30, 45}}
  end

  test "hours_from_now" do
    assert hours_from_now(2) == hours_after(2, now)
  end

  test "hours_ago" do
    assert hours_ago(4) == hours_before(4, now)
  end

  test "an_hour_from_now" do
    assert an_hour_from_now == an_hour_after now
  end

  test "an_hour_ago" do
    assert an_hour_ago == an_hour_before now
  end

  test "days_after" do
    assert days_after(3, @a_datetime) == {{2015, 3, 2}, {18, 30, 45}}
  end

  test "days_before" do
    assert days_before(3, @a_datetime) == {{2015, 2, 24}, {18, 30, 45}}
  end

  test "a_day_after" do
    assert a_day_after(@a_datetime) == {{2015, 2, 28}, {18, 30, 45}}
  end

  test "a_day_before" do
    assert a_day_before(@a_datetime) == {{2015, 2, 26}, {18, 30, 45}}
  end

  test "days_from_now" do
    assert days_from_now(3) == days_after(3, now)
  end

  test "days_ago" do
    assert days_ago(7) == days_before(7, now)
  end

  test "a_day_from_now" do
    assert a_day_from_now == a_day_after now
  end

  test "a_day_ago" do
    assert a_day_ago == a_day_before now
  end

  test "weeks_after" do
    assert weeks_after(4, @a_datetime) == {{2015, 3, 27}, {18, 30, 45}}
  end

  test "weeks_before" do
    assert weeks_before(4, @a_datetime) == {{2015, 1, 30}, {18, 30, 45}}
  end

  test "a_week_after" do
    assert a_week_after(@a_datetime) == {{2015, 3, 6}, {18, 30, 45}}
  end

  test "a_week_before" do
    assert a_week_before(@a_datetime) == {{2015, 2, 20}, {18, 30, 45}}
  end

  test "weeks_from_now" do
    assert weeks_from_now(4) == weeks_after(4, now)
  end

  test "weeks_ago" do
    assert weeks_ago(4) == weeks_before(4, now)
  end

  test "a_week_from_now" do
    assert a_week_from_now == a_week_after now
  end

  test "a_week_ago" do
    assert a_week_ago == a_week_before now
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
    assert a_month_after(@a_datetime) == {{2015, 3, 27}, {18, 30, 45}}
  end

  test "a_month_before" do
    assert a_month_before(@a_datetime) == {{2015, 1, 27}, {18, 30, 45}}
  end

  test "months_from_now" do
    assert months_from_now(18) == months_after(18, now)
  end

  test "months_ago" do
    assert months_ago(10) == months_before(10, now)
  end

  test "a_month_from_now" do
    assert a_month_from_now == a_month_after now
  end

  test "a_month_ago" do
    assert a_month_ago == a_month_before now
  end

  test "years_after" do
    assert years_after(4, @a_datetime) == {{2019, 2, 27}, {18, 30, 45}}
    assert years_after(1, {{2016, 2, 29}, {12, 0, 0}}) == {{2017, 2, 28}, {12, 0, 0}}
  end

  test "years_before" do
    assert years_before(4, @a_datetime) == {{2011, 2, 27}, {18, 30, 45}}
  end

  test "a_year_after" do
    assert a_year_after(@a_datetime) == {{2016, 2, 27}, {18, 30, 45}}
  end

  test "a_year_before" do
    assert a_year_before(@a_datetime) == {{2014, 2, 27}, {18, 30, 45}}
  end

  test "years_from_now" do
    assert years_from_now(5) == years_after(5, now)
  end

  test "years_ago" do
    assert years_ago(20) == years_before(20, now)
  end

  test "a_year_from_now" do
    assert a_year_from_now == a_year_after now
  end

  test "a_year_ago" do
    assert a_year_ago == a_year_before now
  end
end
