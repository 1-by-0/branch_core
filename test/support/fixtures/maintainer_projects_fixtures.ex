defmodule BranchCore.MaintainerProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BranchCore.MaintainerProjects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        archived: true,
        description: "some description",
        disabled: true,
        full_name: "some full_name",
        github_repo_id: 42,
        has_issues: true,
        has_projects: true,
        has_wiki: true,
        homepage: "some homepage",
        html_url: "some html_url",
        is_template: true,
        name: "some name",
        open_issues_count: 42,
        topics: ["option1", "option2"],
        visibility: "some visibility",
        watchers_count: 42
      })
      |> BranchCore.MaintainerProjects.create_project()

    project
  end
end
