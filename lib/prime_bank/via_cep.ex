defmodule PrimeBank.ViaCep do
  defdelegate get(cep), to: PrimeBank.ViaCep.Client, as: :call
end
