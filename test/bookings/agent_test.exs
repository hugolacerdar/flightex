defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent

  describe "save/1" do
    test "saves the booking" do
      booking = build(:booking)
      BookingAgent.start_link(%{})

      assert BookingAgent.save(booking) == :ok
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link(%{})

      id = "97140d9d-53fa-40af-9057-1f2633f213cc"

      {:ok, id: id}
    end

    test "when the booking is found, returns the booking data", %{id: id} do
      booking = build(:booking, id: id)

      BookingAgent.save(booking)

      response = BookingAgent.get(id)

      expected = {:ok, booking}

      assert response == expected
    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("0000000000000000000")

      expected = {:error, "Booking not found"}

      assert response == expected
    end
  end

  describe "get_all" do
    setup do
      BookingAgent.start_link(%{})

      id1 = "7e7acdf8-03bc-44c3-b0fa-c69321f897f9"
      id2 = "62b578f9-5175-4d40-891f-47c34f59d067"
      {:ok, id1: id1, id2: id2}
    end

    test "returns all bookings", %{id1: id1, id2: id2} do
      booking1 = build(:booking, id: id1, origin_city: "Belo Horizonte")
      booking2 = build(:booking, id: id2, origin_city: "Porto Alegre")

      BookingAgent.save(booking1)
      BookingAgent.save(booking2)

      response = BookingAgent.get_all()

      expected = {:ok, %{id1 => booking1, id2 => booking2}}

      assert response == expected
    end
  end
end
