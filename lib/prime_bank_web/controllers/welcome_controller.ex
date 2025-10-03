defmodule PrimeBankWeb.WelcomeController do
  use PrimeBankWeb, :controller

  def index(conn, params) do
    conn
    |> put_status(200)
    |> json(%{message: "Seja Bem vindo #{params["index"]} ao PrimeBank"})
  end
end
