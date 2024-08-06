defmodule CrudApp.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :date_of_publication, :date
    field :name, :string
    field :number_of_sales, :integer
    field :summary, :string

    belongs_to :author, CrudApp.Library.Author
    has_many :reviews, CrudApp.Library.Review
    has_many :sales, CrudApp.Library.Sale

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :summary, :date_of_publication, :number_of_sales, :author_id])
    |> validate_required([:name, :summary, :date_of_publication, :number_of_sales, :author_id])
  end
end
