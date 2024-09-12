defmodule CrudApp.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrudApp.Cache

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

  @doc """
  Creates a changeset for updating the number of sales.
  """
  def update_sales_changeset(book, attrs) do
    book
    |> cast(attrs, [:number_of_sales])
    |> validate_number(:number_of_sales, greater_than_or_equal_to: 0)
  end

  # Hooks for cache purging
  @after_insert :purge_cache
  @after_update :purge_cache
  @after_delete :purge_cache

  defp purge_cache(book) do
    Cachex.del(:cache, "book_#{book.id}")
    Cachex.del(:cache, "author_#{book.author_id}_books")
    Cachex.del(:cache, "top10_books")
    Cachex.del(:cache, "top50_books")
  end
end
