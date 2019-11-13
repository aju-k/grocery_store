defmodule GroceryStore.Repo.Migrations.CreateTableUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :user_name, :string
      add :password_hex, :string
      add :contact, :integer
      add :address, :string
      add :email, :string
    end
  end
end
