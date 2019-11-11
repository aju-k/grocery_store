defmodule GroceryStore.Repo.Migrations.CreateTableChat do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string
      add :body, :text
      add :sender_id, :integer
      add :receiver_id, :integer

      timestamps()
    end

  end
end
