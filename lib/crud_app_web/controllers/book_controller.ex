defmodule CrudAppWeb.BookController do
  use CrudAppWeb, :controller

  alias CrudApp.Library
  alias CrudApp.Library.Book

  def index(conn, params) do
    sort = params["sort"] || "name"
    order = params["order"] || "asc"
    name_filter = params["name_filter"]
    min_number_of_sales = params["min_number_of_sales"] || "0"
    start_date = params["start_date"] || "0000-01-01"
    end_date = params["end_date"] || Date.to_string(Date.utc_today())

    books_with_filters = Library.list_books_with_filters(
      sort,
      order,
      name_filter,
      String.to_integer(min_number_of_sales),
      Date.from_iso8601!(start_date),
      Date.from_iso8601!(end_date)
    )

    render(conn, "index.html",
      books: books_with_filters,
      name_filter: name_filter,
      min_number_of_sales: min_number_of_sales,
      start_date: start_date,
      end_date: end_date,
      sort: sort,
      order: order
    )
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
