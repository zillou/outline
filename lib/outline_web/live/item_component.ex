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
        <%= f = form_for :item, "#", phx_change: "input", phx_debounce: "2000", phx_target: @myself %>
          <div class="content flex" contenteditable
              phx-hook="ContentEditable" phx-update="ignore"
              data-name="item[title]">
            <div class="title text-gray-900 bold">
              <%= @item.title %>
            </div>
            <span class="tag text-gray-700">#<span class="tag-text">errand</span>
          </div>
          <%= text_input f, :title, class: "hidden" %>
        </form>
      </div>
      <%= if length(@item.children) > 0 do %>
        <%= live_component @socket, OutlineWeb.ListComponent, id: @item.id, list: @item.children %>
      <% end %>
    </div>
    """
  end

  # @impl true
  # def update(%{item: item} = assigns, socket) do
  #   changeset = Accounts.change_user(user)
  #
  #   {:ok,
  #    socket
  #    |> assign(assigns)
  #    |> assign(:changeset, changeset)}
  # end

  def handle_event("input", %{"item" => item_attrs} = params, socket) do
    IO.inspect(params)
    IO.inspect(socket.assigns.item)
    # {:ok, item} = Outline.List.update_item(socket.assigns.item, item_attrs)
    # {:noreply, assign(socket, :item, item)}
    {:noreply, socket}
  end
end
