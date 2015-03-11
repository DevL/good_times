defmodule GoodTimes.Boundary do
  @doc """
  Returns the UTC date and time at the start of the given datetime's minute.

  ## Examples

      iex> {{2015, 2, 27}, {18, 30, 45}} |> beginning_of_minute
      {{2015, 2, 27}, {18, 30, 0}}

  """
  @spec beginning_of_minute(GoodTimes.datetime) :: GoodTimes.datetime
  def beginning_of_minute({date, {h, m, _}}) do
    {date, {h, m, 0}}
  end
end
