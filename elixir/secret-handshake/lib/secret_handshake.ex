use Bitwise
defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  @checks Enum.with_index(["wink", "double blink", "close your eyes", "jump", "reverse"])
  |> Enum.map(fn {k,v} -> {k, round(:math.pow(2,v))} end)
  def commands(code) do
    seq = @checks
    |> Enum.filter(fn {_,v} -> band(code,v) == v  end)
    |> Enum.map(fn {k,_} -> k end)

    cond do
      List.last(seq) == "reverse" ->
        seq
        |> Enum.reverse
        |> Enum.slice(1..-1)
      true ->
        seq
    end
  end
end
