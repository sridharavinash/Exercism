defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    do_encode(String.codepoints(string), 1, -1, "", [])
    |> Enum.join()
  end

  defp do_encode([], _, _, _, acc), do: acc

  defp do_encode([h | t], c, pos, prev, acc) do
    cond do
      prev == h -> do_encode(t, c + 1, pos, h, List.replace_at(acc, pos, to_string(c + 1) <> h))
      true -> do_encode(t, 1, pos + 1, h, acc ++ [h])
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/([0-9]+)([A-Z]|[a-z]|\W)|([A-Z]|[a-z]|\W)/, string)
    |> Enum.map(fn x ->
      case Integer.parse(hd(tl(x))) do
        {n, _} -> String.duplicate(List.last(x), n)
        _ -> List.last(x)
      end
    end)
    |> Enum.join()
  end
end
