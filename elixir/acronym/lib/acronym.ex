defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/[^-_\ ][[:word:]]+[^-_]|[[:upper:]]?/, string)
    |> Enum.map(fn [x] -> String.first(x) end)
    |> Enum.join()
    |> String.upcase()
  end
end
