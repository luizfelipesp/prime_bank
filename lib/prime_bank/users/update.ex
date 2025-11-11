defmodule PrimeBank.Users.Update do
  alias PrimeBank.Users.User
  alias PrimeBank.Repo

  def call(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
