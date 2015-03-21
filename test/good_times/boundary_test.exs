defmodule GoodTimes.BoundaryTest do
  use ExUnit.Case, async: true
  import GoodTimes.Boundary
  doctest GoodTimes.Boundary

  @beginning_of_monday {{2015, 2, 23}, {0, 0, 0}}
  test "beginning_of_week stays in the same week" do
    assert @beginning_of_monday |> beginning_of_week == @beginning_of_monday
  end

  @end_of_sunday {{2015, 3, 1}, {23, 59, 59}}
  test "end_of_week stays in the same week" do
    assert @end_of_sunday |> end_of_week == @end_of_sunday
  end

  @feb_2016 {{2016, 2, 27}, {12, 0, 0}}
  test "end_of_month works with leap years" do
    assert @feb_2016 |> end_of_month == {{2016, 2, 29}, {23, 59, 59}}
  end
end
