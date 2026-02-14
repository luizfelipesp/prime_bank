defmodule PrimeBank.Accounts.Transaction do
  alias PrimeBank.Accounts.Account
  alias PrimeBank.Repo
  alias Ecto.Multi

  def call(from_account_id, to_account_id, value) do
    with from_account <- Repo.get(Account, from_account_id),
         to_account <- Repo.get(Account, to_account_id) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transact()
    end
  end

  defp deposit(multi, from_account, value) do
    new_balance = Decimal.add(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})

    Multi.update(multi, :deposit, changeset)
  end

  defp withdraw(multi, from_account, value) do
    new_balance = Decimal.sub(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})

    Multi.update(multi, :withdraw, changeset)
  end
end
