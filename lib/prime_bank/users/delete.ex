defmodule PrimeBank.Users.Delete do
  alias PrimeBank.Repo

  def call(user) do
    Repo.delete(user)
  end
end
