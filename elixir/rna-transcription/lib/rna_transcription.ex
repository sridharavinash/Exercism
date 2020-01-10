defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  @rna_conv %{'A' => 'U', 'G' => 'C', 'C' => 'G', 'T' => 'A'}
  def to_rna(dna) do
    Enum.reduce(dna, '', fn x, acc -> acc ++ Map.get(@rna_conv, [x]) end)
  end
end
