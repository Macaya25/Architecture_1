defmodule CrudAppWeb.AuthorController do
  use CrudAppWeb, :controller

  alias CrudApp.Library
  alias CrudApp.Library.Author

   def index(conn, params) do
    sort = params["sort"] || "name"
    name_filter = params["name_filter"]
    min_books = params["min_books"] || "0"

    authors_with_stats = Library.list_authors_with_stats(sort, name_filter, String.to_integer(min_books))
    render(conn, "index.html", authors_with_stats: authors_with_stats, name_filter: name_filter, min_books: min_books)
  end

  def new(conn, _params) do
    changeset = Library.change_author(%Author{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    case Library.create_author(author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "Author created successfully.")
        |> redirect(to: ~p"/authors/#{author}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Library.get_author!(id)
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

    conn
    |> put_flash(:info, "Author deleted successfully.")
    |> redirect(to: ~p"/authors")
  end
end
