defmodule PrimeBank.AuthHelper do
  @moduledoc false

  use PrimeBankWeb.ConnCase

  alias PrimeBankWeb.TokenManager

  def authentication_conn(conn, user) do
    token = TokenManager.sign(user)

    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end
