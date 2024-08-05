defmodule CrudApp.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :date_of_publication, :date
    field :name, :string
    field :number_of_sales, :integer
    field :summary, :string
    field :author_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :summary, :date_of_publication, :number_of_sales])
    |> validate_required([:name, :summary, :date_of_publication, :number_of_sales])
  end
end
