defmodule CrudApp.Library.Review do
  use Ecto.Schema
  import Ecto.Changeset

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
  end
end
