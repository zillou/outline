defmodule Outline.Repo do
  use Ecto.Repo,
    otp_app: :outline,
    adapter: Ecto.Adapters.Postgres
end
