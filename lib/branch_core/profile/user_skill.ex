defmodule BranchCore.Profile.UserSkill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_skills" do
    field :level, :string
    field :user_id, :id
    field :skill_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_skill, attrs) do
    user_skill
    |> cast(attrs, [:level])
    |> validate_required([:level])
  end
end
