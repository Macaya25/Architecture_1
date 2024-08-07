defmodule CrudAppWeb.AuthorHTML do
  use CrudAppWeb, :html

  embed_templates "author_html/*"

  @doc """
  Renders a author form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def author_form(assigns)

  defp link_with_order(label, field, current_sort, current_order) do
    new_order = 
      if current_sort == field do
        case current_order do
          "asc" -> "desc"
          "desc" -> "id"
          _ -> "asc"
        end
      else
        "asc"
      end

    arrow = if current_sort == field, do: order_indicator(current_order), else: ""

    raw("<a href=\"?sort=#{field}&order=#{new_order}\">#{label} #{arrow}</a>")
  end

  defp order_indicator("asc"), do: "↑"
  defp order_indicator("desc"), do: "↓"
  defp order_indicator("id"), do: "↔"
  defp order_indicator(_), do: ""
end
