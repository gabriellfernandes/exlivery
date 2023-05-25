defmodule Exlivery.Orders.OrderAgentTest do
  use ExUnit.Case
  alias Exlivery.Orders.Agent, as: OrderAgent
  import Exlivery.Factory

  describe "save/1" do
    test "when valid user return ok" do
      OrderAgent.start_link(%{})
      respose = build(:order) |> OrderAgent.save()

      assert {:ok, _uuid} = respose
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "when valid id return order" do
      order = build(:order)

      {:ok, uuid} =
        order
        |> OrderAgent.save()

      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response == expected_response
    end

    test "when invalid cpf return error" do
      response = OrderAgent.get("00000000000")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
