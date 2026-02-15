defmodule PrimeBank.Users.Create do
  @moduledoc false
  alias PrimeBank.Repo
  alias PrimeBank.Users.User
  alias PrimeBank.ViaCep

  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- ViaCep.get(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
