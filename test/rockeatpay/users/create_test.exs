defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Samuel",
        password: "123456",
        nickname: "SamuelLima",
        email: "samusamu@gmail.com",
        age: 23
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Samuel", age: 23, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Samuel",
        nickname: "SamuelLima",
        email: "samusamu@gmail.com",
        age: 23
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{password: ["can't be blank"]}
      assert expected_response == errors_on(changeset)
    end
  end
end
