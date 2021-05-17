defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "Hugo",
        cpf: "12212212212",
        email: "h@h.com"
      }

      response = CreateOrUpdateUser.call(params)

      expected = {:ok, "User created successfully"}

      assert response == expected
    end

    test "when any param is valid, returns an error" do
      params = %{
        name: "Hugo",
        cpf: 12_212_212_212,
        email: "h@h.com"
      }

      response = CreateOrUpdateUser.call(params)

      expected = {:error, "Invalid parameters"}

      assert response == expected
    end
  end
end
