defmodule Bob do
  def hey(input) do
    cond do
      is_empty?(input)-> "Fine. Be that way!"
      is_question?(input) and is_all_upcase?(input) -> "Calm down, I know what I'm doing!"
      is_question?(input) and not is_all_upcase?(input) -> "Sure."
      is_all_upcase?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp is_all_upcase?(s), do: String.upcase(s) == s and String.downcase(s) != s
  defp is_empty?(s), do: String.length(String.trim(s)) == 0
  defp is_question?(s), do: String.ends_with?(s, "?")
end
