defmodule GroceryStoreWeb.LoginController do
  use GroceryStoreWeb, :controller
  alias GroceryStore.User
  alias GroceryStore.Repo

  def signup(conn, _params) do
    user = User.changeset(%User{})
    render(conn, "signup.html", user: user)
  end

  def register(conn, %{"user" => user_params}) do
    # IO.inspect(user_params)
    userObj = User.changeset(%User{}, user_params)
    {:ok, user} = Repo.insert(userObj)

    conn
    |> put_flash(:info, '#{user.name} created')
    |> redirect(to: login_path(conn, :signup))
  end


  def index(conn, _params) do
    render(conn, "index.html")
  end
end
