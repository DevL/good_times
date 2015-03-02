defmodule GoodTimes.Meta do
  def a_datetime, do: {{2015, 2, 27}, {18, 30, 45}}

  defmacro define_time_unit_functions(time_unit, seconds_per_time_unit, a \\ "a") do
    time_units = "#{time_unit}s" # TODO: pass in optional plural

    time_units_after = String.to_atom "#{time_units}_after"
    a_time_unit_after = String.to_atom "#{a}_#{time_unit}_after"
    time_units_before = String.to_atom "#{time_units}_before"
    a_time_unit_before = String.to_atom "#{a}_#{time_unit}_before"
    time_units_from_now = String.to_atom "#{time_units}_from_now"
    a_time_unit_from_now = String.to_atom "#{a}_#{time_unit}_from_now"
    time_units_ago = String.to_atom "#{time_units}_ago"
    a_time_unit_ago = String.to_atom "#{a}_#{time_unit}_ago"

    quote do
      @doc """
      Returns the UTC date and time the specified #{unquote time_units} after the given datetime.

      ## Examples

          iex> 15 |> #{unquote time_units_after} #{inspect a_datetime}
          #{inspect GoodTimes.Seconds.seconds_after(15 * unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(time_units_after)(integer, GoodTimes.Now.datetime) :: GoodTimes.Now.datetime
      def unquote(time_units_after)(integer, datetime) do
        GoodTimes.Seconds.seconds_after(integer * unquote(seconds_per_time_unit), datetime)
      end


      @doc """
      Returns the UTC date and time #{unquote a} #{unquote time_unit} after the given datetime.

      ## Examples

          iex> #{unquote a_time_unit_after} #{inspect a_datetime}
          #{inspect GoodTimes.Seconds.seconds_after(unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(a_time_unit_after)(GoodTimes.Now.datetime) :: GoodTimes.Now.datetime
      def unquote(a_time_unit_after)(datetime) do
        GoodTimes.Seconds.seconds_after(unquote(seconds_per_time_unit), datetime)
      end


      @doc """
      Returns the UTC date and time the specified #{unquote time_units} before the given datetime.

      ## Examples

          iex> 15 |> #{unquote time_units_before} #{inspect a_datetime}
          #{inspect GoodTimes.Seconds.seconds_before(15 * unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(time_units_before)(integer, GoodTimes.Now.datetime) :: GoodTimes.Now.datetime
      def unquote(time_units_before)(integer, datetime) do
        GoodTimes.Seconds.seconds_before(integer * unquote(seconds_per_time_unit), datetime)
      end


      @doc """
      Returns the UTC date and time #{unquote a} #{unquote time_unit} after the given datetime.

      ## Examples

          iex> #{unquote a_time_unit_before} #{inspect a_datetime}
          #{inspect GoodTimes.Seconds.seconds_before(unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(a_time_unit_before)(GoodTimes.Now.datetime) :: GoodTimes.Now.datetime
      def unquote(a_time_unit_before)(datetime) do
        GoodTimes.Seconds.seconds_before(unquote(seconds_per_time_unit), datetime)
      end


      @doc """
      Returns the current UTC time the specified #{unquote time_units} from now.

      ## Examples

          iex> 15 |> #{unquote time_units_from_now}
          #{inspect GoodTimes.Seconds.seconds_from_now(15 * unquote seconds_per_time_unit)}
      """
      @spec unquote(time_units_from_now)(integer) :: GoodTimes.Now.datetime
      def unquote(time_units_from_now)(integer) do
        GoodTimes.Seconds.seconds_from_now(integer * unquote seconds_per_time_unit)
      end


      @doc """
      Returns the current UTC time the specified #{unquote time_units} ago.

      ## Examples

          iex> 15 |> #{unquote time_units_ago}
          #{inspect GoodTimes.Seconds.seconds_ago(15 * unquote seconds_per_time_unit)}
      """
      @spec unquote(time_units_ago)(integer) :: GoodTimes.Now.datetime
      def unquote(time_units_ago)(integer) do
        GoodTimes.Seconds.seconds_ago(integer * unquote seconds_per_time_unit)
      end


      @doc """
      Returns the current UTC time #{unquote a} #{unquote time_unit} from now.

      ## Examples

          iex> #{unquote a_time_unit_from_now}
          #{inspect GoodTimes.Seconds.seconds_after(unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(a_time_unit_from_now)() :: GoodTimes.Now.datetime
      def unquote(a_time_unit_from_now)() do
        GoodTimes.Seconds.seconds_from_now(unquote seconds_per_time_unit)
      end


      @doc """
      Returns the current UTC time #{unquote a} #{unquote time_unit} ago.

      ## Examples

          iex> #{unquote a_time_unit_ago}
          #{inspect GoodTimes.Seconds.seconds_before(unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(a_time_unit_ago)() :: GoodTimes.Now.datetime
      def unquote(a_time_unit_ago)() do
        GoodTimes.Seconds.seconds_ago(unquote seconds_per_time_unit)
      end
    end
  end
end
