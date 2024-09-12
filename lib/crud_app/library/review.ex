defmodule CrudApp.Library.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrudApp.Cache

  schema "reviews" do
    field :review, :string
    field :rating, :integer
    field :upvotes, :integer

    belongs_to :book, CrudApp.Library.Book

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:review, :rating, :upvotes, :book_id])
    |> validate_required([:review, :rating, :upvotes, :book_id])
    |> validate_inclusion(:rating, 1..5)
    |> validate_number(:upvotes, greater_than_or_equal_to: 0)
  end

  # Hooks for cache purging
  @after_insert :purge_cache
  @after_update :purge_cache
  @after_delete :purge_cache

  defp purge_cache(review) do
    Cachex.del(:cache, "book_#{review.book_id}_reviews")
    Cachex.del(:cache, "top10_books")
  end
end
