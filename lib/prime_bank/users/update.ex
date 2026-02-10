defmodule PrimeBank.Users.Update do
  alias PrimeBank.Users.User
  alias PrimeBank.Repo

  alias PrimeBank.ViaCep.Client

  def call(user, %{"cep" => cep} = params) do
    with {:ok, _} <- client().call(cep) do
      user
      |> User.changeset(params)
      |> Repo.update()
    end
  end

  def call(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  defp client do
    Application.get_env(:prime_bank, :via_cep_client, Client)
  end
end
