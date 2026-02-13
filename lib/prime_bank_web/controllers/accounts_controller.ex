defmodule PrimeBankWeb.AccountsController do
  use PrimeBankWeb, :controller

  alias PrimeBank.Accounts.Account
  alias PrimeBank.Accounts
  alias PrimeBank.Users

  action_fallback PrimeBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, _} <- Users.get(params["user_id"]),
         {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:created, account: account)
    end
  end
end
