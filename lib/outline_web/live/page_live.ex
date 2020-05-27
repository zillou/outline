defmodule OutlineWeb.PageLive do
  use OutlineWeb, :live_view

  alias Outline.Accounts

  @impl true
  def mount(_params, session, socket) do
    user_id = Map.get(session, "user_id")
    current_user = user_id && Accounts.get_user(user_id)
    {:ok, assign(socket, current_user: current_user)}
  end
end
