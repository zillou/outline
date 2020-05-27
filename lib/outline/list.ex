defmodule Outline.List do
  alias Outline.Repo
  alias Outline.List.Item

  def create_item(parent, item_attrs) do
  end

  def update_item(item, item_attrs) do
    item
    |> Item.changeset(item_attrs)
    |> Repo.update()
  end
end
