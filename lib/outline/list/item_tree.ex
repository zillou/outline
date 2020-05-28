defmodule Outline.List.ItemTree do
  import Ecto.Query

  alias Outline.Repo
  alias Outline.List.Item
  alias Outline.Accounts.User

  @doc """
  Loads given user's items and build up an N-ary tree.

  When root id is nil, all users list items will be loaded;
  when non-nil root id is specified, only the root node and its descendants will be loaded.

  ## Examples

      iex> Outline.List.ItemTree.build(user, nil)
      [
        %Outline.ListItem{
          id: 1,
          children: [
            %Outline.ListItem{
              id: 2
              children: []
              ...
            }
          ]
          ...
        }
        %Outline.ListItem{
          id: 3,
          children: []
          ...
        }
      ]
      iex> Outline.List.ItemTree.build(user, 1)
      [
        %Outline.ListItem{
          id: 1,
          children: [
            %Outline.ListItem{
              id: 2
              children: []
              ...
            }
          ]
          ...
        }
      ]
      iex> Outline.List.ItemTree.build(user, 5)
      []
  """
  def build(%User{} = user, root_id \\ nil) do
    # select over the subquery is to make sure the source the loaded records are
    # `items` instead of `item_tree`
    (from i in Item, where: i.id in subquery(item_tree_query(user, root_id)))
    |> order_by(asc_nulls_first: :parent_id)
    |> Repo.all()
    |> build_tree_from_adjacency_list(root_id)
  end

  def build_tree_from_adjacency_list(list, root_id) do
    parent_node_map = Enum.group_by(list, & &1.parent_id)
    root_nodes = Map.get(parent_node_map, root_id, [])
    lookup_children_for_nodes(root_nodes, parent_node_map)
  end

  defp lookup_children_for_nodes(roots, parent_map) do
    Enum.map(roots, fn node ->
      %{node | children: lookup_children(node, parent_map)}
    end)
  end

  defp lookup_children(node, parent_map) do
    case Map.get(parent_map, node.id) do
      nil -> []
      children -> lookup_children_for_nodes(children, parent_map)
    end
  end

  def item_tree_query(user, root_id) do
    item_tree_recursion_query =
      from(item in user_items(user),
        join: it in "item_tree", on: it.id == item.parent_id)

    cte = union_all(root_items_query(user, root_id), ^item_tree_recursion_query)

    {"item_tree", Item}
    |> with_cte("item_tree", as: ^cte)
    |> recursive_ctes(true)
    |> select([i], i.id)
  end

  defp root_items_query(user, nil) do
    from(item in user_items(user), where: is_nil(item.parent_id))
  end
  defp root_items_query(user, root_id) do
    from(item in user_items(user), where: item.id == ^root_id)
  end

  defp user_items(user), do: Ecto.assoc(user, :items)
end

