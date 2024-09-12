defmodule CrudAppWeb.AuthorController do
  use CrudAppWeb, :controller

  alias CrudApp.Library
  alias CrudApp.Library.Author
  alias Cachex

  def index(conn, params) do
    sort = params["sort"] || "name"
    order = params["order"] || "id"
    name_filter = params["name_filter"]
    min_books = params["min_books"] || "0"
    min_avg_rating = params["min_avg_rating"] || "0.0"
    min_total_sales = params["min_total_sales"] || "0"

    authors_with_stats = Cachex.fetch!(:cache, "authors_#{sort}_#{order}_#{name_filter}", fn ->
      Library.list_authors_with_stats(
        sort,
        order,
        name_filter,
        String.to_integer(min_books),
        Decimal.new(min_avg_rating),
        String.to_integer(min_total_sales)
      )
    end)

    render(conn, "index.html",
      authors_with_stats: authors_with_stats,
      name_filter: name_filter,
      min_books: min_books,
      min_avg_rating: min_avg_rating,
      min_total_sales: min_total_sales,
      sort: sort,
      order: order
    )
  end

  def new(conn, _params) do
    changeset = Library.change_author(%Author{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    case Library.create_author(author_params) do
      {:ok, author} ->
        Cachex.clear(:cache)  # Clear the cache when a new author is created
        conn
        |> put_flash(:info, "Author created successfully.")
        |> redirect(to: ~p"/authors/#{author}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Cachex.fetch!(:cache, "author_#{id}", fn ->
      Library.get_author!(id)
    end)

    render(conn, :show, author: author)
  end

  def edit(conn, %{"id" => id}) do
    author = Library.get_author!(id)
    changeset = Library.change_author(author)
    render(conn, :edit, author: author, changeset: changeset)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Library.get_author!(id)

    case Library.update_author(author, author_params) do
      {:ok, author} ->
        Cachex.del(:cache, "author_#{id}")  # Invalidate the cache when an author is updated
        Cachex.clear(:cache)  # Optionally clear the cache
        conn
        |> put_flash(:info, "Author updated successfully.")
        |> redirect(to: ~p"/authors/#{author}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, author: author, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Library.get_author!(id)
    {:ok, _author} = Library.delete_author(author)

    Cachex.del(:cache, "author_#{id}")  # Invalidate the cache when an author is deleted
    Cachex.clear(:cache)

    conn
    |> put_flash(:info, "Author deleted successfully.")
    |> redirect(to: ~p"/authors")
  end
end
