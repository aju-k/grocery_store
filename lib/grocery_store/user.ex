defmodule GroceryStore.User do
  use Ecto.Schema

  import Ecto.Changeset

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
    |> cast(params, [:name, :user_name, :password_hex, :contact, :address, :email])
    |> validate_required([
      :name,
      :user_name,
      :password_hex,
      :contact,
      :address,
      :email
    ])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:user_name)
  end
end

