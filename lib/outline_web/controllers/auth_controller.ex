defmodule OutlineWeb.AuthController do
  use OutlineWeb, :controller

  alias Outline.Accounts

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.upsert_user(auth) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: NavigationHistory.last_path(conn, default: "/"))
      {:error, _} ->
        handle_auth_failure(conn)
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _failure}} = conn, _params) do
    handle_auth_failure(conn)
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp handle_auth_failure(conn) do
    conn
    |> put_flash(:error, "登录失败")
    |> redirect(to: "/")
  end
end
