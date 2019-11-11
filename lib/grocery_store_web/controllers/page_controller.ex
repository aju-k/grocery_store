defmodule GroceryStoreWeb.PageController do
  use GroceryStoreWeb, :controller

  alias GroceryStore.Chats

  def index(conn, _params) do
    messages = Chats.list_messages()
    render conn, "index.html", messages: messages
  end
end
