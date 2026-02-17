defmodule PrimeBankWeb.UsersController do
  use PrimeBankWeb, :controller

  alias PrimeBank.Users
  alias PrimeBank.Users.User
  alias PrimeBankWeb.TokenManager

  action_fallback PrimeBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:created, user: user)
    end
  end

  def login(conn, params) do
    with {:ok, user} <- Users.login(params) do
      token = TokenManager.sign(user)

      conn
      |> put_status(:ok)
      |> render(:login, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %User{} = user} <- Users.get(id),
         {:ok, user_updated} <- Users.update(user, params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user_updated)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id),
         {:ok, _} <- Users.delete(user) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end
