defmodule Exlivery do
  alias Exlivery.Orders.Agent, as: OrderAgente
  alias Exlivery.Users.Agent, as: UserAgente
  alias Exlivery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Exlivery.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_link() do
    UserAgente.start_link(%{})
    OrderAgente.start_link(%{})
  end

  defdelegate createOrUpdateUser(params), to: CreateOrUpdateUser, as: :call

  defdelegate createOrUpdateOrder(params), to: CreateOrUpdateOrder, as: :call
end
