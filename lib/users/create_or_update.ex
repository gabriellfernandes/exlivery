defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgente
  alias Exlivery.Users.User

  def call(%{name: name, email: email, cpf: cpf, address: address, age: age}) do
    name
    |> User.build(email, cpf, address, age)
    |> save_user()
  end

  defp save_user({:ok, user}) do
    UserAgente.save(user)

    {:ok, "user created or update sucess"}
  end

  defp save_user({:error, _reason} = error), do: error
end
