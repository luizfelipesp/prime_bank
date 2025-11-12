defmodule PrimeBank.Factory do
  use ExMachina.Ecto, repo: PrimeBank.Repo

  use PrimeBank.UserFactory
end
