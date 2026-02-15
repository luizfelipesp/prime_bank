defmodule PrimeBankWeb.UsersControllerTest do
  use PrimeBankWeb.ConnCase

  import Mox

  setup :verify_on_exit!

  alias PrimeBank.Repo
  alias PrimeBank.Users.User
  alias PrimeBank.ViaCep.ClientMock

  describe "create/2" do
    test "create user successufuly", %{conn: conn} do
      expected_cep = "12345678"

      params = %{
        name: "felipe",
        email: "felipe@gotmail.com",
        cep: "12345678",
        password: "123456"
      }

      ClientMock
      |> expect(:call, fn ^expected_cep -> {:ok, ""} end)

      response =
        conn
        |> post(~p'/api/users', params)
        |> json_response(201)

      assert "User created successfully" == response["message"]

      assert "12345678" == response["data"]["cep"]
      assert "felipe" == response["data"]["name"]
      assert "felipe@gotmail.com" == response["data"]["email"]
    end

    test "password min caracter", %{conn: conn} do
      param_with_invalid_password = %{
        name: "felipe",
        email: "felip@gotmail.com",
        cep: "12345678",
        password: "1234"
      }

      expected_cep = "12345678"

      ClientMock
      |> expect(:call, fn ^expected_cep -> {:ok, ""} end)

      response =
        conn
        |> post(~p'/api/users', param_with_invalid_password)
        |> json_response(400)

      assert "should be at least 6 character(s)" in response["errors"]["password"]
    end

    test "cep invalid lenght", %{conn: conn} do
      params_with_invalid_cep = %{
        name: "felipe",
        email: "felip@gotmail.com",
        cep: "1234567",
        password: "123456"
      }

      expected_cep = "1234567"

      ClientMock
      |> expect(:call, fn ^expected_cep -> {:ok, ""} end)

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
        password: "123456"
      }

      expected_cep = "12345678"

      ClientMock
      |> expect(:call, fn ^expected_cep -> {:ok, ""} end)

      response =
        conn
        |> post(~p'/api/users', params_with_invalid_email)
        |> json_response(400)

      assert "has invalid format" in response["errors"]["email"]
    end

    test "name min caracter", %{conn: conn} do
      params_with_invalid_name = %{
        name: "fe",
        email: "felip@gotmail.com",
        cep: "12345678",
        password: "123456"
      }

      expected_cep = "12345678"

      ClientMock
      |> expect(:call, fn ^expected_cep -> {:ok, ""} end)

      response =
        conn
        |> post(~p'/api/users', params_with_invalid_name)
        |> json_response(400)

      assert "should be at least 3 character(s)" in response["errors"]["name"]
    end
  end

  describe "show/1" do
    test "get an user", %{conn: conn} do
      user = insert(:user, %{name: "felipe", cep: "64789657"})

      response =
        conn
        |> get(~p'/api/users/#{user.id}')
        |> json_response(200)

      assert "felipe" == response["data"]["name"]
      assert "64789657" == response["data"]["cep"]
    end

    test "user not found", %{conn: conn} do
      some_id = 1

      response =
        conn
        |> get(~p'/api/users/#{some_id}')
        |> json_response(404)

      assert "User not found" == response["message"]
    end
  end

  describe "update/1" do
    test "success user updated name", %{conn: conn} do
      user = insert(:user, %{name: "felipe"})

      params_body = %{
        name: "Luiz"
      }

      response =
        conn
        |> put(~p'/api/users/#{user.id}', params_body)
        |> json_response(200)

      assert user.id == response["data"]["id"]
      assert "Luiz" == response["data"]["name"]
      assert "User updated" == response["message"]
    end

    test "try update cep", %{conn: conn} do
      user = insert(:user, %{cep: "64789657"})

      params_body = %{
        cep: "12345678"
      }

      expected_cep = "12345678"

      ClientMock
      |> expect(:call, fn ^expected_cep -> {:ok, ""} end)

      response =
        conn
        |> put(~p'/api/users/#{user.id}', params_body)
        |> json_response(200)

      assert user.id == response["data"]["id"]
      assert expected_cep == response["data"]["cep"]
      assert "User updated" == response["message"]
    end

    test "try update cep invalid format", %{conn: conn} do
      user = insert(:user, %{cep: "64789657"})

      params_body = %{
        cep: "12634"
      }

      ClientMock
      |> expect(:call, fn _ -> {:ok, ""} end)

      response =
        conn
        |> put(~p'/api/users/#{user.id}', params_body)
        |> json_response(400)

      assert "should be 8 character(s)" in response["errors"]["cep"]
    end

    # TO DO: update endpoint allows password change
    # Fix branch: bug/password_updated

    # test "try update password",%{conn: conn}

    test "user not found", %{conn: conn} do
      some_id = 1

      params_body = %{name: "felipe"}

      response =
        conn
        |> put(~p'/api/users/#{some_id}', params_body)
        |> json_response(404)

      assert "User not found" == response["message"]
    end
  end

  describe "delete/1" do
    test "user deleted successfully", %{conn: conn} do
      user = insert(:user)

      conn = delete(conn, ~p'/api/users/#{user.id}')
      assert response(conn, 204)

      assert nil == Repo.get(User, user.id)
    end

    test "user not found", %{conn: conn} do
      some_id = 1

      response =
        conn
        |> delete(~p'/api/users/#{some_id}')
        |> json_response(404)

      assert "User not found" == response["message"]
    end
  end
end
