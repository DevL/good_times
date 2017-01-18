defmodule GoodTimes.Date do
  @vsn GoodTimes.version

  @moduledoc """
  Expressive functions operating on and returning dates.

  Unless otherwise stated, they all operate on and return an Erlang date
  based on the Coordinated Universal Time (UTC).

  ## Examples

      iex> today
      {2015, 2, 27}
      iex> tomorrow
      {2015, 2, 28}
      iex> yesterday
      {2015, 2, 26}
  """

  @doc """
  Returns today's date.

  ## Examples

      iex> today
      {2015, 2, 27}
  """
  @spec today :: GoodTimes.date
  def today, do: GoodTimes.Convert.to_date(GoodTimes.now())

  @doc """
  Returns tomorrow's date.

  ## Examples

      iex> tomorrow
      {2015, 2, 28}
  """
  @spec tomorrow :: GoodTimes.date
  def tomorrow, do: GoodTimes.Convert.to_date(GoodTimes.a_day_from_now())

  @doc """
  Returns yesterday's date.

  ## Examples

      iex> yesterday
      {2015, 2, 26}
  """
  @spec yesterday :: GoodTimes.date
  def yesterday, do: GoodTimes.Convert.to_date(GoodTimes.a_day_ago())
end
