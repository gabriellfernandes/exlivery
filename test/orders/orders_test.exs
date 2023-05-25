defmodule ExliveryTest.Orders.Order do
  use ExUnit.Case
  alias Exlivery.Orders.Order
  import Exlivery.Factory

  describe "build/2" do
    test "when valid parameters return order" do
      user = build(:user)
      items = build_list(2, :item)

      response = Order.build(user, items)

      expected_reponse = {:ok, build(:order)}

      assert response == expected_reponse
    end

    test "when invalid parameters return error" do
      response = Order.build(%{}, [])

      expected_reponse = {:error, "invalid parameter"}

      assert response == expected_reponse
    end
  end
end
