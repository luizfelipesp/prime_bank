defmodule PrimeBankWeb.AccountsJSON do
  alias PrimeBank.Accounts.Account

  def created(%{account: account}) do
    %{
      message: "Account created successfully",
      data: data(account)
    }
  end

  def show(%{account: account}) do
    %{
      data: data(account)
    }
  end

  def transaction(%{transaction: transaction}) do
    %{
      message: "Transaction successfully",
      withdraw: data(transaction.withdraw),
      deposit: data(transaction.deposit)
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      user_id: account.user_id,
      balance: account.balance
    }
  end
end
