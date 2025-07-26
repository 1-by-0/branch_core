defmodule BranchCore.MaintainerProjects.ProjectIssue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_issues" do
    field :label, {:array, :string}
    field :state, :string
    field :title, :string
    field :body, :string
    field :html_url, :string
    belongs_to :project, BranchCore.MaintainerProjects.Project

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project_issue, attrs) do
    project_issue
    |> cast(attrs, [:title, :body, :html_url, :label, :state, :project_id])
    |> validate_required([:title, :body, :html_url, :label, :state, :project_id])
  end
end
