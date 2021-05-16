defmodule Flightex.User.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  describe "build/3" do
    test "should build an user when params are valid" do
      response = User.build("Rox", "rox@pox.com", "21232313190")

      assert {:ok, %User{id: _id, name: "Rox", email: "rox@pox.com", cpf: "21232313190"}} =
               response
    end

    test "should return an error when params are invalid" do
      response = User.build("Rox", "rox@pox.com", 21_232_313_190)

      expected = {:error, "Invalid parameters"}

      assert response == expected
    end
  end
end
