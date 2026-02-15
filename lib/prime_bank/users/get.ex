defmodule PrimeBank.Users.Get do
  @moduledoc false

  alias PrimeBank.Repo
  alias PrimeBank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
