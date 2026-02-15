defmodule PrimeBank.Users.Update do
  @moduledoc false

  alias PrimeBank.Repo
  alias PrimeBank.Users.User

  def call(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
