defmodule OutlineWeb.Plugs.RequireLogin do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  alias OutlineWeb.Router.Helpers, as: Routes
  alias Outline.Accounts.User

  def init(opts), do: opts

  def call(%Plug.Conn{assigns: %{current_user: %User{}}} = conn, _opts), do: conn
  def call(conn, _opts) do
    conn
    |> put_flash(:error, "请先登录")
    |> redirect(to: "/")
    |> halt()
  end
end
