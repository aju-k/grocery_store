defmodule GroceryStoreWeb.PrivateRoomChannel do

  use GroceryStoreWeb, :channel
  alias GroceryStore.Chats

  def join("room:lobby", _payload, socket) do
    {:ok, socket}
  end

  def join("room:"<> _private_method_id, _params, _socket) do
    {:error, %{reason: "unauthorised"}}
  end

  def handle_in("shout", payload, socket) do
    Chats.create_message(payload)
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

end
