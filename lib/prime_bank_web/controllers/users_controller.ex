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
