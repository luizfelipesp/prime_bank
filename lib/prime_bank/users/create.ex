defmodule PrimeBank.Users.Create do
  alias PrimeBank.Users.User
  alias PrimeBank.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
