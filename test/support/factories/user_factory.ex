defmodule PrimeBank.UserFactory do
  @moduledoc false

  alias PrimeBank.Users.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        attrs = %{
          name: sequence(:name, ["felipe", "luiz", "carlos"]),
          email: sequence(:email, &"email-#{&1}@example.com"),
          cep: "12345678",
          password: "123456"
        }

        struct(%User{}, User.changeset(attrs).changes)
      end
    end
  end
end
