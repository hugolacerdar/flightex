defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def build(start_date, end_date, filename \\ "report.csv") do
    booking_list = build_booking_list(start_date, end_date)

    File.write(filename, booking_list)
  end

  defp build_booking_list(start_date, end_date) do
    {:ok, bookings} = BookingAgent.get_all()

    bookings
    |> Map.values()
    |> Stream.filter(fn %{date: date} -> compare_date(date, start_date, end_date) end)
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         date: date,
         origin_city: origin_city,
         destination_city: destination_city,
         user_id: user_id
       }) do
    "#{user_id},#{origin_city},#{destination_city},#{date}\n"
  end

  defp compare_date(date, start_date, end_date) do
    date = NaiveDateTime.from_iso8601!(date)
    starting = NaiveDateTime.from_iso8601!(start_date)
    ending = NaiveDateTime.from_iso8601!(end_date)

    with :gt <- NaiveDateTime.compare(date, starting),
         :lt <- NaiveDateTime.compare(date, ending) do
      true
    else
      _ -> false
    end
  end
end
