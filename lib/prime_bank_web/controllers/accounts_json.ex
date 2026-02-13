defmodule PrimeBankWeb.AccountsJSON do
  alias PrimeBank.Accounts.Account

  def created(%{account: account}) do
    %{
      message: "Account created successfully",
      data: data(account)
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
