defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgente
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  def create(file_name \\ "report.csv") do
    order_list = build_order_list()
    File.write(file_name, order_list)
  end

  defp build_order_list() do
    OrderAgente.get_all()
    |> Map.values()
    |> Enum.map(&order_list_string/1)
  end

  defp order_list_string(%Order{user_cpf: cpf, items: items, total_price: total_price}) do
    item = Enum.map(items, &item_list_string/1)
    "#{cpf},#{item}#{total_price}\n"
  end

  defp item_list_string(%Item{category: category, unity_price: unity_price, quantity: quantity}) do
    "#{category},#{unity_price},#{quantity},"
  end
end
