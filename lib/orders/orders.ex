defmodule Exlivery.Orders.Order do
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_price(items)
     }}
  end

  def build(_users, _items), do: {:error, "invalid parameter"}

  defp calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_values(&1, &2))
  end

  defp sum_values(%Item{quantity: quantity, unity_price: unity_price}, acc) do
    Decimal.mult(quantity, unity_price)
    |> Decimal.add(acc)
  end

  def build_test() do
    {:ok, user} = User.build("rick", "rick_test@test.co", "123456789", "rua do ba", 20)
    {:ok, item1} = Item.build("produto 1", :pizza, 24.5, 2)
    {:ok, item2} = Item.build("produto 2", :pizza, 5, 2)
    items = [item1, item2]
    build(user, items)
  end
end
