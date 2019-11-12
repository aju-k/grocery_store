defmodule GroceryStore.Session do
  alias GroceryStore.Repo
  alias GroceryStore.User

  def signin(%{"user_name" => user_name, "crypted_password" => password}) do
    user = Repo.get_by(User, user_name: user_name)
    case authenticate(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  def authenticate(user, password) do
    case user do
      nil -> false
      _ -> user.crypted_password == password
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)

end
