defmodule PrimeBank.Users.PasswordManager do
  @moduledoc false

  alias PrimeBank.Users

  def call(%{"id" => id, "password" => password}) do
    with {:ok, user} <- Users.get(id) do
      verify_password?(user, password)
    end
  end

  defp verify_password?(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      _ -> {:error, :unauthorized}
    end
  end
end
