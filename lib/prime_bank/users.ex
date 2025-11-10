defmodule PrimeBank.Users do
  alias PrimeBank.Users.Create

  defdelegate create(params), to: Create, as: :call
end
