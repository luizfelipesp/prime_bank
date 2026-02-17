defmodule PrimeBank.PasswordManager do
  alias PrimeBank.Users

  def call(%{"id" => id, "password" => password}) do
    with {:ok, user} <- Users.get(id) do
      verify_password?(user, password)
    end
  end

  defp verify_password?(user, password) do
    Argon2.verify_pass(password, user.password_hash)
  end
end
