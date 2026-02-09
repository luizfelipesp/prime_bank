defmodule PrimeBank.Users.Create do
  alias PrimeBank.ViaCep
  alias PrimeBank.Users.User
  alias PrimeBank.Repo

  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- client().get(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client do
    Application.get_env(:prime_bank, :via_cep_client, ViaCep)
  end
end
