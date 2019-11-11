defmodule GroceryStore.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset


  schema "messages" do
    field :body, :string
    field :name, :string
    field :sender_id, :integer
    field :receiver_id, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
