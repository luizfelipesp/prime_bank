defmodule PrimeBankWeb.UsersController do
  use PrimeBankWeb, :controller

  alias PrimeBank.Users.Create

  def create(conn, params) do
    params
    |> Create.call()
    |> handle_response(conn)
  end

  defp handle_response({:ok, user}, conn) do
    conn
    |> put_status(:created)
    |> render(:created, user: user)
  end

  defp handle_response({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: PrimeBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
