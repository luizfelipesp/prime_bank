defmodule PrimeBankWeb.TokenManager do
  alias PrimeBankWeb.Endpoint

  @sign_salt "prime_bank_api"

  def sign(user) do
    Phoenix.Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token), do: Phoenix.Token.verify(Endpoint, @sign_salt, token)
end
