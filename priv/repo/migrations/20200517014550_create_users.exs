defmodule Outline.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uid, :string
      add :provider, :string
      add :email, :string
      add :name, :string
      add :username, :string
      add :avartar_url, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:uid, :provider])
  end
end
