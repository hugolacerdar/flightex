defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  def get_all, do: Agent.get(__MODULE__, &{:ok, &1})

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %Booking{id: booking_id} = booking) do
    Map.put(state, booking_id, booking)
  end
end
