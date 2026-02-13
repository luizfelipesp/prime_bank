defmodule PrimeBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias PrimeBank.Users.User

  @create_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @create_params)
    |> validate_required(@create_params)
    |> check_constraint(:balance, name: :balance_must_be_positive)
  end
end
