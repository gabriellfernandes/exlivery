defmodule ExliveryTest.Orders.Items do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Orders.Item

  describe "build/4" do
    test "when valid parameters return item" do
      response = Item.build("produto 1", :pizza, 24.5, 2)

      expected_reponse = {:ok, build(:item)}

      assert response == expected_reponse
    end

    test "when invalid parameters (category) return error " do
      response = Item.build("produto 1", :batata, 24.5, 1)
      expected_reponse = {:error, "invalid parameters"}

      assert response == expected_reponse
    end

    test "when invalid parameters (quantity) return error " do
      response = Item.build("produto 1", :pizza, 24.5, 0)
      expected_reponse = {:error, "invalid parameters"}

      assert response == expected_reponse
    end

    test "when invalid unity price return error" do
      response = Item.build("produto 1", :pizza, "banana", 2)
      expected_reponse = {:error, "invalid unity price"}

      assert response == expected_reponse
    end
  end
end
