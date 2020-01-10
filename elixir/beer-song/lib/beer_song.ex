defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    {bottle_str, down, decrement} =
      case number do
        2 -> {"2 bottles", "Take one down and pass it around", "1 bottle"}
        1 -> {"1 bottle", "Take it down and pass it around", "no more bottles"}
        0 -> {"No more bottles", "Go to the store and buy some more", "99 bottles"}
        _ -> {"#{number} bottles", "Take one down and pass it around", "#{number - 1} bottles"}
      end

    """
    #{bottle_str} of beer on the wall, #{String.downcase(bottle_str)} of beer.
    #{down}, #{decrement} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    case range do
      l..l -> verse(l)
      f..l -> verse(f) <> "\n" <> lyrics((f - 1)..l)
    end
  end

  def lyrics() do
    lyrics(99..0)
  end
end
