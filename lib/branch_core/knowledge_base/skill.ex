defmodule BranchCore.KnowledgeBase.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skills" do
    field :name, :string
    field :type, :string
    field :color, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:name, :type, :color])
    |> validate_required([:name, :type, :color])
    |> unique_constraint(:name)
  end
end
