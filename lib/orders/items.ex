defmodule Exlivery.Orders.Item do
  @categorys [:humburguer, :pizza, :prato_feito, :sorvete, :japonesa]
  @keys [:description, :category, :unity_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unity_price, quantity)
      when quantity > 0 and category in @categorys do
    unity_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  defp build_item({:ok, unity_price}, description, category, quantity) do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unity_price: unity_price,
       quantity: quantity
     }}
  end

  defp build_item(:error, _description, _category, _quantity), do: {:error, "invalid unity price"}

  def build(_description, _category, _unity_price, _quantity), do: {:error, "invalid parameters"}
end
