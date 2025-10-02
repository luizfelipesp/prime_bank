defmodule PrimeBank.Repo do
  use Ecto.Repo,
    otp_app: :prime_bank,
    adapter: Ecto.Adapters.Postgres
end
