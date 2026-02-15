defmodule PrimeBank.Users.Delete do
  @moduledoc false
  alias PrimeBank.Repo

  def call(user) do
    Repo.delete(user)
  end
end
