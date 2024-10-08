defmodule CrudApp.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CrudApp.Library` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        country_of_origin: "some country_of_origin",
        date_of_birth: ~D[2024-08-04],
        description: "some description",
        name: "some name"
      })
      |> CrudApp.Library.create_author()

    author
  end

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        date_of_publication: ~D[2024-08-04],
        name: "some name",
        number_of_sales: 42,
        summary: "some summary"
      })
      |> CrudApp.Library.create_book()

    book
  end

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    {:ok, review} =
      attrs
      |> Enum.into(%{
        rating: 42,
        review: "some review",
        upvotes: 42
      })
      |> CrudApp.Library.create_review()

    review
  end

  @doc """
  Generate a sale.
  """
  def sale_fixture(attrs \\ %{}) do
    {:ok, sale} =
      attrs
      |> Enum.into(%{
        total_sales: 42,
        year: 42
      })
      |> CrudApp.Library.create_sale()

    sale
  end
end
