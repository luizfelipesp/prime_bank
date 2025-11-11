defmodule PrimeBank.Users do
  alias PrimeBank.Users.Create
  alias PrimeBank.Users.Get
  alias PrimeBank.Users.Update
  alias PrimeBank.Users.Delete

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(user, params), to: Update, as: :call
  defdelegate delete(user), to: Delete, as: :call
end
