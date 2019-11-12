defmodule GroceryStore.Repo.Migrations.AddIsadminColumnInUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :isadmin, :boolean
      modify :contact, :string
    end
  end
end
