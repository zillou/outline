defmodule OutlineWeb.ListLive do
  use OutlineWeb, :live_view

  alias Outline.Accounts
  alias Outline.List.ItemTree

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    current_user = Accounts.get_user(user_id)
    {:ok, assign(socket, list: load_list(current_user))}
  end

  defp load_list(current_user) do
    Outline.List.ItemTree.build(current_user, nil)
  end
end
