defmodule BranchCore.ProjectProfile.ProjectSkill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_skills" do
    belongs_to :projects, BranchCore.MaintainerProjects.Project
    belongs_to :skills, BranchCore.KnowledgeBase.Skill

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project_skill, attrs) do
    project_skill
    |> cast(attrs, [:skill_id, :project_id])
    |> validate_required([:skill_id, :project_id])
  end
end
