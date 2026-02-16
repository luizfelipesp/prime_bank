defmodule PrimeBank.Accounts.Create do
  alias PrimeBank.Repo
  alias PrimeBank.Accounts.Account

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
