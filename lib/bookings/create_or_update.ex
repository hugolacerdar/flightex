defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(%{
        user_id: user_id,
        date: date,
        origin_city: origin_city,
        destination_city: destination_city
      }) do
    with {:ok, user} <- UserAgent.get(user_id),
         {:ok, booking} <- Booking.build(user, date, origin_city, destination_city) do
      BookingAgent.save(booking)

      {:ok, "Booking created successfully"}
    else
      error -> error
    end
  end
end
