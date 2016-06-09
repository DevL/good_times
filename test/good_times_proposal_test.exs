defmodule GoodTimesProposalTest do
  use ExUnit.Case, async: true
  import GoodTimesProposal

  describe "add to time" do
    test "1 second" do
      assert add(~T[12:00:00], 1, :second) == ~T[12:00:01]
      assert add({12, 0, 0}, 1, :second) == {12, 0, 1}
    end

    test "several seconds" do
      assert add(~T[12:00:00], 100, :seconds) == ~T[12:01:40]
      assert add({12, 0, 0}, 100, :seconds) == {12, 1, 40}
    end

    test "negative seconds" do
      assert add(~T[12:00:00], -1, :second) == ~T[11:59:59]
      assert add({12, 0, 0}, -1, :second) == {11, 59, 59}
    end

    test "keeps sub-second part" do
      assert add(~T[12:00:00.0001], 1, :second) == ~T[12:00:01.0001]
    end

    test "minutes" do
      assert add(~T[12:00:00], 100, :minutes) == ~T[13:40:00]
      assert add({12, 0, 0}, 100, :minutes) == {13, 40, 0}
    end

    test "hours" do
      assert add(~T[12:00:00], 4, :hours) == ~T[16:00:00]
      assert add({12, 0, 0}, 4, :hours) == {16, 0, 0}
    end

    test "wrap around" do
      assert add(~T[12:00:00], 100, :hours) == ~T[16:00:00]
      assert add({12, 0, 0}, 100, :hours) == {16, 0, 0}
    end

    test "milliseconds" do
      assert add(~T[12:00:00.000], 1, :millisecond) == ~T[12:00:00.001]
      assert add(~T[12:00:00.123], 1, :millisecond) == ~T[12:00:00.124]
      assert add(~T[12:00:00.999], 1, :millisecond) == ~T[12:00:01.000]
    end

    test "microseconds" do
      assert add(~T[12:00:00.000000], 1, :microsecond) == ~T[12:00:00.000001]
      assert add(~T[12:00:00.123456], 1, :microsecond) == ~T[12:00:00.123457]
      assert add(~T[12:00:00.999999], 1, :microsecond) == ~T[12:00:01.000000]
    end

    test "don't increase precision" do
      assert {111_111, 0} = add(~T[12:00:00], 111_111, :microseconds).microsecond
    end

    test "use precision of delta (significant digits), when less precise than original" do
      assert {123_400, 4} = add(~T[12:00:00.000000], 123_400, :microseconds).microsecond
    end

    test "imprecise delta can lose precision on original time" do
      assert {100_001, 1} = add(~T[12:00:00.000001], 100_000, :microseconds).microsecond
    end

    test "microseconds with specified precision" do
      assert {100_000, 6} = add(~T[12:00:00], 100_000, :microseconds, precision: 6).microsecond
      assert {1, 0} = add(~T[12:00:00], 1, :microseconds, precision: 0).microsecond
    end

    test "sub-second cannot be set for erlang time tuple" do
      assert_raise ArgumentError, fn -> add({12, 0, 0}, 1, :millisecond) end
      assert_raise ArgumentError, fn -> add({12, 0, 0}, 1, :microsecond) end
    end

    test "years, months, days" do
      assert_raise ArgumentError, fn -> add(~T[12:00:00], 1, :day) end
      assert_raise ArgumentError, fn -> add(~T[12:00:00], 1, :month) end
      assert_raise ArgumentError, fn -> add(~T[12:00:00], 1, :year) end
      assert_raise ArgumentError, fn -> add({12, 0, 0}, 2, :days) end
      assert_raise ArgumentError, fn -> add({12, 0, 0}, 2, :months) end
      assert_raise ArgumentError, fn -> add({12, 0, 0}, 2, :years) end
    end
  end

  describe "add to date" do
    test "1 day" do
      assert add(~D[2016-06-05], 1, :day) == ~D[2016-06-06]
      assert add({2016, 6, 5}, 1, :day) == {2016, 6, 6}
    end

    test "several days" do
      assert add(~D[2016-06-05], 30, :days) == ~D[2016-07-05]
      assert add({2016, 6, 5}, 30, :days) == {2016, 7, 5}
    end

    test "negative days" do
      assert add(~D[2016-06-05], -5, :days) == ~D[2016-05-31]
      assert add({2016, 6, 5}, -5, :days) == {2016, 5, 31}
    end

    test "weeks" do
      assert add(~D[2016-06-05], 2, :weeks) == ~D[2016-06-19]
      assert add({2016, 6, 5}, 2, :weeks) == {2016, 6, 19}
    end

    test "months" do
      assert add(~D[2016-06-05], 1, :month) == ~D[2016-07-05]
      assert add({2016, 6, 5}, 1, :month) == {2016, 7, 5}
    end

    test "years" do
      assert add(~D[2016-06-05], 5, :years) == ~D[2021-06-05]
      assert add({2016, 6, 5}, 5, :years) == {2021, 6, 5}
    end

    test "hours, minutes, seconds" do
      assert_raise ArgumentError, fn -> add(~D[2016-06-06], 1, :second) end
      assert_raise ArgumentError, fn -> add(~D[2016-06-06], 1, :minute) end
      assert_raise ArgumentError, fn -> add(~D[2016-06-06], 1, :hour) end
      assert_raise ArgumentError, fn -> add({2016, 6, 6}, 2, :seconds) end
      assert_raise ArgumentError, fn -> add({2016, 6, 6}, 2, :minutes) end
      assert_raise ArgumentError, fn -> add({2016, 6, 6}, 2, :hours) end
    end

    test "leap year" do
      assert add(~D[2015-02-28], 1, :day) == ~D[2015-03-01]
      assert add(~D[2016-02-28], 1, :day) == ~D[2016-02-29]
      assert add(~D[2015-02-28], 1, :year) == ~D[2016-02-28]
      assert add(~D[2016-02-29], 1, :year) == ~D[2017-02-28]
    end

    test "add month into shorter month" do
      assert add(~D[2016-05-31], 1, :month) == ~D[2016-06-30]
    end
  end

  describe "add to datetime" do
    test "1 second" do
      assert add(~N[2016-06-06 23:59:59], 1, :second) == ~N[2016-06-07 00:00:00]
      assert add({{2016, 6, 6}, {23, 59, 59}}, 1, :second) == {{2016, 6, 7}, {0, 0, 0}}
    end

    test "minute" do
      assert add(~N[2016-06-06 23:59:59], 1, :minute) == ~N[2016-06-07 00:00:59]
      assert add({{2016, 6, 6}, {23, 59, 59}}, 1, :minute) == {{2016, 6, 7}, {0, 0, 59}}
    end

    test "hour" do
      assert add(~N[2016-06-06 23:59:59], 1, :hour) == ~N[2016-06-07 00:59:59]
      assert add({{2016, 6, 6}, {23, 59, 59}}, 1, :hour) == {{2016, 6, 7}, {0, 59, 59}}
    end

    test "day" do
      assert add(~N[2016-06-06 23:59:59], 1, :day) == ~N[2016-06-07 23:59:59]
      assert add({{2016, 6, 6}, {23, 59, 59}}, 1, :day) == {{2016, 6, 7}, {23, 59, 59}}
    end

    test "week" do
      assert add(~N[2016-06-06 23:59:59], 1, :week) == ~N[2016-06-13 23:59:59]
      assert add({{2016, 6, 6}, {23, 59, 59}}, 1, :week) == {{2016, 6, 13}, {23, 59, 59}}
    end

    test "month" do
      assert add(~N[2016-06-06 23:59:59], 1, :month) == ~N[2016-07-06 23:59:59]
      assert add({{2016, 6, 6}, {23, 59, 59}}, 1, :month) == {{2016, 7, 6}, {23, 59, 59}}
    end

    test "year" do
      assert add(~N[2016-06-06 23:59:59], 1, :year) == ~N[2017-06-06 23:59:59]
      assert add({{2016, 6, 6}, {23, 59, 59}}, 1, :year) == {{2017, 6, 6}, {23, 59, 59}}
    end

    test "millisecond" do
      assert add(~N[2016-06-06 23:59:59.000], 1, :millisecond) == ~N[2016-06-06 23:59:59.001]
    end

    test "microsecond" do
      assert add(~N[2016-06-06 23:59:59.000000], 1, :microsecond) == ~N[2016-06-06 23:59:59.000001]
    end

    test "don't increase microsecond precision" do
      assert {111_100, 0} = add(~T[12:00:00], 111_100, :microseconds).microsecond
    end

    test "use microsecond precision of delta (significant digits), when less precise than original" do
      assert {123_400, 4} = add(~N[2016-06-06 12:00:00.000000], 123_400, :microseconds).microsecond
    end

    test "imprecise delta can lose microsecond precision on original" do
      assert {100_001, 1} = add(~N[2016-06-06 12:00:00.000001], 100_000, :microseconds).microsecond
    end

    test "microsecond precision can be specified" do
      assert {100_000, 6} = add(~N[2016-06-06 12:00:00], 100_000, :microseconds, precision: 6).microsecond
      assert {1, 0} = add(~N[2016-06-06 12:00:00], 1, :microseconds, precision: 0).microsecond
    end

    test "sub-second cannot be set for erlang datetime tuple" do
      assert_raise ArgumentError, fn -> add({{2016, 6, 6}, {12, 0, 0}}, 1, :millisecond) end
      assert_raise ArgumentError, fn -> add({{2016, 6, 6}, {12, 0, 0}}, 1, :microsecond) end
    end
  end
end
