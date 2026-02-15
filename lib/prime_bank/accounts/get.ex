defmodule PrimeBank.Accounts.Get do
  alias PrimeBank.Repo
  alias PrimeBank.Accounts.Account

  def call(id) do
    case Repo.get(Account, id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
