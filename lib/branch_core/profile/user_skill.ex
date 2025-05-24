defmodule BranchCore.Profile.UserSkill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_skills" do
    field :level, :string
    belongs_to :user, BranchCore.Accounts.User
    belongs_to :skill, BranchCore.KnowledgeBase.Skill

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_skill, attrs) do
    user_skill
    |> cast(attrs, [:user_id, :skill_id, :level])
    |> validate_required([:level])
    |> validate_inclusion(:level, ["beginner", "intermediate", "advanced"])
  end
end
