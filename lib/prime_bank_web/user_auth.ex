defmodule PrimeBankWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias PrimeBankWeb.TokenManager

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- TokenManager.verify(token) do
      assign(conn, :user_id, data.user_id)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> put_view(json: PrimeBankWeb.ErrorJSON)
        |> render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
