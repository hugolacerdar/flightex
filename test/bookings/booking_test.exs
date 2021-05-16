defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  describe "build/2" do
    test "should build a booking when params are valid" do
      user = build(:user)

      response = Booking.build(user, "2021-10-10 10:10:10", "BH", "BL")

      assert {:ok,
              %Booking{
                date: ~N[2021-10-10 10:10:10],
                destination_city: "BL",
                id: _id,
                origin_city: "BH",
                user_id: "c415030b-69e3-4b0c-9507-d4d4e166b481"
              }} = response
    end

    test "should return an error when param user is not valid" do
      response = Booking.build("banana", "2021-10-10 10:10:10", "BH", "BL")

      expected = {:error, "Invalid parameters"}

      assert response == expected
    end
  end
end
