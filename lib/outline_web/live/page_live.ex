defmodule OutlineWeb.PageLive do
  use OutlineWeb, :live_view

  alias Outline.Accounts

  @impl true
  def mount(_params, session, socket) do
    user_id = Map.get(session, "user_id")
    current_user = user_id && Accounts.get_user(user_id)
    {:ok, assign(socket, current_user: current_user)}
  end

  defp load_list(socket) do
    user = Outline.Repo.get(Outline.Accounts.User, 2)
    list = Outline.List.ItemTree.build(user, nil)
    assign(socket, list: list)
  end
end
