defmodule OutlineWeb.PageLive do
  use OutlineWeb, :live_view

  @sample_list [
    %{
      title: "Shopping list",
      children: [
        %{
          title: "Buy some milk",
          children: []
        },
        %{
          title: "Buy some beer",
          children: []
        }
      ]
    },
    %{
      title: "Read a book",
      children: []
    },
    %{
      title: "Make coffee",
      children: []
    }
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, list: @sample_list)}
  end
end
