defmodule GroceryStoreWeb.ProductController do
    use GroceryStoreWeb, :controller
    
    def index(conn, _params) do
      render conn, "index.html"
    end
  end
  