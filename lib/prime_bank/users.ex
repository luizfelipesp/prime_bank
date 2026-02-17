defmodule PrimeBank.Users do
  @moduledoc """
  public API for the users domain.
  """

  alias PrimeBank.Users.Create
  alias PrimeBank.Users.Delete
  alias PrimeBank.Users.Get
  alias PrimeBank.Users.PasswordManager
  alias PrimeBank.Users.Update

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(user, params), to: Update, as: :call
  defdelegate delete(user), to: Delete, as: :call
  defdelegate login(params), to: PasswordManager, as: :call
end
