defmodule PrimeBank.Users.Create do
  alias PrimeBank.ViaCep
  alias PrimeBank.Users.User
  alias PrimeBank.Repo

  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- ViaCep.get(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
