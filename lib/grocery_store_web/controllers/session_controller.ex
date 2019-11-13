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
        |> put_flash(:info, "There was a problem with your username/password")
        |> render("signin.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "You are Logged out.")
    |> redirect(to: "/")
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  # def protected(conn, _params) do
  #   render conn, "index.html"
  # end

  defp authenticate_user(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: session_path(conn, :signin))
      |> halt()
    end
  end

end
