defmodule GoodTimes.SigilTest do
  use ExUnit.Case, async: true
  doctest GoodTimes.Sigil, import: true
  import GoodTimes.Sigil

  @date {2015, 3, 22}
  @datetime {{2015, 3, 22}, {9, 2, 45}}

  test "~D given a date string returns a datetime" do
    assert ~D(2015-03-22) == {{2015, 3, 22}, {0, 0, 0}}
    assert ~D(2015-3-22) == {{2015, 3, 22}, {0, 0, 0}}
  end

  test "~D given a date and time string returns a datetime" do
    assert ~D(2015-03-22 09:02:45) == @datetime
    assert ~D(2015-3-22 09:02:45) == @datetime
    assert ~D(2015-03-22 9:02:45) == @datetime
    assert ~D(2015-3-22 9:02:45) == @datetime
  end

  test "~D given a date string and the 'd' modifier returns a date" do
    assert ~D(2015-03-22)d == @date
  end

  test "~D given a date and time string and the 'd' modifier returns a date" do
    assert ~D(2015-03-22 09:02:45)d == @date
    assert ~D(2015-3-22 09:02:45)d == @date
    assert ~D(2015-03-22 9:02:45)d == @date
    assert ~D(2015-3-22 9:02:45)d == @date
  end
end
