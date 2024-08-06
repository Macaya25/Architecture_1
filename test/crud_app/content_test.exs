defmodule CrudApp.ContentTest do
  use CrudApp.DataCase

  alias CrudApp.Content

  describe "reviews" do
    alias CrudApp.Content.Review

    import CrudApp.ContentFixtures

    @invalid_attrs %{review_text: nil, rating: nil, upvotes: nil}

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Content.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Content.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      valid_attrs = %{review_text: "some review_text", rating: 42, upvotes: 42}

      assert {:ok, %Review{} = review} = Content.create_review(valid_attrs)
      assert review.review_text == "some review_text"
      assert review.rating == 42
      assert review.upvotes == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      update_attrs = %{review_text: "some updated review_text", rating: 43, upvotes: 43}

      assert {:ok, %Review{} = review} = Content.update_review(review, update_attrs)
      assert review.review_text == "some updated review_text"
      assert review.rating == 43
      assert review.upvotes == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_review(review, @invalid_attrs)
      assert review == Content.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Content.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Content.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Content.change_review(review)
    end
  end

  describe "sales" do
    alias CrudApp.Content.Sale

    import CrudApp.ContentFixtures

    @invalid_attrs %{year: nil, sales_count: nil}

    test "list_sales/0 returns all sales" do
      sale = sale_fixture()
      assert Content.list_sales() == [sale]
    end

    test "get_sale!/1 returns the sale with given id" do
      sale = sale_fixture()
      assert Content.get_sale!(sale.id) == sale
    end

    test "create_sale/1 with valid data creates a sale" do
      valid_attrs = %{year: 42, sales_count: 42}

      assert {:ok, %Sale{} = sale} = Content.create_sale(valid_attrs)
      assert sale.year == 42
      assert sale.sales_count == 42
    end

    test "create_sale/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_sale(@invalid_attrs)
    end

    test "update_sale/2 with valid data updates the sale" do
      sale = sale_fixture()
      update_attrs = %{year: 43, sales_count: 43}

      assert {:ok, %Sale{} = sale} = Content.update_sale(sale, update_attrs)
      assert sale.year == 43
      assert sale.sales_count == 43
    end

    test "update_sale/2 with invalid data returns error changeset" do
      sale = sale_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_sale(sale, @invalid_attrs)
      assert sale == Content.get_sale!(sale.id)
    end

    test "delete_sale/1 deletes the sale" do
      sale = sale_fixture()
      assert {:ok, %Sale{}} = Content.delete_sale(sale)
      assert_raise Ecto.NoResultsError, fn -> Content.get_sale!(sale.id) end
    end

    test "change_sale/1 returns a sale changeset" do
      sale = sale_fixture()
      assert %Ecto.Changeset{} = Content.change_sale(sale)
    end
  end
end
