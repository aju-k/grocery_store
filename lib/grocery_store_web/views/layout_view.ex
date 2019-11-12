defmodule GroceryStoreWeb.LayoutView do
  import GroceryStore.Session, only: [current_user: 1, logged_in?: 1]
  use GroceryStoreWeb, :view

end
