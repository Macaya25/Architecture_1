defmodule CrudAppWeb.AuthorControllerTest do
  use CrudAppWeb.ConnCase

  import CrudApp.LibraryFixtures

  @create_attrs %{country_of_origin: "some country_of_origin", date_of_birth: ~D[2024-08-04], description: "some description", name: "some name"}
  @update_attrs %{country_of_origin: "some updated country_of_origin", date_of_birth: ~D[2024-08-05], description: "some updated description", name: "some updated name"}
  @invalid_attrs %{country_of_origin: nil, date_of_birth: nil, description: nil, name: nil}

  describe "index" do
    test "lists all authors", %{conn: conn} do
      conn = get(conn, ~p"/authors")
      assert html_response(conn, 200) =~ "Listing Authors"
    end
  end

  describe "new author" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/authors/new")
      assert html_response(conn, 200) =~ "New Author"
    end
  end

  describe "create author" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/authors", author: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/authors/#{id}"

      conn = get(conn, ~p"/authors/#{id}")
      assert html_response(conn, 200) =~ "Author #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/authors", author: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Author"
    end
  end

  describe "edit author" do
    setup [:create_author]

    test "renders form for editing chosen author", %{conn: conn, author: author} do
      conn = get(conn, ~p"/authors/#{author}/edit")
      assert html_response(conn, 200) =~ "Edit Author"
    end
  end

  describe "update author" do
    setup [:create_author]

    test "redirects when data is valid", %{conn: conn, author: author} do
      conn = put(conn, ~p"/authors/#{author}", author: @update_attrs)
      assert redirected_to(conn) == ~p"/authors/#{author}"

      conn = get(conn, ~p"/authors/#{author}")
      assert html_response(conn, 200) =~ "some updated country_of_origin"
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      conn = put(conn, ~p"/authors/#{author}", author: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Author"
    end
  end

  describe "delete author" do
    setup [:create_author]

    test "deletes chosen author", %{conn: conn, author: author} do
      conn = delete(conn, ~p"/authors/#{author}")
      assert redirected_to(conn) == ~p"/authors"

      assert_error_sent 404, fn ->
        get(conn, ~p"/authors/#{author}")
      end
    end
  end

  defp create_author(_) do
    author = author_fixture()
    %{author: author}
  end
end
