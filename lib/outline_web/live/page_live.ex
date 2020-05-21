defmodule OutlineWeb.PageLive do
  use OutlineWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, load_list(socket)}
  end

  defp load_list(socket) do
    user = Outline.Repo.get(Outline.Accounts.User, 2)
    list = Outline.List.ItemTree.build(user, nil)
    assign(socket, list: list)
  end
end
