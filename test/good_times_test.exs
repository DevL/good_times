defmodule GoodTimesTest do
  use ExUnit.Case, async: true
  import GoodTimes
  doctest GoodTimes, except: [
    nil, # to exclude moduledoc
    :moduledoc,
    now: 0, at: 2,
    seconds_from_now: 1, a_second_from_now: 0, seconds_ago: 1, a_second_ago: 0,
    minutes_from_now: 1, a_minute_from_now: 0, minutes_ago: 1, a_minute_ago: 0,
    hours_from_now: 1, an_hour_from_now: 0, hours_ago: 1, an_hour_ago: 0,
    days_from_now: 1, a_day_from_now: 0, days_ago: 1, a_day_ago: 0,
    weeks_from_now: 1, a_week_from_now: 0, weeks_ago: 1, a_week_ago: 0,
    months_from_now: 1, a_month_from_now: 0, months_ago: 1, a_month_ago: 0,
    years_from_now: 1, a_year_from_now: 0, years_ago: 1, a_year_ago: 0
  ]

  test "now" do
    assert now == :calendar.universal_time
  end

  @a_date {2015, 2, 27}
  @a_datetime {@a_date, {18, 30, 45}}

  test "at when passed a datetime" do
    assert at(@a_datetime, {10, 30, 15}) == {{2015, 2, 27}, {10, 30, 15}}
  end

  test "at when passed a date" do
    assert at(@a_date, {10, 30, 15}) == {{2015, 2, 27}, {10, 30, 15}}
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
  test "months_after to a shorter month" do
    assert months_after(1, @last_jan_2015) == {{2015, 2, 28}, {12, 0, 0}}
  end

  test "months_after wrapping around to the next year" do
    assert months_after(12, @last_jan_2015) == {{2016, 1, 31}, {12, 0, 0}}
  end

  test "months_after picks the correct last day of the month" do
    assert months_after(13, @last_jan_2015) == {{2016, 2, 29}, {12, 0, 0}}
  end

  test "months_before to a shorter month" do
    assert months_before(11, @last_jan_2015) == {{2014, 2, 28}, {12, 0, 0}}
  end

  test "months_before wrapping around to the previous year" do
    assert months_before(1, @last_jan_2015) == {{2014, 12, 31}, {12, 0, 0}}
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

  test "years_after a leap day" do
    assert years_after(1, {{2016, 2, 29}, {12, 0, 0}}) == {{2017, 2, 28}, {12, 0, 0}}
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
