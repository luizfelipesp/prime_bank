defmodule PrimeBank.Repo.Migrations.AddUniqueConstraintToAccounts do
  use Ecto.Migration

  def change do
    create unique_index(:accounts, [:user_id], name: :unique_user_account)
  end
end
