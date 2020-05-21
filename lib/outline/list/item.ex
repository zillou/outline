defmodule Outline.List.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :content, :string
    field :parent_id, :integer
    field :position, :float
    field :title, :string

    belongs_to :user, Outline.Accounts.User
    has_many :children, Outline.List.Item

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :content, :parent_id, :position])
    |> validate_required([:title, :content, :parent_id, :position])
  end
end
