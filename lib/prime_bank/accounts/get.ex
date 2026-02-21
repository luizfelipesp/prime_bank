defmodule PrimeBank.Accounts.Get do
  @moduledoc false

  alias PrimeBank.Accounts.Account
  alias PrimeBank.Repo

  def call(id) do
    case Repo.get(Account, id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
