defmodule GoodTimes.ConvertTest do
  use ExUnit.Case
  import GoodTimes.Convert

  @a_date {2015, 2, 27}
  @a_time {18, 30, 45}
  @a_datetime {@a_date, @a_time}

  test "to_date" do
    assert to_date(@a_datetime) == @a_date
  end

  test "to_time" do
    assert to_time(@a_datetime) == @a_time
  end

  test "from_date" do
    assert from_date(@a_date) == {@a_date, {0, 0, 0}}
  end
end
