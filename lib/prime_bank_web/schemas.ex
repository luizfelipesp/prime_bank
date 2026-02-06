defmodule PrimeBankWeb.Schemas do
  alias OpenApiSpex.Schema

  defmodule User do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      # The title is optional. It defaults to the last section of the module name.
      # So the derived title for MyApp.User is "User".
      title: "User",
      description: "A user of the app",
      type: :object,
      properties: %{
        id: %Schema{type: :integer, description: "User ID"},
        name: %Schema{type: :string, description: "User name", pattern: ~r/[a-zA-Z][a-zA-Z0-9_]+/},
        email: %Schema{type: :string, description: "Email address", format: :email},
        cep: %Schema{type: :string, description: "CEP address", format: "123456789"},
        password: %Schema{type: :string, description: "User password", format: "123456"},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      required: [:name, :password, :email, :cep],
      example: %{
        "id" => 123,
        "name" => "Joe User",
        "email" => "joe@gmail.com",
        "password" => "A2e45c",
        "cep" => "123456789",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end

  defmodule UserParams do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UserParams",
      description: "Params schema for single user",
      type: :object,
      properties: %{
        data: User
      },
      example: %{
        "name" => "Luiz Felipe",
        "email" => "lfelipe@gmail.com",
        "cep" => "123456789"
      }
    })
  end

  defmodule UserResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UserResponse",
      description: "Response schema for single user",
      type: :object,
      properties: %{
        data: User
      },
      example: %{
        "data" => %{
          "id" => 1,
          "name" => "Joe User",
          "email" => "joe@gmail.com",
          "cep" => "123456789"
        }
      }
    })
  end
end
