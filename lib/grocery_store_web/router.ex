defmodule GroceryStoreWeb.Router do
  use GroceryStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug GroceryStore.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GroceryStoreWeb do
    pipe_through :browser # Use the default browser stack

    get "/signup", LoginController, :signup
    post "/register", LoginController, :register
    get "/signin", SessionController, :signin
    post "/login", SessionController, :login
    get "/home", HomeController, :index
    get "/", HomeController, :index

  end

  scope "/", GroceryStoreWeb do
    pipe_through [:browser, GroceryStore.Session]
    delete "/logout", SessionController, :delete
    resources "/products", ProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GroceryStoreWeb do
  #   pipe_through :api
  # end
end
