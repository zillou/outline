import Config

config :outline,
  ecto_repos: [Outline.Repo]

# Configures the endpoint
config :outline, OutlineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mFrIDSvSrDvIL1gMR4NOjo3UZqTyHhRXy9R859ryysz6VsJ9Fh8goymm8ir528sx",
  render_errors: [view: OutlineWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Outline.PubSub,
  live_view: [signing_salt: "xurnzQFs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# OAuth
config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "read:user,user:email"]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
