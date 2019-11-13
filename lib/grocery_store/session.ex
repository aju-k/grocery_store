defmodule GroceryStore.Session do

  @behaviour Plug
  import Plug.Conn
  import Phoenix.Controller

  use GroceryStoreWeb, :controller
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

  def init(opts), do: opts

  def call(conn, _opts) do
    if id = Plug.Conn.get_session(conn, :current_user) do
      current_user = current_user(conn)
      conn
        |> assign(:current_user, current_user)
    else
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: session_path(conn, :signin))
      |> halt()
    end
  end

end
