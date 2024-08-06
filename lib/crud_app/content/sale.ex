defmodule CrudApp.Content.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    field :year, :integer
    field :sales_count, :integer
    field :book_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:year, :sales_count])
    |> validate_required([:year, :sales_count])
  end
end
