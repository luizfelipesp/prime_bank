defmodule PrimeBank.Users.Get do
  alias PrimeBank.Users.User
  alias PrimeBank.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
