defmodule PrimeBank.Users.Create do
  @moduledoc false
  alias PrimeBank.ViaCep.Client
  alias PrimeBank.Repo
  alias PrimeBank.Users.User
  alias PrimeBank.ViaCep

  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- client().call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client do
    Application.get_env(:prime_bank, :via_cep_client, Client)
  end
end
