defmodule BranchCore.Repo.Migrations.CreateProjectSkills do
  use Ecto.Migration

  def change do
    create table(:project_skills) do
      add :project_id, references(:projects, on_delete: :nothing)
      add :skill_id, references(:skills, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:project_skills, [:project_id])
    create index(:project_skills, [:skill_id])
  end
end
