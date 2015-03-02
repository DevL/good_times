defmodule GoodTimes.Meta do
  defmacro define_time_unit_functions(time_unit, seconds_per_time_unit, a \\ "a") do
    a_time_unit_from_now = String.to_atom("#{a}_#{time_unit}_from_now")
    a_time_unit_ago = String.to_atom("#{a}_#{time_unit}_ago")

    quote do
      @doc """
      Returns the current UTC time #{unquote a} #{unquote time_unit} from now.

      ## Examples

          iex> #{unquote a_time_unit_from_now}
          #{inspect GoodTimes.seconds_after(unquote(seconds_per_time_unit), {{2015, 2, 27}, {18, 30, 45}})}

      """
      @spec unquote(a_time_unit_from_now)() :: datetime
      def unquote(a_time_unit_from_now)() do
        GoodTimes.seconds_from_now(unquote seconds_per_time_unit)
      end

      @doc """
      Returns the current UTC time #{unquote a} #{unquote time_unit} ago.

      ## Examples

          iex> #{unquote a_time_unit_ago}
          #{inspect GoodTimes.seconds_before(unquote(seconds_per_time_unit), {{2015, 2, 27}, {18, 30, 45}})}

      """
      @spec unquote(a_time_unit_ago)() :: datetime
      def unquote(a_time_unit_ago)() do
        GoodTimes.seconds_ago(unquote seconds_per_time_unit)
      end
    end
  end
end
