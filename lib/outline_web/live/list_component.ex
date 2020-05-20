defmodule OutlineWeb.ListComponent do
  use OutlineWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="list <%= assigns[:root] && "root" %>">
      <%= for item <- @list do %>
        <%= live_component @socket, OutlineWeb.ItemComponent, item: item, id: item.id %>
      <% end %>

      <%= if assigns[:root] do %>
        <a href="#" class="add">
          <svg class="add" viewBox="0 0 20 20">
            <circle cx="10.5" cy="10.5" r="9" fill="#dce0e2" class="circle"></circle>
            <line x1="6" y1="10.5" x2="15" y2="10.5" stroke="#868c90" stroke-width="1"></line>
            <line x1="10.5" y1="6" x2="10.5" y2="15" stroke="#868c90" stroke-width="1"></line>
          </svg>
        </a>
      <% end %>
    </div>
    """
  end
end
