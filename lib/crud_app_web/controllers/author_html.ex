defmodule CrudAppWeb.AuthorHTML do
  use CrudAppWeb, :html

  embed_templates "author_html/*"

  @doc """
  Renders a author form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def author_form(assigns)
end
