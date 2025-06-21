defmodule BranchCore.ProjectProfile.ProjectSkill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_skills" do
    belongs_to :project, BranchCore.MaintainerProjects.Project
    belongs_to :skill, BranchCore.KnowledgeBase.Skill

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project_skill, attrs) do
    project_skill
    |> cast(attrs, [])
    |> put_assoc(:skill, attrs["skill"])
    |> put_assoc(:project, attrs["project"])
  end
end
