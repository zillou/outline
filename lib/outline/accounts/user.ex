defmodule Outline.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avartar_url, :string
    field :email, :string
    field :name, :string
    field :provider, :string
    field :uid, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:avartar_url, :email, :name, :provider, :uid, :username])
    |> validate_required([:avartar_url, :email, :name, :provider, :uid, :username])
  end
end
