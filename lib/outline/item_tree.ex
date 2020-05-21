defmodule Outline.List.ItemTree do
  import Ecto.Query

  alias Outline.Repo
  alias Outline.List.Item
  alias Outline.Accounts.User

  def build(%User{} = user, root_id \\ nil) do
    item_tree_query(user, root_id)
    |> Repo.all()
    # TODO: build a elixir tree from the adjacency list
  end

  def item_tree_query(user, root_id) do
    item_tree_recursion_query =
      from(item in user_items(user), join: it in "item_tree", on: it.id == item.parent_id)

    sub = union_all(root_items_query(user, root_id), ^item_tree_recursion_query)

    {"item_tree", Item}
    |> with_cte("item_tree", as: ^sub)
    |> recursive_ctes(true)
  end

  defp root_items_query(user, nil) do
    from(item in user_items(user), where: is_nil(item.parent_id))
  end
  defp root_items_query(user, root_id) do
    from(item in user_items(user), where: item.id == ^root_id)
  end

  defp user_items(user), do: Ecto.assoc(user, :items)
end

