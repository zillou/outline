defmodule OutlineWeb.Router do
  use OutlineWeb, :router
  alias OutlineWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {OutlineWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NavigationHistory.Tracker, excluded_paths: ["/", ~r{/auth/.*}]
    plug Plugs.CurrentUser
  end

  pipeline :require_login do
    plug Plugs.RequireLogin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", OutlineWeb do
    pipe_through :browser
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/", OutlineWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/", OutlineWeb do
    pipe_through [:browser, :require_login]

    get "/logout", AuthController, :delete
  end
end
