defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  defp do_count([], acc), do: acc

  defp do_count([_ | t], acc) do
    do_count(t, acc + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], acc), do: acc

  defp do_reverse([h | t], acc) do
    do_reverse(t, [h | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
  end

  defp do_map([], _, acc), do: reverse(acc)

  defp do_map([h | t], f, acc) do
    do_map(t, f, [f.(h) | acc])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
  end

  defp do_filter([], _, acc), do: reverse(acc)

  defp do_filter([h | t], f, acc) do
    cond do
      f.(h) -> do_filter(t, f, [h | acc])
      true -> do_filter(t, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
    do_reduce(l, f, acc)
  end

  defp do_reduce([], _, acc), do: acc

  defp do_reduce([h | t], f, acc) do
    do_reduce(t, f, f.(h, acc))
  end

  @spec append(list, list) :: list
  def append(a, b) do
    reduce(reverse(a), b, fn x, acc -> [x | acc] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ret =
      ListOps.reduce(ll, [], fn x, acc ->
        case x do
          [h | t] -> do_concat(t, [h | acc])
          _ -> acc
        end
      end)

    reverse(ret)
  end

  defp do_concat(a, b) do
    case a do
      [h | t] -> do_concat(t, [h | b])
      _ -> b
    end
  end
end
