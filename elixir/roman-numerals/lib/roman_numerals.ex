defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """

  @rum %{
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I",
    0 => ""
  }
  @divisors Enum.sort(Map.keys(@rum), &(&1 >= &2))
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    do_numeral(number, @divisors, "")
  end

  defp do_numeral(number, [head | tail], acc) do
    case head do
      0 -> acc
      _ ->
        msb = div(number, head)
        roman_ch = Map.get(@rum, head)
        next = rem(number, head)
        do_numeral(next, tail, acc <> String.duplicate(roman_ch,msb))
    end
  end
end
