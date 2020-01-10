defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    # using pipes to make this more readable
    String.split(m, "\n")
    |> Enum.map_join(&process(&1))
    |> enclose_list_start_end()
  end

  defp process(t = "#" <> _), do: enclose_with_header_tag(t)
  defp process(t = "*" <> _), do: enclose_with_list_tag(t)
  defp process(t), do: enclose_with_paragraph_tag(String.split(t))

  defp enclose_with_header_tag(text) do
    {hlevel, content} = parse_header_md_level(text)
    enclose_with_tag(hlevel, join_words_with_tags(content))
  end

  defp parse_header_md_level(text) do
    [h | t] = String.split(text)
    {"h#{String.length(h)}", t}
  end

  defp enclose_with_list_tag(text) do
    content = String.split(String.trim_leading(text, "* "))
    enclose_with_tag("li", join_words_with_tags(content))
  end

  defp enclose_with_paragraph_tag(text) do
    enclose_with_tag("p", join_words_with_tags(text))
  end

  defp enclose_with_tag(tag, text) do
    "<#{tag}>#{text}</#{tag}>"
  end

  defp join_words_with_tags(t) do
    Enum.map_join(t, " ", &replace_md_with_tag(&1))
  end

  defp replace_md_with_tag(w) do
    w
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(w) do
    w
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_prefix("_", "<em>")
  end

  defp replace_suffix_md(w) do
    w
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_suffix("_", "</em>")
  end

  defp enclose_list_start_end(l) do
    l
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
