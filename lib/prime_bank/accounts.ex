defmodule PrimeBank.Accounts do
  alias PrimeBank.Accounts.Create

  defdelegate create(params), to: Create, as: :call
end
