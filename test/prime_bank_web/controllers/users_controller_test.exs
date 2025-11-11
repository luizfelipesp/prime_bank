defmodule PrimeBankWeb.UsersControllerTest do
  use PrimeBankWeb.ConnCase

  describe "create/2" do
    test "create user successufuly", %{conn: conn} do
      params = %{
        name: "felipe",
        email: "felipe@gotmail.com",
        cep: "12345678",
        password: "12345"
      }

      response =
        conn
        |> post(~p'/api/users', params)
        |> json_response(201)

      assert "User created successfully" == response["message"]

      assert "felipe" == response["data"]["name"]
      assert "12345678" == response["data"]["cep"]
      assert "felipe@gotmail.com" == response["data"]["email"]
    end

    test "when don't pass any params", %{conn: conn} do
      empty_params = %{}

      response =
        conn
        |> post(~p'/api/users', empty_params)
        |> json_response(400)

      expected_response = %{
        "errors" => %{
          "cep" => ["can't be blank"],
          "email" => ["can't be blank"],
          "name" => ["can't be blank"],
          "password" => ["can't be blank"]
        }
      }

      assert expected_response == response
    end

    test "cep invalid lenght", %{conn: conn} do
      params_with_invalid_cep = %{
        name: "felipe",
        email: "felip@gotmail.com",
        cep: "1234567",
        password: "1234"
      }

      response =
        conn
        |> post(~p'/api/users', params_with_invalid_cep)
        |> json_response(400)

      assert "should be 8 character(s)" in response["errors"]["cep"]
    end

    test "email invalid format", %{conn: conn} do
      params_with_invalid_email = %{
        name: "felipe",
        email: "felipgotmail.com",
        cep: "12345678",
        password: "1234"
      }

      response =
        conn
        |> post(~p'/api/users', params_with_invalid_email)
        |> json_response(400)

      assert "has invalid format" in response["errors"]["email"]
    end

    test "name min caracter", %{conn: conn} do
      params_with_invalid_name = %{
        name: "fe",
        email: "felipgotmail.com",
        cep: "12345678",
        password: "1234"
      }

      response =
        conn
        |> post(~p'/api/users', params_with_invalid_name)
        |> json_response(400)

      assert "should be at least 3 character(s)" in response["errors"]["name"]
    end
  end
end
