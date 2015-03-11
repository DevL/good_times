defmodule GoodTimes.BoundaryTest do
  use ExUnit.Case
  import GoodTimes.Boundary

  @a_datetime {{2015, 2, 27}, {18, 30, 45}}

  test "beginning_of_minute" do
    assert @a_datetime |> beginning_of_minute == {{2015, 2, 27}, {18, 30, 00}}
  end
end
