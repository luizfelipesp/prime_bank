defmodule PrimeBank.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: PrimeBank.Repo

  use PrimeBank.UserFactory
end
