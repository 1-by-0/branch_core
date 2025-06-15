defmodule BranchCore.MaintainerProjects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :disabled, :boolean, default: false
    field :name, :string
    field :description, :string
    field :github_repo_id, :integer
    field :full_name, :string
    field :html_url, :string
    field :homepage, :string
    field :topics, {:array, :string}
    field :visibility, :string
    field :is_template, :boolean, default: false
    field :has_issues, :boolean, default: false
    field :has_projects, :boolean, default: false
    field :has_wiki, :boolean, default: false
    field :archived, :boolean, default: false
    field :watchers_count, :integer
    field :open_issues_count, :integer

    belongs_to :user, BranchCore.Accounts.User

    many_to_many :skills, BranchCore.KnowledgeBase.Skill,
      join_through: BranchCore.ProjectProfile.ProjectSkill

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :github_repo_id,
      :name,
      :full_name,
      :description,
      :html_url,
      :homepage,
      :topics,
      :visibility,
      :is_template,
      :has_issues,
      :has_projects,
      :has_wiki,
      :archived,
      :disabled,
      :watchers_count,
      :open_issues_count
    ])
    |> validate_required([
      :github_repo_id,
      :name,
      :full_name,
      :description,
      :html_url,
      :homepage,
      :topics,
      :visibility,
      :is_template,
      :has_issues,
      :has_projects,
      :has_wiki,
      :archived,
      :disabled,
      :watchers_count,
      :open_issues_count
    ])
  end
end
