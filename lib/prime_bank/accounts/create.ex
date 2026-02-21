defmodule PrimeBank.Accounts.Create do
  @moduledoc false

  alias PrimeBank.Accounts.Account
  alias PrimeBank.Repo

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
