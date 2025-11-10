defmodule PrimeBankWeb.UsersController do
  use PrimeBankWeb, :controller

  alias PrimeBank.Users.Create
  alias PrimeBank.Users.User

  action_fallback PrimeBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render(:created, user: user)
    end
  end
end
