defmodule CrudApp.Content.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :review_text, :string
    field :rating, :integer
    field :upvotes, :integer
    field :book_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:review_text, :rating, :upvotes])
    |> validate_required([:review_text, :rating, :upvotes])
  end
end
