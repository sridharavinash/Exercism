defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels ["a", "e", "i", "o", "u"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    for c <- String.split(String.downcase(phrase)) do
      cond do
        String.starts_with?(c, @vowels) or String.match?(c, ~r/^[xy](?![aeiou])/) ->
          c <> "ay"

        String.match?(c, ~r/qu/) ->
          [{i, l}] = Regex.run(~r/qu/, c, return: :index)

          x =
            String.split_at(c, i + l)
            |> Tuple.to_list()
            |> Enum.reverse()
            |> Enum.join()

          x <> "ay"

        true ->
          [{i, _}] = Regex.run(~r/[aeiou]/, c, return: :index)
          String.slice(c, i..-1) <> String.slice(c, 0..(i - 1)) <> "ay"
      end
    end
    |> Enum.join(" ")
    |> IO.iodata_to_binary()
    |> String.trim_trailing()
  end
end
