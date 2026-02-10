defmodule PrimeBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias PrimeBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successifully cep data info", %{bypass: bypass} do
      cep = "04538132"

      body = ~s({
          "bairro": "Itaim Bibi",
          "cep": "04538-132",
          "complemento": "de 3252 ao fim - lado par",
          "ddd": "11",
          "estado": "São Paulo",
          "gia": "1004",
          "ibge": "3550308",
          "localidade": "São Paulo",
          "logradouro": "Avenida Brigadeiro Faria Lima",
          "regiao": "Sudeste",
          "siafi": "7107",
          "uf": "SP",
          "unidade": ""
        })

      expected_response =
        {:ok,
         %{
           "bairro" => "Itaim Bibi",
           "cep" => "04538-132",
           "complemento" => "de 3252 ao fim - lado par",
           "ddd" => "11",
           "estado" => "São Paulo",
           "gia" => "1004",
           "ibge" => "3550308",
           "localidade" => "São Paulo",
           "logradouro" => "Avenida Brigadeiro Faria Lima",
           "regiao" => "Sudeste",
           "siafi" => "7107",
           "uf" => "SP",
           "unidade" => ""
         }}

      Bypass.expect(bypass, "GET", "#{cep}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end

    test "cep not found", %{bypass: bypass} do
      nonexistent_cep = "14538132"

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, ~s({"erro": "true"}))
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(nonexistent_cep)

      expected_response = {:error, :not_found}

      assert expected_response == response
    end

    test "when send bad request", %{bypass: bypass} do
      bad_cep = "1AB34"

      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 400, "")
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(bad_cep)

      expected_response = {:error, :bad_request}

      assert expected_response == response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
