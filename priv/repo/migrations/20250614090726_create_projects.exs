defmodule BranchCore.Repo.Migrations.CreateMaintainerProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :github_repo_id, :integer
      add :name, :string
      add :full_name, :string
      add :description, :string
      add :html_url, :string
      add :homepage, :string
      add :topics, {:array, :string}
      add :visibility, :string
      add :is_template, :boolean, default: false, null: false
      add :has_issues, :boolean, default: false, null: false
      add :has_projects, :boolean, default: false, null: false
      add :has_wiki, :boolean, default: false, null: false
      add :archived, :boolean, default: false, null: false
      add :disabled, :boolean, default: false, null: false
      add :watchers_count, :integer
      add :open_issues_count, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:projects, [:user_id])
  end
end
