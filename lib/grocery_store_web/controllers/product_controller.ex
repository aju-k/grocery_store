defmodule GroceryStoreWeb.ProductController do
  use GroceryStoreWeb, :controller
  alias GroceryStore.Product
  alias GroceryStore.Repo


def index(conn, _params) do
  products = Repo.all(Product)
  render(conn, "index.html", products: products)
end

def new(conn, _params) do
  changeset = change_product(%Product{})
  render(conn, "new.html", changeset: changeset)
end

def create(conn, %{"product" => product_params}) do

  trimFileName =  String.replace product_params["name"], " ", ""
  filename = "images/" <> trimFileName <>".jpg"
  map = Map.put(product_params, "file", filename)
  case create_product(map) do
    {:ok, product} ->
      conn
      |> put_flash(:info, "Product created successfully.")
      |> redirect(to: product_path(conn, :show, product))

    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "new.html", changeset: changeset)
  end
end

def show(conn, %{"id" => id}) do
  product = get_product!(id)
  render(conn, "show.html", product: product)
end

def edit(conn, %{"id" => id}) do
  product = get_product!(id)
  changeset = change_product(product)
  render(conn, "edit.html", product: product, changeset: changeset)
end

def update(conn, %{"id" => id, "product" => product_params}) do
  product = get_product!(id)

  case update_product(product, product_params) do
    {:ok, product} ->
      conn
      |> put_flash(:info, "Product updated successfully.")
      |> redirect(to: product_path(conn, :show, product))

    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "edit.html", product: product, changeset: changeset)
  end
end

def delete(conn, %{"id" => id}) do
  product = get_product!(id)
  {:ok, _product} = delete_product(product)

  conn
  |> put_flash(:info, "Product deleted successfully.")
  |> redirect(to: product_path(conn, :index))
end
def change_product(%Product{} = product) do
  Product.changeset(product, %{})
end

def create_product(attrs \\ %{}) do
  %Product{}
  |> Product.changeset(attrs)
  |> Repo.insert()
end

def get_product!(id), do: Repo.get!(Product, id)

def update_product(%Product{} = product, attrs) do
  product
  |> Product.changeset(attrs)
  |> Repo.update()
end

def delete_product(%Product{} = product) do
  Repo.delete(product)
end
end
