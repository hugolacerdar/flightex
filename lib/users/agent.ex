defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def get_all, do: Agent.get(__MODULE__, &{:ok, &1})

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{id: user_id} = user), do: Map.put(state, user_id, user)
end
