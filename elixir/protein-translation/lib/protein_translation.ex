defmodule ProteinTranslation do
  @codon_proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    case translate(rna) do
      [h|t] -> {:ok, Enum.reverse([h|t])}
      [] -> {:error, "invalid RNA"}
    end
  end

  defp translate(rna) do
      Regex.scan(~r/(...)/, rna)
      |> Enum.map(&hd(&1))
      |> Enum.reduce_while([], fn x, acc ->
        case of_codon(x) do
          {:ok, "STOP"} -> {:halt, acc}
          {:ok, val} -> {:cont, [val | acc]}
          {:error, _} -> {:halt, []}
        end
      end)
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codon_proteins, codon) do
      {:ok, val} -> {:ok, val}
      :error -> {:error, "invalid codon"}
    end
  end
end
