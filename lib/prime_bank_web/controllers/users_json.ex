defmodule PrimeBankWeb.UsersJSON do
  alias PrimeBank.Users.User

  def created(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  def show(%{user: user}), do: %{data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
