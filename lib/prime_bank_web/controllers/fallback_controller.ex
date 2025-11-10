defmodule PrimeBankWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: PrimeBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
