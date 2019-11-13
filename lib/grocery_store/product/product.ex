defmodule GroceryStore.Product do
  use Ecto.Schema
  import Ecto.Changeset
  schema "products" do
    field :category, :string
    field :name, :string
    field :price, :integer
    field :quantity, :integer
    field :file, :string
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :category, :price, :quantity, :file])
    |> validate_required([:name, :category, :price, :quantity])
  end
end
