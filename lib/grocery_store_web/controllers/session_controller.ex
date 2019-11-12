defmodule GroceryStoreWeb.SessionController do
  use GroceryStoreWeb, :controller
  alias GroceryStore.Session

  def signin(conn, _params) do
    render(conn, "signin.html")
  end

  def login(conn, params) do
    case Session.signin(params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> redirect(to: "/home")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("signin.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end
