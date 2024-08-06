# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CrudApp.Repo.insert!(%CrudApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Faker.start()

alias CrudApp.Repo
alias CrudApp.Library.{Author, Book, Review, Sale}

excluded_fields = [:__meta__, :__struct__, :id]

current_time = DateTime.utc_now() |> DateTime.truncate(:second)

authors = for _ <- 1..50 do
  %Author{}
  |> Author.changeset(%{
    name: Faker.Person.name(),
    date_of_birth: Faker.Date.between(~D[1950-01-01], ~D[2003-12-31]),
    country_of_origin: Faker.Address.country(),
    description: Faker.Lorem.paragraph()
  })
  |> Ecto.Changeset.apply_changes()
  |> Map.from_struct()
  |> Map.drop(excluded_fields)
  |> Map.put(:inserted_at, current_time)
  |> Map.put(:updated_at, current_time)
end

Repo.insert_all(Author, authors)

books = for author <- Repo.all(Author) do
  for _ <- 1..6 do  # Aproximadamente 6 libros por autor para llegar a 300 libros
    %Book{}
    |> Book.changeset(%{
      name: Faker.Lorem.sentence(),  # Alternativa a Faker.Book.title()
      summary: Faker.Lorem.paragraphs(1..3) |> Enum.join(" "),
      date_of_publication: Faker.Date.backward(1000),
      number_of_sales: Enum.random(0..10000),
      author_id: author.id
    })
    |> Ecto.Changeset.apply_changes()
    |> Map.from_struct()
    |> Map.drop(excluded_fields)
    |> Map.put(:inserted_at, current_time)
    |> Map.put(:updated_at, current_time)
  end
end |> List.flatten()

Repo.insert_all(Book, books)

for book <- Repo.all(Book) do
  reviews = for _ <- 1..10 do
    %Review{}
    |> Review.changeset(%{
      book_id: book.id,
      review: Faker.Lorem.sentences(2..5) |> Enum.join(" "),
      rating: Enum.random(1..5),
      upvotes: Enum.random(0..100)
    })
    |> Ecto.Changeset.apply_changes()
    |> Map.from_struct()
    |> Map.drop(excluded_fields)
    |> Map.put(:inserted_at, current_time)
    |> Map.put(:updated_at, current_time)
  end
  Repo.insert_all(Review, reviews)
end

for book <- Repo.all(Book) do
  sales = for year <- Enum.to_list(Date.utc_today().year - 5..Date.utc_today().year) do
    %Sale{}
    |> Sale.changeset(%{
      book_id: book.id,
      year: year,
      total_sales: Enum.random(0..1000)
    })
    |> Ecto.Changeset.apply_changes()
    |> Map.from_struct()
    |> Map.drop(excluded_fields)
    |> Map.put(:inserted_at, current_time)
    |> Map.put(:updated_at, current_time)
  end
  Repo.insert_all(Sale, sales)
end
