defmodule Exlivery.Users.UserCreateOrUpdate do
  use ExUnit.Case
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when valid params return sucess" do
      params = %{
        name: "rick",
        email: "rick@tekoa.com",
        cpf: "35680025802",
        address: "rua benedito",
        age: 23
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "user created or update sucess"}
      assert response == expected_response
    end

    test "when invalid params return error" do
      params = %{
        name: "rick",
        email: "rick@tekoa.com",
        cpf: "35680025802",
        address: "rua benedito",
        age: 2
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "invalid parameters"}

      assert response == expected_response
    end
  end
end
