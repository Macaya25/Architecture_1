import Ecto.Query

defmodule CrudAppWeb.BookController do
  use CrudAppWeb, :controller

  alias CrudApp.Library
  alias CrudApp.Library.Book
  alias CrudApp.Repo


  def index(conn, %{"page" => page_param, "page_size" => page_size_param, "name_filter" => name_filter_param}) do
    page =
      case Integer.parse(page_param) do
        {int, _} when int > 0 -> int
        _ -> 1
      end

    page_size =
      case Integer.parse(page_size_param) do
        {int, _} when int > 0 -> int
        _ -> 10
      end

    # Fetch books with the name filter
    books = get_books(page, page_size, name_filter_param)

    # Calculate the next page number
    next_page = page + 1

    # Fetch books for the next page with the same filter
    next_page_books = get_books(next_page, page_size, name_filter_param)

    # Determine if there are elements on the next page
    has_next_page = length(next_page_books) > 0

    render(conn, "index.html", books: books, page: page, page_size: page_size, has_next_page: has_next_page, name_filter: name_filter_param)
  end

  def index(conn, %{"name_filter" => name_filter_param}) do
    # Default values when no page or page_size parameters are provided
    page = 1
    page_size = 10

    # Fetch books with the name filter
    books = get_books(page, page_size, name_filter_param)

    # Calculate the next page number
    next_page = page + 1

    # Fetch books for the next page with the same filter
    next_page_books = get_books(next_page, page_size, name_filter_param)

    # Determine if there are elements on the next page
    has_next_page = length(next_page_books) > 0

    render(conn, "index.html", books: books, page: page, page_size: page_size, has_next_page: has_next_page, name_filter: name_filter_param)
  end

  defp get_books(page, page_size, name_filter) do
    offset = (page - 1) * page_size

    query =
      from b in Book,
        where: ilike(b.name, ^"%#{name_filter}%") or ilike(b.summary, ^"%#{name_filter}%"),
        limit: ^page_size,
        offset: ^offset

    Repo.all(query)
  end


  def new(conn, _params) do
    changeset = Library.change_book(%Book{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case Library.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: ~p"/books/#{book}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    render(conn, :show, book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    changeset = Library.change_book(book)
    render(conn, :edit, book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Library.get_book!(id)

    case Library.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: ~p"/books/#{book}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    {:ok, _book} = Library.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: ~p"/books")
  end

  def top10(conn, _params) do
    top_books = Library.get_top_books_with_reviews(10)
    render(conn, "top10.html", top_books: top_books)
  end

  def top50(conn, _params) do
    top_books = Library.get_top_selling_books(50)
    render(conn, "top50.html", top_books: top_books)
  end
end
