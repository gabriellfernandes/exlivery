defmodule Exlivery.Users.Agent do
  use Agent
  alias Exlivery.Users.User

  def start_link(_initValue) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_user(&1, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp update_user(state, %User{cpf: cpf} = user), do: Map.put(state, cpf, user)

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
