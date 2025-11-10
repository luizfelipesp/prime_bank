defmodule PrimeBank.Users do
  alias PrimeBank.Users.Create
  alias PrimeBank.Users.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
