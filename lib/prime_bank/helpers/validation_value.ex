defmodule PrimeBank.Helpers.ValidationValue do
  @moduledoc """
  A helper to check is a valid value
  """

  def call(value) do
    Decimal.cast(value)
    |> valid_decimal(value)
  end

  defp valid_decimal(_cast_value, value) when value <= 0 and is_integer(value) do
    {:error, :bad_request}
  end

  defp valid_decimal({:ok, cast_value}, value) when is_integer(value), do: {:ok, cast_value}

  defp valid_decimal(_, _) do
    {:error, :bad_request}
  end
end
