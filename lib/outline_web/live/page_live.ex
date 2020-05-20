defmodule OutlineWeb.PageLive do
  use OutlineWeb, :live_view

  @sample_list [
    %{
      id: 10,
      title: "Shopping list",
      children: [
        %{
          id: 2,
          title: "Buy some milk",
          children: []
        },
        %{
          id: 3,
          title: "Buy some beer",
          children: [
            %{
              id: 31,
              title: "Tsingdao beer",
              children: [],
            },
            %{
              id: 32,
              title: "Blue Girl Beer",
              children: []
            }
          ]
        }
      ]
    },
    %{
      id: 4,
      title: "Read a book",
      children: []
    },
    %{
      id: 5,
      title: "Make coffee",
      children: []
    }
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, list: @sample_list)}
  end
end
