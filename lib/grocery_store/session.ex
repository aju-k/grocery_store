defmodule GroceryStore.Session do
  alias GroceryStore.Repo
  alias GroceryStore.User

  def signin(%{"user_name" => user_name, "password_hex" => password}) do
    user = Repo.get_by(User, user_name: user_name)
    case authenticate(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  def authenticate(user, password) do
    case user do
      nil -> false
      _ -> user.password_hex == password
    end
  end
end
