defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "rua do ba",
      age: 20,
      cpf: "123456789",
      email: "rick_test@test.co",
      name: "rick"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "produto 1",
      quantity: 2,
      unity_price: Decimal.new("24.5")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "rua do ba",
      items: build_list(2, :item),
      total_price: Decimal.new("98.00"),
      user_cpf: "123456789"
    }
  end
end
