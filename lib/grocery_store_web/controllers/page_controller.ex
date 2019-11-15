defmodule GroceryStoreWeb.PageController do
  use GroceryStoreWeb, :controller
  alias GroceryStore.Chats

  def index(conn, _params) do
    current_user_id = Plug.Conn.get_session(conn, :current_user)
    conversation_list = Chats.conversation_list(current_user_id)
    messages = []
    render conn, "index.html", messages: messages, conversation_list: conversation_list
  end

  def getMessages(conn, params) do
    messages = Chats.list_messages(params["user_id"])
    pretty_json(conn, messages)
  end

  def pretty_json(conn, data) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    encodedValue = to_string(Poison.Encoder.encode(data, []))
    Plug.Conn.send_resp(conn, 200, encodedValue)
  end

end
