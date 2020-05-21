defmodule Outline.List.ItemTree do
  import Ecto.Query

  alias Outline.Repo
  alias Outline.List.Item
  alias Outline.Accounts.User

  def build(%User{} = user, root_id \\ nil) do
    item_tree_query(user, root_id)
    |> Repo.all()
    |> build_tree_from_adjacency_list(root_id)
  end

  defp build_tree_from_adjacency_list(list, root_id) do
    parent_map =
      Enum.reduce(list, %{}, fn %{parent_id: parent_id} = node, map ->
        update_in(map, [parent_id], fn
          nil -> [node]
          children -> [node | children]
        end)
      end)

    fill_children(parent_map[root_id], parent_map)
  end

  defp fill_children(roots, parent_map) do
    Enum.map(roots, fn node -> %{node | children: find_child(node, parent_map)} end)
  end

  defp find_child(node, parent_map) do
    case Map.get(parent_map, node.id) do
      nil -> []
      children -> fill_children(children, parent_map)
    end
  end

  def item_tree_query(user, root_id) do
    item_tree_recursion_query =
      from(item in user_items(user), join: it in "item_tree", on: it.id == item.parent_id)

    sub = union_all(root_items_query(user, root_id), ^item_tree_recursion_query)

    {"item_tree", Item}
    |> with_cte("item_tree", as: ^sub)
    |> recursive_ctes(true)
    |> order_by(asc_nulls_first: :parent_id)
  end

  defp root_items_query(user, nil) do
    from(item in user_items(user), where: is_nil(item.parent_id))
  end
  defp root_items_query(user, root_id) do
    from(item in user_items(user), where: item.id == ^root_id)
  end

  defp user_items(user), do: Ecto.assoc(user, :items)
end

