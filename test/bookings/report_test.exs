defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Report

  describe "build/3" do
    test "creates the report file" do
      BookingAgent.start_link(%{})

      :booking
      |> build(date: "2020-12-31 23:59:00", id: UUID.uuid4())
      |> BookingAgent.save()

      :booking
      |> build(date: "2021-01-01 12:00:00", id: UUID.uuid4())
      |> BookingAgent.save()

      :booking
      |> build(date: "2021-01-04 23:59:00", id: UUID.uuid4())
      |> BookingAgent.save()

      :booking
      |> build(date: "2021-01-05 00:00:00", id: UUID.uuid4())
      |> BookingAgent.save()

      start_date = "2021-01-01 00:00:00"
      end_date = "2021-01-05 00:00:00"
      filename = "report_test.csv"

      expected = [
        "c415030b-69e3-4b0c-9507-d4d4e166b481,Sao Paulo,Milano,2021-01-01 12:00:00\n" <>
          "c415030b-69e3-4b0c-9507-d4d4e166b481,Sao Paulo,Milano,2021-01-04 23:59:00\n",
        "c415030b-69e3-4b0c-9507-d4d4e166b481,Sao Paulo,Milano,2021-01-04 23:59:00\n" <>
          "c415030b-69e3-4b0c-9507-d4d4e166b481,Sao Paulo,Milano,2021-01-01 12:00:00\n"
      ]

      Report.build(start_date, end_date, filename)

      response = File.read!(filename)

      assert response in expected
    end
  end
end
