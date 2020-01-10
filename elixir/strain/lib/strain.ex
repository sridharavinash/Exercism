defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_filter(list, fun, [], true)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_filter(list, fun, [], false)
  end

  defp do_filter([], _, acc, _), do: acc

  defp do_filter([head | tail], fun, acc, cond?) do
    if fun.(head) == cond? do
      do_filter(tail, fun, acc ++ [head], cond?)
    else
      do_filter(tail, fun, acc, cond?)
    end
  end
end
for
