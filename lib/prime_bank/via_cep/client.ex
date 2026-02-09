defmodule PrimeBank.ViaCep.Client do
  @default_url "https://viacep.com.br/ws/"

  def call(url \\ @default_url, cep) do
    Tesla.get(client(), "#{url}#{cep}/json")
    |> handler_response()
  end

  # CEP format valid but nonexistent
  defp handler_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => "true"}}}) do
    {:error, :not_found}
  end

  defp handler_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handler_response({:ok, %Tesla.Env{status: 400}}) do
    {:error, :bad_request}
  end

  defp handler_response({:error, _reason}) do
    {:error, :internal_server_error}
  end

  defp client do
    middleware = [
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware, adapter())
  end

  defp adapter do
    Application.fetch_env!(:tesla, :adapter)
  end
end
