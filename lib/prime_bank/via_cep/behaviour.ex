defmodule PrimeBank.ViaCep.Behaviour do
  @type url :: String.t()
  @type cep :: String.t()

  @callback call(url(), cep()) :: {:ok, map()} | {:error, :atom}
end
