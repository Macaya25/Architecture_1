defmodule CrudApp.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias CrudApp.Repo

  alias CrudApp.Library.Author

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Author{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get_author!(123)
      %Author{}

      iex> get_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id), do: Repo.get!(Author, id)

  @doc """
  Creates a author.

  ## Examples

      iex> create_author(%{field: value})
      {:ok, %Author{}}

      iex> create_author(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a author.

  ## Examples

      iex> update_author(author, %{field: new_value})
      {:ok, %Author{}}

      iex> update_author(author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a author.

  ## Examples

      iex> delete_author(author)
      {:ok, %Author{}}

      iex> delete_author(author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.

  ## Examples

      iex> change_author(author)
      %Ecto.Changeset{data: %Author{}}

  """
  def change_author(%Author{} = author, attrs \\ %{}) do
    Author.changeset(author, attrs)
  end

  alias CrudApp.Library.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end

  alias CrudApp.Library.Review

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    Repo.all(Review)
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id), do: Repo.get!(Review, id)

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.

  ## Examples

      iex> change_review(review)
      %Ecto.Changeset{data: %Review{}}

  """
  def change_review(%Review{} = review, attrs \\ %{}) do
    Review.changeset(review, attrs)
  end

  alias CrudApp.Library.Sale

  @doc """
  Returns the list of sales.

  ## Examples

      iex> list_sales()
      [%Sale{}, ...]

  """
  def list_sales do
    Repo.all(Sale)
  end

  @doc """
  Gets a single sale.

  Raises `Ecto.NoResultsError` if the Sale does not exist.

  ## Examples

      iex> get_sale!(123)
      %Sale{}

      iex> get_sale!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sale!(id), do: Repo.get!(Sale, id)

  @doc """
  Creates a sale.

  ## Examples

      iex> create_sale(%{field: value})
      {:ok, %Sale{}}

      iex> create_sale(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sale(attrs \\ %{}) do
    %Sale{}
    |> Sale.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sale.

  ## Examples

      iex> update_sale(sale, %{field: new_value})
      {:ok, %Sale{}}

      iex> update_sale(sale, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sale(%Sale{} = sale, attrs) do
    sale
    |> Sale.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sale.

  ## Examples

      iex> delete_sale(sale)
      {:ok, %Sale{}}

      iex> delete_sale(sale)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sale(%Sale{} = sale) do
    Repo.delete(sale)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sale changes.

  ## Examples

      iex> change_sale(sale)
      %Ecto.Changeset{data: %Sale{}}

  """
  def change_sale(%Sale{} = sale, attrs \\ %{}) do
    Sale.changeset(sale, attrs)
  end

  def list_authors_with_stats(
    sort \\ "name",
    order \\ "asc",
    name_filter \\ nil,
    min_books \\ 0,
    min_avg_rating \\ Decimal.new("0.0"),
    min_total_sales \\ 0
  ) do
    sort_field = case sort do
      "name" -> :name
      "books_published" -> :book_count
      "avg_rating" -> :avg_rating
      "total_sales" -> :total_sales
      _ -> :name
    end

    order_direction =
      case order do
        "desc" -> :desc
        _ -> :asc
      end

    query =
      from a in Author,
        left_join: b in assoc(a, :books),
        left_join: r in assoc(b, :reviews),
        left_join: s in assoc(b, :sales),
        group_by: a.id,
        having: count(b.id) >= ^min_books and
                coalesce(avg(r.rating), 0) >= ^min_avg_rating and
                coalesce(sum(s.total_sales), 0) >= ^min_total_sales,
        select: %{
          author_id: a.id,
          name: a.name,
          book_count: count(b.id),
          avg_rating: avg(r.rating),
          total_sales: sum(s.total_sales)
        }

    query =
      if name_filter do
        from a in query, where: ilike(a.name, ^"%#{name_filter}%")
      else
        query
      end

    sorted_query =
      from q in subquery(query),
        order_by: [{^order_direction, field(q, ^sort_field)}]

    Repo.all(sorted_query)
  end

  defp order_by_clause(_sort_field, _order_direction, "id") do
    [asc: :id]
  end
  defp order_by_clause(sort_field, order_direction, _order) do
    [{order_direction, sort_field}]
  end


  def list_books_with_filters_paginated(name_filter, page, page_size) do
    # Calculate offset for pagination
    offset = (page - 1) * page_size

    # Define base query with filtering
    base_query = from b in Book,
      where: like(b.name, ^"%#{name_filter}%")

    # Count total number of filtered books
    total_count_query = from b in base_query, select: count(b.id)
    total_count = Repo.one(total_count_query)

    # Fetch paginated results with ordering
    books_query = base_query
    |> order_by([b], asc: b.name)
    |> limit(^page_size)
    |> offset(^offset)

    books = Repo.all(books_query)

    %{books: books, total_count: total_count, page: page, page_size: page_size}
  end



  defp filter_by_name_and_summary(query, nil), do: query
  defp filter_by_name_and_summary(query, name_filter) do
  from b in query, where: ilike(b.name, ^"%#{name_filter}%") or ilike(b.summary, ^"%#{name_filter}%")
  end

  defp filter_by_min_number_of_sales(query, min_number_of_sales) do
  from b in query, where: b.number_of_sales >= ^min_number_of_sales
  end

  defp filter_by_date_range(query, start_date, end_date) do
    from b in query,
      where: b.date_of_publication >= ^start_date and b.date_of_publication <= ^end_date
  end




  defp order_books(query, sort, order) do
    sort_atom =
      case sort do
        "name" -> :name
        "summary" -> :summary
        "date_of_publication" -> :date_of_publication
        "number_of_sales" -> :number_of_sales
        _ -> :name  # Default column
      end

    order_atom =
      case order do
        "asc" -> :asc
        "desc" -> :desc
        _ -> :asc  # Default to `:asc`
      end

    from b in query, order_by: [{^order_atom, field(b, ^sort_atom)}]
  end



  def get_top_books_with_reviews(limit \\ 10) do
    from(b in Book,
      left_join: r in assoc(b, :reviews),
      group_by: b.id,
      order_by: [desc: avg(r.rating)],
      limit: ^limit,
      select: %{
        book: b,
        avg_rating: avg(r.rating),
        best_review: max(r.rating),
        worst_review: min(r.rating)
      }
    )
    |> Repo.all()
    |> Enum.map(&load_reviews(&1))
  end

  defp load_reviews(book_stat) do
    reviews =
      from(r in Review,
        where: r.book_id == ^book_stat.book.id,
        order_by: [desc: r.rating],
        limit: 1
      )
      |> Repo.all()

    best_review = Enum.at(reviews, 0)
    worst_review = Enum.at(reviews, -1)

    Map.put(book_stat, :best_review, best_review)
    |> Map.put(:worst_review, worst_review)
  end

  def get_top_selling_books(limit \\ 50) do
    query =
      from b in Book,
        join: a in assoc(b, :author),
        left_join: s in assoc(b, :sales),
        left_join: sales_by_author in subquery(author_sales_query()),
        on: sales_by_author.author_id == a.id,
        group_by: [b.id, a.id, sales_by_author.total_sales],
        order_by: [desc: sum(s.total_sales)],
        limit: ^limit,
        select: %{
          book: b,
          total_sales: sum(s.total_sales),
          author: a,
          author_total_sales: sales_by_author.total_sales,
          top_5_in_publication_year: fragment("? IN (SELECT bs.book_id FROM (SELECT b.id AS book_id, RANK() OVER (PARTITION BY extract(year from b.date_of_publication) ORDER BY sum(s.total_sales) DESC) AS sales_rank FROM books b JOIN sales s ON s.book_id = b.id WHERE extract(year from b.date_of_publication) = extract(year from ?) GROUP BY b.id) bs WHERE bs.sales_rank <= 5)", b.id, b.date_of_publication)
        }

    Repo.all(query)
  end

  defp author_sales_query do
    from b in Book,
      join: s in assoc(b, :sales),
      group_by: b.author_id,
      select: %{author_id: b.author_id, total_sales: sum(s.total_sales)}
  end
end
