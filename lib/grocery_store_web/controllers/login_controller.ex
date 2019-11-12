defmodule GroceryStoreWeb.LoginController do
  use GroceryStoreWeb, :controller
  alias GroceryStore.User
  alias GroceryStore.Repo

  def signup(conn, _params) do
    user = User.changeset(%User{})
    render(conn, "signup.html", user: user)
  end

  def register(conn, %{"user" => user_params}) do
    changesetObj = User.changeset(%User{}, user_params)
    case Repo.insert(changesetObj) do
      {:ok, user} ->
        conn
        |> put_flash(:info, '#{user.name} created')
        |> redirect(to: login_path(conn, :signup))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Sorry try again")
        |> render("signup.html", user: changeset)
    end
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
