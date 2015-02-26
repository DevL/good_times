defmodule GoodTimesTest do
  use ExUnit.Case
  import GoodTimes

  test "now" do
    assert now == :calendar.universal_time
  end

  @tag :pending
  test "seconds_from_now", do: end

  @tag :pending
  test "seconds_ago", do: end
end
