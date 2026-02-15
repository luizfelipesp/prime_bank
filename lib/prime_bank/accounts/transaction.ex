defmodule PrimeBank.Accounts.Transaction do
  alias PrimeBank.Repo
  alias PrimeBank.Accounts.Account
  alias PrimeBank.Accounts
  alias Ecto.Multi

  def call(from_account_id, to_account_id, value) do
    with {:ok, from_account} <- Accounts.get(from_account_id),
         {:ok, to_account} <- Accounts.get(to_account_id) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transact()
    end
  end

  defp withdraw(multi, from_account, value) do
    new_balance = Decimal.sub(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})

    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, to_account, value) do
    new_balance = Decimal.add(to_account.balance, value)
    changeset = Account.changeset(to_account, %{balance: new_balance})

    Multi.update(multi, :deposit, changeset)
  end
end
