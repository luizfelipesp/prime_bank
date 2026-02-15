defmodule PrimeBank.ViaCep.Behaviour do
  @moduledoc """
  Defines the contract for viacep integration.
  """

  @callback call(String.t()) :: {:ok, map()} | {:error, :atom}
end
