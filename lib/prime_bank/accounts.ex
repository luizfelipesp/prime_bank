defmodule PrimeBank.Accounts do
  @moduledoc false

  alias PrimeBank.Accounts.Create
  alias PrimeBank.Accounts.Get
  alias PrimeBank.Accounts.Transaction

  defdelegate get(id), to: Get, as: :call
  defdelegate create(params), to: Create, as: :call
  defdelegate transaction(from_account_id, to_account_id, value), to: Transaction, as: :call
end
