defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      cpf: "22122122112",
      email: "hugo@hugo.com",
      id: "c415030b-69e3-4b0c-9507-d4d4e166b481",
      name: "Hugo"
    }
  end

  def booking_factory do
    %Booking{
      date: ~N[2022-12-12 12:00:00],
      destination_city: "Milano",
      id: "d8fd8313-0caa-4218-84e3-b5fe68c026cf",
      origin_city: "Sao Paulo",
      user_id: "c415030b-69e3-4b0c-9507-d4d4e166b481"
    }
  end
end
