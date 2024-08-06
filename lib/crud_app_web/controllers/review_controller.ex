defmodule CrudAppWeb.ReviewController do
  use CrudAppWeb, :controller

  alias CrudApp.Content
  alias CrudApp.Content.Review

  def index(conn, _params) do
    reviews = Content.list_reviews()
    render(conn, :index, reviews: reviews)
  end

  def new(conn, _params) do
    changeset = Content.change_review(%Review{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"review" => review_params}) do
    case Content.create_review(review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review created successfully.")
        |> redirect(to: ~p"/reviews/#{review}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    review = Content.get_review!(id)
    render(conn, :show, review: review)
  end

  def edit(conn, %{"id" => id}) do
    review = Content.get_review!(id)
    changeset = Content.change_review(review)
    render(conn, :edit, review: review, changeset: changeset)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = Content.get_review!(id)

    case Content.update_review(review, review_params) do
      {:ok, review} ->
        conn
        |> put_flash(:info, "Review updated successfully.")
        |> redirect(to: ~p"/reviews/#{review}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, review: review, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = Content.get_review!(id)
    {:ok, _review} = Content.delete_review(review)

    conn
    |> put_flash(:info, "Review deleted successfully.")
    |> redirect(to: ~p"/reviews")
  end
end
