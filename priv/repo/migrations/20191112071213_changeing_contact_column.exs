defmodule GroceryStore.Repo.Migrations.ChangeingContactColumn do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :password_hex, :string
    end
    rename table(:users), :password_hex, to: :crypted_password
  end
end


