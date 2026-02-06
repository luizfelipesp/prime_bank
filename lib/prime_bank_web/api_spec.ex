defmodule PrimeBankWeb.ApiSpec do
  alias OpenApiSpex.{Info, OpenApi, Paths, Server}
  alias PrimeBankWeb.{Router}
  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [
        Server.from_endpoint(PrimeBankWeb.Endpoint)
      ],
      info: %Info{
        title: "PrimeBank",
        version: "1.0"
      },
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
