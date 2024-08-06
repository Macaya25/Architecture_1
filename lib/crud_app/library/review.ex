defmodule CrudApp.Library.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :review, :string
    field :rating, :integer
    field :upvotes, :integer
    field :book_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:review, :rating, :upvotes])
    |> validate_required([:review, :rating, :upvotes])
  end
end
