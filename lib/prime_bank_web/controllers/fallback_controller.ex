defmodule PrimeBankWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: PrimeBankWeb.ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call(conn, {:error, :bad_request} = error) do
    IO.inspect(error)

    IO.inspect("call :bad_request")

    conn
    |> put_status(:bad_request)
    |> put_view(json: PrimeBankWeb.ErrorJSON)
    |> render(:error, status: :bad_request)
  end

  def call(conn, {:error, error}) do
    IO.inspect(error)
    IO.inspect("call :internal_server_error")

    conn
    |> put_status(:internal_server_error)
    |> put_view(json: PrimeBankWeb.ErrorJSON)
    |> render(:error, status: :internal_server_error)
  end

  def call(conn, {:error, changeset}) do
    IO.inspect(changeset)

    __ENV__.file
    |> String.split("/", trim: true)
    |> List.last()
    |> File.exists?()
    |> dbg()

    conn
    |> put_status(:bad_request)
    |> put_view(json: PrimeBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
