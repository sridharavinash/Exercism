defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    do_rotate(text,shift,"")
  end

  defp do_rotate(<<>>,_,acc), do: acc
  defp do_rotate(<<c::utf8, rest::binary>>, shift, acc) when c in ?a..?z, do: apply_shift(<<c::utf8, rest::binary>>, shift, acc, ?z, ?a)
  defp do_rotate(<<c::utf8, rest::binary>>, shift, acc) when c in ?A..?Z, do: apply_shift(<<c::utf8, rest::binary>>, shift, acc, ?Z,?A)
  defp do_rotate(<<c::utf8, rest::binary>>, shift, acc) when c not in ?A..?z, do:  do_rotate(rest, shift, acc <> List.to_string([c]))
  defp do_rotate(<<_::utf8, rest::binary>>, shift, acc), do: do_rotate(rest,shift,acc)

  defp apply_shift(<<c::utf8, rest::binary>>, shift, acc, check_val, start_val) do
    cond do
      (c + shift) >= (check_val+1) ->
        s = ((c+shift) - (check_val+1)) + start_val
        do_rotate(rest, shift, acc <> List.to_string([s]))
      true ->
        do_rotate(rest, shift, acc <> List.to_string([c + shift]))
    end
  end
end
