defmodule CrudApp.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :review, :text
      add :rating, :integer
      add :upvotes, :integer
      add :book_id, references(:books, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:reviews, [:book_id])
  end
end
