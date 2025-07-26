defmodule BranchCore.Repo.Migrations.CreateProjectIssues do
  use Ecto.Migration

  def change do
    create table(:project_issues) do
      add :title, :string
      add :body, :text
      add :html_url, :string
      add :label, {:array, :string}
      add :state, :string
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:project_issues, [:project_id])
  end
end
