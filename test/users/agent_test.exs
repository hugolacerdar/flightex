defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  describe "save/1" do
    test "saves the user" do
      user = build(:user)
      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      id = "97140d9d-53fa-40af-9057-1f2633f213cc"

      {:ok, id: id}
    end

    test "when the user is found, returns the user data", %{id: id} do
      user = build(:user, id: id)

      UserAgent.save(user)

      response = UserAgent.get(id)

      expected = {:ok, user}

      assert response == expected
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("0000000000000000000")

      expected = {:error, "User not found"}

      assert response == expected
    end
  end

  describe "get_all" do
    setup do
      UserAgent.start_link(%{})

      id1 = "7e7acdf8-03bc-44c3-b0fa-c69321f897f9"
      id2 = "62b578f9-5175-4d40-891f-47c34f59d067"
      {:ok, id1: id1, id2: id2}
    end

    test "returns all users", %{id1: id1, id2: id2} do
      user1 = build(:user, id: id1, name: "Bnb")
      user2 = build(:user, id: id2, name: "Cnc")

      UserAgent.save(user1)
      UserAgent.save(user2)

      response = UserAgent.get_all()

      expected = {:ok, %{id1 => user1, id2 => user2}}

      assert response == expected
    end
  end
end
