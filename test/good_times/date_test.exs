defmodule GoodTimes.DateTest do
  use ExUnit.Case, async: true
  import GoodTimes
  import GoodTimes.Convert
  import GoodTimes.Date

  test "today" do
    assert today == to_date(now)
  end

  test "tomorrow" do

    assert tomorrow == to_date(a_day_from_now)
  end

  test "yesterday" do
    assert yesterday == to_date(a_day_ago)
  end
end
