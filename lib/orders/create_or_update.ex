defmodule Exlivery.Orders.CreateOrUpdate do
  alias Exlivery.Orders.Agent, as: OrderAgente
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order
  alias Exlivery.Users.Agent, as: UserAgente

  def call(%{user_cpf: user_cpf, items: items}) do
    with {:ok, user} <-
           UserAgente.get(user_cpf),
         {:ok, items} <-
           build_items(items),
         {:ok, order} <-
           Order.build(user, items) do
      save_order(order)
    end
  end

  defp build_items(items) do
    items
    |> Enum.map(&build_item/1)
    |> handle_build()
  end

  defp build_item(%{
         description: description,
         category: category,
         unity_price: unity_price,
         quantity: quantity
       }) do
    case Item.build(description, category, unity_price, quantity) do
      {:ok, item} -> item
      {:error, _reason} = error -> error
    end
  end

  defp handle_build(items) do
    if(Enum.all?(items, &is_struct/1), do: {:ok, items}, else: {:error, "invalid params"})
  end

  defp save_order(order) do
    OrderAgente.save(order)
  end
end
