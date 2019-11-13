defmodule GroceryStore.Repo.Migrations.CreateProductTable do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :category, :string
      add :price, :integer
      add :quantity, :integer
      add :file, :string
    end
  end
end
