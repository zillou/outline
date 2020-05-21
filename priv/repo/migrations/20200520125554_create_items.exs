defmodule Outline.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :title, :string
      add :content, :text
      add :parent_id, references(:items, on_delete: :delete_all), null: true
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :position, :float

      timestamps()
    end

    create index(:items, [:parent_id])
    create index(:items, [:user_id])
  end
end
