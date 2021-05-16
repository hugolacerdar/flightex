defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.User

  @keys [:id, :date, :origin_city, :destination_city, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{id: user_id}, date, origin_city, destination_city) do
    id = UUID.uuid4()

    {:ok, naive_dt} = NaiveDateTime.from_iso8601(date)

    {:ok,
     %__MODULE__{
       id: id,
       date: naive_dt,
       origin_city: origin_city,
       destination_city: destination_city,
       user_id: user_id
     }}
  end

  def build(_user, _date, _origin_city, _destination_city), do: {:error, "Invalid parameters"}
end
