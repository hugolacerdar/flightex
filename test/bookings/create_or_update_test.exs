defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser

  describe "call/1" do
    setup do
      BookingAgent.start_link(%{})
      UserAgent.start_link(%{})

      user_id = "c415030b-69e3-4b0c-9507-d4d4e166b491"

      user = build(:user, id: user_id)

      UserAgent.save(user)
      {:ok, user_id: user_id}
    end

    test "when all params are valid, saves the booking", %{user_id: user_id} do
      params = %{
        user_id: user_id,
        date: "2022-01-01 10:01:00",
        origin_city: "Berlin",
        destination_city: "Barcelona"
      }

      response = CreateOrUpdateBooking.call(params)

      expected = {:ok, "Booking created successfully"}

      assert response == expected
    end

    test "when any param is valid, returns an error" do
      params = %{
        user_id: "000000000000",
        date: "2022-01-01 10:01:00",
        origin_city: "Berlin",
        destination_city: "Barcelona"
      }

      response = CreateOrUpdateBooking.call(params)

      expected = {:error, "User not found"}

      assert response == expected
    end
  end
end
