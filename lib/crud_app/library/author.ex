defmodule CrudApp.Library.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias CrudApp.Cache

  schema "authors" do
    field :country_of_origin, :string
    field :date_of_birth, :date
    field :description, :string
    field :name, :string

    has_many :books, CrudApp.Library.Book, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :date_of_birth, :country_of_origin, :description])
    |> validate_required([:name, :date_of_birth, :country_of_origin, :description])
  end

  # Hooks for cache purging

  @after_insert :purge_cache
  @after_update :purge_cache
  @after_delete :purge_cache

  defp purge_cache(author) do
    Cachex.del(:cache, "author_#{author.id}")
    Cachex.del(:cache, "authors_list")
    Cachex.clear(:cache)  # Clear all cached entries related to authors and books
  end
end
