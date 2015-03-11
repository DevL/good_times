defmodule GoodTimes.StreamTest do
  use ExUnit.Case
  import GoodTimes.Stream

  @a_datetime {{2015, 2, 27}, {18, 30, 45}}

  test "all_seconds_after" do
    actual = @a_datetime |> all_seconds_after |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 27}, {18, 30, 46}},
      {{2015, 2, 27}, {18, 30, 47}}
    ]
  end

  test "all_seconds_before" do
    actual = @a_datetime |> all_seconds_before |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 27}, {18, 30, 44}},
      {{2015, 2, 27}, {18, 30, 43}}
    ]
  end

  test "all_minutes_after" do
    actual = @a_datetime |> all_minutes_after |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 27}, {18, 31, 45}},
      {{2015, 2, 27}, {18, 32, 45}}
    ]
  end

  test "all_minutes_before" do
    actual = @a_datetime |> all_minutes_before |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 27}, {18, 29, 45}},
      {{2015, 2, 27}, {18, 28, 45}}
    ]
  end

  test "all_hours_after" do
    actual = @a_datetime |> all_hours_after |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 27}, {19, 30, 45}},
      {{2015, 2, 27}, {20, 30, 45}}
    ]
  end

  test "all_hours_before" do
    actual = @a_datetime |> all_hours_before |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 27}, {17, 30, 45}},
      {{2015, 2, 27}, {16, 30, 45}}
    ]
  end

  test "all_days_after" do
    actual = @a_datetime |> all_days_after |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 28}, {18, 30, 45}},
      {{2015, 3, 1},  {18, 30, 45}}
    ]
  end

  test "all_days_before" do
    actual = @a_datetime |> all_days_before |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 26}, {18, 30, 45}},
      {{2015, 2, 25}, {18, 30, 45}}
    ]
  end

  test "all_weeks_after" do
    actual = @a_datetime |> all_weeks_after |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 3, 6},  {18, 30, 45}},
      {{2015, 3, 13}, {18, 30, 45}}
    ]
  end

  test "all_weeks_before" do
    actual = @a_datetime |> all_weeks_before |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 2, 20}, {18, 30, 45}},
      {{2015, 2, 13}, {18, 30, 45}}
    ]
  end

  test "all_months_after" do
    actual = @a_datetime |> all_months_after |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2015, 3, 27}, {18, 30, 45}},
      {{2015, 4, 27}, {18, 30, 45}}
    ]
  end

  test "all_months_before" do
    actual = @a_datetime |> all_months_before |> Enum.take 3
    assert actual == [
      {{2015, 2, 27},  {18, 30, 45}},
      {{2015, 1, 27},  {18, 30, 45}},
      {{2014, 12, 27}, {18, 30, 45}}
    ]
  end

  test "all_years_after" do
    actual = @a_datetime |> all_years_after |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2016, 2, 27}, {18, 30, 45}},
      {{2017, 2, 27}, {18, 30, 45}}
    ]
  end

  test "all_years_before" do
    actual = @a_datetime |> all_years_before |> Enum.take 3
    assert actual == [
      {{2015, 2, 27}, {18, 30, 45}},
      {{2014, 2, 27}, {18, 30, 45}},
      {{2013, 2, 27}, {18, 30, 45}}
    ]
  end
end
