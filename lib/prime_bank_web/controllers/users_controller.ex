defmodule PrimeBankWeb.UsersController do
  use PrimeBankWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias PrimeBank.Users.User
  alias PrimeBank.Users
  alias PrimeBankWeb.Schemas.{UserParams, UserResponse}

  action_fallback PrimeBankWeb.FallbackController

  tags ["users"]
  security [%{}, %{"petstore_auth" => ["write:users, read:users"]}]

  operation :create, false

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:created, user: user)
    end
  end

  operation :show,
    summary: "Show an user",
    parameters: [
      id: [in: :path, description: "User ID", type: :integer, example: 1]
    ],
    responses: [
      ok: {"User response", "application/json", UserResponse}
    ]

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  operation :update, false

  def update(conn, %{"id" => id} = params) do
    with {:ok, %User{} = user} <- Users.get(id),
         {:ok, user_updated} <- Users.update(user, params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user_updated)
    end
  end

  operation :delete, false

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id),
         {:ok, _} <- Users.delete(user) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end
