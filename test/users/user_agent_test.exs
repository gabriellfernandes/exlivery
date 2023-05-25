defmodule Exlivery.Users.UserAgentTest do
  use ExUnit.Case
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User
  import Exlivery.Factory

  describe "save/1" do
    test "when valid user return ok" do
      UserAgent.start_link(%{})
      respose = build(:user) |> UserAgent.save()

      expected_response = :ok

      assert respose == expected_response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when valid cpf return user" do
      :user
      |> build(cpf: "35680025802")
      |> UserAgent.save()

      response = UserAgent.get("35680025802")

      expected_response =
        {:ok,
         %User{
           address: "rua do ba",
           age: 20,
           cpf: "35680025802",
           email: "rick_test@test.co",
           name: "rick"
         }}

      assert response == expected_response
    end

    test "when invalid cpf return error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
