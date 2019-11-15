defmodule GroceryStore.Chats do
  import Ecto.Query, warn: false
  alias GroceryStore.Repo
  alias GroceryStore.Chats.Message
  alias GroceryStore.User

  def list_messages(user_id) do
    query = from m in Message, where: m.sender_id == ^user_id or m.receiver_id == ^user_id, select: %{id: m.id, body: m.body, sender_id: m.sender_id}
    Repo.all(query)
  end

  # def list_conversation(user_id) do
  #   user_query = from u in User, order_by: [desc: u.id], select: u.name
  #   query = from m in Message, where: m.sender_id == ^user_id, order_by: [desc: m.id], preload: [user: ^user_query]
  #   #query = from m in Message, where: m.sender_id == ^user_id, preload: [:user]
  #   messagesList = Repo.all(query)
  #   resp_map = %{}

  #   resp = Enum.map(messagesList, fn message ->
  #     if Map.has_key?(resp_map, message.user) do
  #       Map.put(resp_map, message.user, message)
  #     end

  #   end)
  # end

  def conversation_list(user_id) do
    rawQuery = "SELECT * FROM
                  (SELECT max(id) message_id, receiver_id as user_id FROM messages WHERE sender_id = #{user_id} group by receiver_id
               UNION distinct
                  (SELECT max(id) message_id, sender_id as user_id FROM messages WHERE receiver_id = #{user_id} group by sender_id)) t1
              INNER JOIN users on users.id = t1.user_id
              INNER JOIN messages on messages.id = t1.message_id";

    resultSet = Ecto.Adapters.SQL.query!(Repo, rawQuery, [])
    columns = Enum.map resultSet.columns, &(String.to_atom(&1))
    Enum.map resultSet.rows, fn(row) ->
      IO.inspect(row)
     Map.new(Enum.zip(columns, row))
    end
  end

  def get_message!(id), do: Repo.get!(Message, id)

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  def change_message(%Message{} = message) do
    Message.changeset(message, %{})
  end
end
