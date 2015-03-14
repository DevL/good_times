defmodule GoodTimes.BoundaryTest do
  use ExUnit.Case
  import GoodTimes.Boundary

  @a_datetime {{2015, 2, 27}, {18, 30, 45}}

  test "beginning_of_minute" do
    assert @a_datetime |> beginning_of_minute == {{2015, 2, 27}, {18, 30, 0}}
  end

  test "end_of_minute" do
    assert @a_datetime |> end_of_minute == {{2015, 2, 27}, {18, 30, 59}}
  end

  test "beginning_of_hour" do
    assert @a_datetime |> beginning_of_hour == {{2015, 2, 27}, {18, 0, 0}}
  end

  test "end_of_hour" do
    assert @a_datetime |> end_of_hour == {{2015, 2, 27}, {18, 59, 59}}
  end

  test "beginning_of_day" do
    assert @a_datetime |> beginning_of_day == {{2015, 2, 27}, {0, 0, 0}}
  end

  test "end_of_day" do
    assert @a_datetime |> end_of_day == {{2015, 2, 27}, {23, 59, 59}}
  end

  @a_monday {{2015, 2, 23}, {18, 30, 45}}
  test "beginning_of_week" do
    assert @a_datetime |> beginning_of_week == {{2015, 2, 23}, {0, 0, 0}}
    assert @a_monday |> beginning_of_week == {{2015, 2, 23}, {0, 0, 0}}
  end

  @a_sunday {{2015, 3, 1}, {18, 30, 45}}
  test "end_of_week" do
    assert @a_datetime |> end_of_week == {{2015, 3, 1}, {23, 59, 59}}
    assert @a_sunday |> end_of_week == {{2015, 3, 1}, {23, 59, 59}}
  end

  test "beginning_of_month" do
    assert @a_datetime |> beginning_of_month == {{2015, 2, 1}, {0, 0, 0}}
  end

  @feb_2016 {{2016, 2, 27}, {12, 0, 0}}
  test "end_of_month" do
    assert @a_datetime |> end_of_month == {{2015, 2, 28}, {23, 59, 59}}
    assert @feb_2016 |> end_of_month == {{2016, 2, 29}, {23, 59, 59}}
  end

  test "beginning_of_year" do
    assert @a_datetime |> beginning_of_year == {{2015, 1, 1}, {0, 0, 0}}
  end

  test "end_of_year" do
    assert @a_datetime |> end_of_year == {{2015, 12, 31}, {23, 59, 59}}
  end
end
