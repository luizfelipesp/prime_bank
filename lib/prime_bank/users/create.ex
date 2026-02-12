defmodule PrimeBank.Users.Create do
  alias PrimeBank.ViaCep.Client
  alias PrimeBank.Users.User
  alias PrimeBank.Repo

  def call(params) do
    IO.inspect("QUEBRANDO AQUI")

    with {:ok, _} <- client().call(params["cep"]) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client do
    Application.get_env(:prime_bank, :via_cep_client, Client)
  end
end
