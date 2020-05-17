defmodule OutlineWeb.Plugs.CurrentUser do
  import Plug.Conn

  alias Outline.Accounts

  def init(opts), do: opts

  def call(%Plug.Conn{} = conn, _opts) do
    Plug.Conn.assign(conn, :current_user, get_user(conn))
  end

  defp get_user(conn) do
    case get_session(conn, :user_id) do
      nil -> nil
      user_id -> Accounts.get_user(user_id)
    end
  end
end
