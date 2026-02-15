defmodule PrimeBank.ViaCep do
  @moduledoc """
  Layer on to call client
  """

  defdelegate get(cep), to: PrimeBank.ViaCep.Client, as: :call
end
