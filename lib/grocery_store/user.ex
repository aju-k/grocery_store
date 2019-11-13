defmodule GroceryStore.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:user_name, :string)
    field(:crypted_password, :string)
    field(:contact, :string)
    field(:address, :string)
    field(:email, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :user_name, :crypted_password, :contact, :address, :email])
    |> validate_required([
      :name,
      :user_name,
      :crypted_password,
      :contact,
      :address,
      :email
    ])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:user_name)
    |> downcase_username
  end
  defp downcase_username(changeset) do
    update_change(changeset, :user_name, &String.downcase/1)
  end
end

