defmodule GoodTimes.ConvertTest do
  use ExUnit.Case
  import GoodTimes.Convert

  @a_date {2015, 2, 27}
  @a_time {18, 30, 45}
  @a_datetime {@a_date, @a_time}

  test "datetime_to_date" do
    assert datetime_to_date(@a_datetime) == @a_date
  end

  test "datetime_to_time" do
    assert datetime_to_time(@a_datetime) == @a_time
  end

  test "date_to_datetime" do
    assert date_to_datetime(@a_date) == {@a_date, {0, 0, 0}}
  end
end
