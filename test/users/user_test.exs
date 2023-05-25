defmodule Exlivery.Users.UserTest do
  use ExUnit.Case
  alias Exlivery.Users.User
  import Exlivery.Factory

  describe "build/5" do
    test "when valida prameters return user" do
      respose = User.build("rick", "rick_test@test.co", "123456789", "rua do ba", 20)

      expected_response = {:ok, build(:user)}

      assert respose == expected_response
    end

    test "when invalid prameters return error" do
      respose = User.build("rick", "rick_test@test.co", 123_456_789, "rua do ba", 0)
      expected_response = {:error, "invalid parameters"}

      assert respose == expected_response
    end
  end
end
