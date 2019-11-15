defmodule GroceryStore.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias GroceryStore.User

  schema "messages" do
    field :body, :string
    field :name, :string
    field :sender_id, :integer
    #field :receiver_id, :integer
    # belongs_to(name, queryable, opts \\ [])
    belongs_to :user, User, foreign_key: :receiver_id, references: :id
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :body, :sender_id, :receiver_id])
    |> validate_required([:body, :sender_id])
  end
end
