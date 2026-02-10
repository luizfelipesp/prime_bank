defmodule PrimeBank.ViaCep.Behaviour do
  @callback call(String.t()) :: {:ok, map()} | {:error, :atom}
end
