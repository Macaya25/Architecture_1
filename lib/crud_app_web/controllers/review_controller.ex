defmodule CrudAppWeb.ReviewController do
  use CrudAppWeb, :controller

  alias CrudApp.Library
  alias CrudApp.Library.Review
  alias CrudApp.Cache  # Alias para el manejo de la caché

  def index(conn, _params) do
    reviews = Cachex.fetch!(:cache, "reviews_list", fn ->
      Library.list_reviews()
    end)
    render(conn, :index, reviews: reviews)
  end

  def new(conn, _params) do
    changeset = Library.change_review(%Review{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"review" => review_params}) do
    case Library.create_review(review_params) do
      {:ok, review} ->
        Cachex.clear(:cache)  # Limpia la caché después de crear una reseña
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: ~p"/reviews/#{review}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    review = Cachex.fetch!(:cache, "review_#{id}", fn ->
      Library.get_review!(id) |> Repo.preload(:book)
    end)
    render(conn, :show, review: review)
  end

  def edit(conn, %{"id" => id}) do
    review = Library.get_review!(id)
    changeset = Library.change_review(review)
    render(conn, :edit, review: review, changeset: changeset)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Library.get_review!(id)

    case Library.update_review(review, review_params) do
      {:ok, review} ->
        Cachex.del(:cache, "review_#{id}")  # Invalida la caché cuando se actualiza una reseña
        Cachex.clear(:cache)  # Opción de limpiar toda la caché
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(to: ~p"/reviews/#{review}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, review: review, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Library.get_review!(id)
    {:ok, _review} = Library.delete_review(review)

    Cachex.del(:cache, "review_#{id}")  # Invalida la caché cuando se elimina una reseña
    Cachex.clear(:cache)

    conn
    |> put_flash(:info, "Review deleted successfully.")
    |> redirect(to: ~p"/reviews")
  end
end
