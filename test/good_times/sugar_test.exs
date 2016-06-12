defmodule GoodTimes.SugarTest do
  use ExUnit.Case
  import GoodTimes.Sugar
  import GoodTimesProposal, only: [add: 3, subtract: 3, now: 0, now: 1]

  @dt ~N[2016-06-09 12:00:00]
  @dt_erl {{2016, 6, 9}, {12, 0, 0}}

  describe "seconds" do
    test "seconds_after" do
      assert seconds_after(15, @dt) == add(@dt, 15, :seconds)
      assert seconds_after(15, @dt_erl) == add(@dt_erl, 15, :seconds)
    end

    test "seconds_before" do
      assert seconds_before(15, @dt) == subtract(@dt, 15, :seconds)
      assert seconds_before(15, @dt_erl) == subtract(@dt_erl, 15, :seconds)
    end

    test "a_second_after" do
      assert a_second_after(@dt) == add(@dt, 1, :second)
      assert a_second_after(@dt_erl) == add(@dt_erl, 1, :second)
    end

    test "a_second_before" do
      assert a_second_before(@dt) == subtract(@dt, 1, :second)
      assert a_second_before(@dt_erl) == subtract(@dt_erl, 1, :second)
    end

    test "seconds_from_now" do
      assert seconds_from_now(15) == add(now, 15, :seconds)
      assert seconds_from_now(15, :erl) == add(now(:erl), 15, :seconds)
    end

    test "seconds_ago" do
      assert seconds_ago(15) == subtract(now, 15, :seconds)
      assert seconds_ago(15, :erl) == subtract(now(:erl), 15, :seconds)
    end

    test "a_second_from_now" do
      assert a_second_from_now == add(now, 1, :second)
      assert a_second_from_now(:erl) == add(now(:erl), 1, :second)
    end

    test "a_second_ago" do
      assert a_second_ago == subtract(now, 1, :second)
      assert a_second_ago(:erl) == subtract(now(:erl), 1, :second)
    end
  end


  describe "minutes" do
    test "minutes_after" do
      assert minutes_after(15, @dt) == add(@dt, 15, :minutes)
      assert minutes_after(15, @dt_erl) == add(@dt_erl, 15, :minutes)
    end

    test "minutes_before" do
      assert minutes_before(15, @dt) == subtract(@dt, 15, :minutes)
      assert minutes_before(15, @dt_erl) == subtract(@dt_erl, 15, :minutes)
    end

    test "a_minute_after" do
      assert a_minute_after(@dt) == add(@dt, 1, :minute)
      assert a_minute_after(@dt_erl) == add(@dt_erl, 1, :minute)
    end

    test "a_minute_before" do
      assert a_minute_before(@dt) == subtract(@dt, 1, :minute)
      assert a_minute_before(@dt_erl) == subtract(@dt_erl, 1, :minute)
    end

    test "minutes_from_now" do
      assert minutes_from_now(15) == add(now, 15, :minutes)
      assert minutes_from_now(15, :erl) == add(now(:erl), 15, :minutes)
    end

    test "minutes_ago" do
      assert minutes_ago(15) == subtract(now, 15, :minutes)
      assert minutes_ago(15, :erl) == subtract(now(:erl), 15, :minutes)
    end

    test "a_minute_from_now" do
      assert a_minute_from_now == add(now, 1, :minute)
      assert a_minute_from_now(:erl) == add(now(:erl), 1, :minute)
    end

    test "a_minute_ago" do
      assert a_minute_ago == subtract(now, 1, :minute)
      assert a_minute_ago(:erl) == subtract(now(:erl), 1, :minute)
    end
  end


  describe "hours" do
    test "hours_after" do
      assert hours_after(15, @dt) == add(@dt, 15, :hours)
      assert hours_after(15, @dt_erl) == add(@dt_erl, 15, :hours)
    end

    test "hours_before" do
      assert hours_before(15, @dt) == subtract(@dt, 15, :hours)
      assert hours_before(15, @dt_erl) == subtract(@dt_erl, 15, :hours)
    end

    test "an_hour_after" do
      assert an_hour_after(@dt) == add(@dt, 1, :hour)
      assert an_hour_after(@dt_erl) == add(@dt_erl, 1, :hour)
    end

    test "an_hour_before" do
      assert an_hour_before(@dt) == subtract(@dt, 1, :hour)
      assert an_hour_before(@dt_erl) == subtract(@dt_erl, 1, :hour)
    end

    test "hours_from_now" do
      assert hours_from_now(15) == add(now, 15, :hours)
      assert hours_from_now(15, :erl) == add(now(:erl), 15, :hours)
    end

    test "hours_ago" do
      assert hours_ago(15) == subtract(now, 15, :hours)
      assert hours_ago(15, :erl) == subtract(now(:erl), 15, :hours)
    end

    test "an_hour_from_now" do
      assert an_hour_from_now == add(now, 1, :hour)
      assert an_hour_from_now(:erl) == add(now(:erl), 1, :hour)
    end

    test "an_hour_ago" do
      assert an_hour_ago == subtract(now, 1, :hour)
      assert an_hour_ago(:erl) == subtract(now(:erl), 1, :hour)
    end
  end


  describe "days" do
    test "days_after" do
      assert days_after(15, @dt) == add(@dt, 15, :days)
      assert days_after(15, @dt_erl) == add(@dt_erl, 15, :days)
    end

    test "days_before" do
      assert days_before(15, @dt) == subtract(@dt, 15, :days)
      assert days_before(15, @dt_erl) == subtract(@dt_erl, 15, :days)
    end

    test "a_day_after" do
      assert a_day_after(@dt) == add(@dt, 1, :day)
      assert a_day_after(@dt_erl) == add(@dt_erl, 1, :day)
    end

    test "a_day_before" do
      assert a_day_before(@dt) == subtract(@dt, 1, :day)
      assert a_day_before(@dt_erl) == subtract(@dt_erl, 1, :day)
    end

    test "days_from_now" do
      assert days_from_now(15) == add(now, 15, :days)
      assert days_from_now(15, :erl) == add(now(:erl), 15, :days)
    end

    test "days_ago" do
      assert days_ago(15) == subtract(now, 15, :days)
      assert days_ago(15, :erl) == subtract(now(:erl), 15, :days)
    end

    test "a_day_from_now" do
      assert a_day_from_now == add(now, 1, :day)
      assert a_day_from_now(:erl) == add(now(:erl), 1, :day)
    end

    test "a_day_ago" do
      assert a_day_ago == subtract(now, 1, :day)
      assert a_day_ago(:erl) == subtract(now(:erl), 1, :day)
    end
  end


  describe "weeks" do
    test "weeks_after" do
      assert weeks_after(15, @dt) == add(@dt, 15, :weeks)
      assert weeks_after(15, @dt_erl) == add(@dt_erl, 15, :weeks)
    end

    test "weeks_before" do
      assert weeks_before(15, @dt) == subtract(@dt, 15, :weeks)
      assert weeks_before(15, @dt_erl) == subtract(@dt_erl, 15, :weeks)
    end

    test "a_week_after" do
      assert a_week_after(@dt) == add(@dt, 1, :week)
      assert a_week_after(@dt_erl) == add(@dt_erl, 1, :week)
    end

    test "a_week_before" do
      assert a_week_before(@dt) == subtract(@dt, 1, :week)
      assert a_week_before(@dt_erl) == subtract(@dt_erl, 1, :week)
    end

    test "weeks_from_now" do
      assert weeks_from_now(15) == add(now, 15, :weeks)
      assert weeks_from_now(15, :erl) == add(now(:erl), 15, :weeks)
    end

    test "weeks_ago" do
      assert weeks_ago(15) == subtract(now, 15, :weeks)
      assert weeks_ago(15, :erl) == subtract(now(:erl), 15, :weeks)
    end

    test "a_week_from_now" do
      assert a_week_from_now == add(now, 1, :week)
      assert a_week_from_now(:erl) == add(now(:erl), 1, :week)
    end

    test "a_week_ago" do
      assert a_week_ago == subtract(now, 1, :week)
      assert a_week_ago(:erl) == subtract(now(:erl), 1, :week)
    end
  end


  describe "months" do
    test "months_after" do
      assert months_after(15, @dt) == add(@dt, 15, :months)
      assert months_after(15, @dt_erl) == add(@dt_erl, 15, :months)
    end

    test "months_before" do
      assert months_before(15, @dt) == subtract(@dt, 15, :months)
      assert months_before(15, @dt_erl) == subtract(@dt_erl, 15, :months)
    end

    test "a_month_after" do
      assert a_month_after(@dt) == add(@dt, 1, :month)
      assert a_month_after(@dt_erl) == add(@dt_erl, 1, :month)
    end

    test "a_month_before" do
      assert a_month_before(@dt) == subtract(@dt, 1, :month)
      assert a_month_before(@dt_erl) == subtract(@dt_erl, 1, :month)
    end

    test "months_from_now" do
      assert months_from_now(15) == add(now, 15, :months)
      assert months_from_now(15, :erl) == add(now(:erl), 15, :months)
    end

    test "months_ago" do
      assert months_ago(15) == subtract(now, 15, :months)
      assert months_ago(15, :erl) == subtract(now(:erl), 15, :months)
    end

    test "a_month_from_now" do
      assert a_month_from_now == add(now, 1, :month)
      assert a_month_from_now(:erl) == add(now(:erl), 1, :month)
    end

    test "a_month_ago" do
      assert a_month_ago == subtract(now, 1, :month)
      assert a_month_ago(:erl) == subtract(now(:erl), 1, :month)
    end
  end


  describe "years" do
    test "years_after" do
      assert years_after(15, @dt) == add(@dt, 15, :years)
      assert years_after(15, @dt_erl) == add(@dt_erl, 15, :years)
    end

    test "years_before" do
      assert years_before(15, @dt) == subtract(@dt, 15, :years)
      assert years_before(15, @dt_erl) == subtract(@dt_erl, 15, :years)
    end

    test "a_year_after" do
      assert a_year_after(@dt) == add(@dt, 1, :year)
      assert a_year_after(@dt_erl) == add(@dt_erl, 1, :year)
    end

    test "a_year_before" do
      assert a_year_before(@dt) == subtract(@dt, 1, :year)
      assert a_year_before(@dt_erl) == subtract(@dt_erl, 1, :year)
    end

    test "years_from_now" do
      assert years_from_now(15) == add(now, 15, :years)
      assert years_from_now(15, :erl) == add(now(:erl), 15, :years)
    end

    test "years_ago" do
      assert years_ago(15) == subtract(now, 15, :years)
      assert years_ago(15, :erl) == subtract(now(:erl), 15, :years)
    end

    test "a_year_from_now" do
      assert a_year_from_now == add(now, 1, :year)
      assert a_year_from_now(:erl) == add(now(:erl), 1, :year)
    end

    test "a_year_ago" do
      assert a_year_ago == subtract(now, 1, :year)
      assert a_year_ago(:erl) == subtract(now(:erl), 1, :year)
    end
  end

  describe "dates" do
    test "yesterday" do
      assert yesterday == now |> subtract(1, :day) |> NaiveDateTime.to_date
    end
    test "yesterday(:erl)" do
      {expected_date, _} = now(:erl) |> subtract(1, :day)
      assert yesterday(:erl) == expected_date
    end

    test "today" do
      assert today == now |> NaiveDateTime.to_date
    end
    test "today(:erl)" do
      {expected_date, _} = now(:erl)
      assert today(:erl) == expected_date
    end

    test "tomorrow" do
      assert tomorrow == now |> add(1, :day) |> NaiveDateTime.to_date
    end
    test "tomorrow(:erl)" do
      {expected_date, _} = now(:erl) |> add(1, :day)
      assert tomorrow(:erl) == expected_date
    end
  end
end
