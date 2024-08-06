defmodule CrudApp.Library.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    field :year, :integer
    field :total_sales, :integer
    field :book_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:year, :total_sales])
    |> validate_required([:year, :total_sales])
  end
end
