defmodule CrudApp.Library.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :country_of_origin, :string
    field :date_of_birth, :date
    field :description, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :date_of_birth, :country_of_origin, :description])
    |> validate_required([:name, :date_of_birth, :country_of_origin, :description])
  end
end
