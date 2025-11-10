defmodule PrimeBankWeb.UsersController do
  use PrimeBankWeb, :controller

  alias PrimeBank.Users.User
  alias PrimeBank.Users

  action_fallback PrimeBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:created, user: user)
    end
  end
end
