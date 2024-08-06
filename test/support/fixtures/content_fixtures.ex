defmodule CrudApp.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CrudApp.Content` context.
  """

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    {:ok, review} =
      attrs
      |> Enum.into(%{
        rating: 42,
        review_text: "some review_text",
        upvotes: 42
      })
      |> CrudApp.Content.create_review()

    review
  end

  @doc """
  Generate a sale.
  """
  def sale_fixture(attrs \\ %{}) do
    {:ok, sale} =
      attrs
      |> Enum.into(%{
        sales_count: 42,
        year: 42
      })
      |> CrudApp.Content.create_sale()

    sale
  end
end
