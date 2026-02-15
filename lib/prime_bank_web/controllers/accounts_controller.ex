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

  def show(conn, %{"id" => id}) do
    with {:ok, account} <- Accounts.get(id) do
      conn
      |> put_status(:ok)
      |> render(:show, account: account)
    end
  end

  def transaction(
        conn,
        %{
          "from_account_id" => from_account_id,
          "to_account_id" => to_account_id,
          "value" => value
        } = _params
      ) do
    # IO.inspect(params)

    with {:ok, transaction} <- Accounts.transaction(from_account_id, to_account_id, value) do
      conn
      |> put_status(:ok)
      |> render(:transaction, transaction: transaction)
    end
  end
end
