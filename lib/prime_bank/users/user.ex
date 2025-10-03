defmodule PrimeBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :password_hash, :email, :cep]

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
  end
end
