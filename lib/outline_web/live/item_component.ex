defmodule OutlineWeb.ItemComponent do
  use OutlineWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="item">
      <div class="title flex items-center pt-1">
        <a href="#" class="bullet">
          <svg viewBox="0 0 18 18" fill="currentColor">
            <circle cx="9" cy="9" r="3.5"></circle>
          </svg>
        </a>
        <div class="content flex" contenteditable>
          <div class="title text-gray-900 bold">
            <%= @item.title %>
          </div>
          <span class="tag text-gray-700">#<span class="tag-text">errand</span>
        </div>
      </div>
      <%= if length(@item.children) > 0 do %>
        <%= live_component @socket, OutlineWeb.ListComponent, list: @item.children %>
      <% end %>
    </div>
    """
  end
end
