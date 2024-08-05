defmodule CrudApp.LibraryTest do
  use CrudApp.DataCase

  alias CrudApp.Library

  describe "authors" do
    alias CrudApp.Library.Author

    import CrudApp.LibraryFixtures

    @invalid_attrs %{country_of_origin: nil, date_of_birth: nil, description: nil, name: nil}

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Library.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Library.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{country_of_origin: "some country_of_origin", date_of_birth: ~D[2024-08-04], description: "some description", name: "some name"}

      assert {:ok, %Author{} = author} = Library.create_author(valid_attrs)
      assert author.country_of_origin == "some country_of_origin"
      assert author.date_of_birth == ~D[2024-08-04]
      assert author.description == "some description"
      assert author.name == "some name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      update_attrs = %{country_of_origin: "some updated country_of_origin", date_of_birth: ~D[2024-08-05], description: "some updated description", name: "some updated name"}

      assert {:ok, %Author{} = author} = Library.update_author(author, update_attrs)
      assert author.country_of_origin == "some updated country_of_origin"
      assert author.date_of_birth == ~D[2024-08-05]
      assert author.description == "some updated description"
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_author(author, @invalid_attrs)
      assert author == Library.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Library.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Library.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Library.change_author(author)
    end
  end

  describe "books" do
    alias CrudApp.Library.Book

    import CrudApp.LibraryFixtures

    @invalid_attrs %{date_of_publication: nil, name: nil, number_of_sales: nil, summary: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Library.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Library.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{date_of_publication: ~D[2024-08-04], name: "some name", number_of_sales: 42, summary: "some summary"}

      assert {:ok, %Book{} = book} = Library.create_book(valid_attrs)
      assert book.date_of_publication == ~D[2024-08-04]
      assert book.name == "some name"
      assert book.number_of_sales == 42
      assert book.summary == "some summary"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{date_of_publication: ~D[2024-08-05], name: "some updated name", number_of_sales: 43, summary: "some updated summary"}

      assert {:ok, %Book{} = book} = Library.update_book(book, update_attrs)
      assert book.date_of_publication == ~D[2024-08-05]
      assert book.name == "some updated name"
      assert book.number_of_sales == 43
      assert book.summary == "some updated summary"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_book(book, @invalid_attrs)
      assert book == Library.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Library.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Library.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Library.change_book(book)
    end
  end
end
