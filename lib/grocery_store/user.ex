defmodule GroceryStore.User do
  use Ecto.Schema

  schema "users" do
    field(:name, :string)
    field(:user_name, :string)
    field(:password_hex, :string)
    field(:contact, :integer)
    field(:address, :string)
    field(:email, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:name, :user_name, :password_hex, :contact, :address, :email])
    |> Ecto.Changeset.validate_required([
      :name,
      :user_name,
      :password_hex,
      :contact,
      :address,
      :email
    ])
  end
end

