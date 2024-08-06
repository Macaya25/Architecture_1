defmodule CrudAppWeb.SaleController do
  use CrudAppWeb, :controller

  alias CrudApp.Library
  alias CrudApp.Library.Sale

  def index(conn, _params) do
    sales = Library.list_sales()
    render(conn, :index, sales: sales)
  end

  def new(conn, _params) do
    changeset = Library.change_sale(%Sale{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"sale" => sale_params}) do
    case Library.create_sale(sale_params) do
      {:ok, sale} ->
        conn
        |> put_flash(:info, "Sale created successfully.")
        |> redirect(to: ~p"/sales/#{sale}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sale = Library.get_sale!(id)
    render(conn, :show, sale: sale)
  end

  def edit(conn, %{"id" => id}) do
    sale = Library.get_sale!(id)
    changeset = Library.change_sale(sale)
    render(conn, :edit, sale: sale, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sale" => sale_params}) do
    sale = Library.get_sale!(id)

    case Library.update_sale(sale, sale_params) do
      {:ok, sale} ->
        conn
        |> put_flash(:info, "Sale updated successfully.")
        |> redirect(to: ~p"/sales/#{sale}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, sale: sale, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sale = Library.get_sale!(id)
    {:ok, _sale} = Library.delete_sale(sale)

    conn
    |> put_flash(:info, "Sale deleted successfully.")
    |> redirect(to: ~p"/sales")
  end
end
