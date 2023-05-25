defmodule Exlivery.Orders.OrderCreateOrUpdate do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Orders.Agent, as: OrdersAgent
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.CreateOrUpdate

  describe "call/1" do
    setup do
      Exlivery.start_link()
      cpf = "35680025802"

      build(:user, cpf: cpf)
      |> UserAgent.save()

      item1 = build(:item)
      item2 = build(:item)

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when valid params return sucess", %{user_cpf: user_cpf, item1: item1, item2: item2} do
      response = CreateOrUpdate.call(%{user_cpf: user_cpf, items: [item1, item2]})

      assert {:ok, _uuid} = response
    end

    test "when invalid user_cpf return error", %{item1: item1, item2: item2} do
      response = CreateOrUpdate.call(%{user_cpf: "00000000000", items: [item1, item2]})

      expected_response = {:error, "User not found"}
      assert response == expected_response
    end

    test "when invalid item in list return error", %{
      user_cpf: user_cpf,
      item1: item1,
      item2: item2
    } do
      response =
        CreateOrUpdate.call(%{user_cpf: user_cpf, items: [%{item1 | quantity: 0}, item2]})

      expected_response = {:error, "invalid params"}
      assert response == expected_response
    end

    test "when invalid list  return error", %{user_cpf: user_cpf} do
      response = CreateOrUpdate.call(%{user_cpf: user_cpf, items: []})

      expected_response = {:error, "invalid parameter"}
      assert response == expected_response
    end
  end
end
