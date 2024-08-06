defmodule CrudApp.Library.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    field :year, :integer
    field :total_sales, :integer

    belongs_to :book, CrudApp.Library.Book

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:year, :total_sales, :book_id])
    |> validate_required([:year, :total_sales, :book_id])
  end
end
