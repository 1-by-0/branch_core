defmodule BranchCore.MaintainerProjectsTest do
  use BranchCore.DataCase

  alias BranchCore.MaintainerProjects

  describe "projects" do
    alias BranchCore.MaintainerProjects.Project

    import BranchCore.MaintainerProjectsFixtures

    @invalid_attrs %{
      disabled: nil,
      name: nil,
      description: nil,
      github_repo_id: nil,
      full_name: nil,
      html_url: nil,
      homepage: nil,
      topics: nil,
      visibility: nil,
      is_template: nil,
      has_issues: nil,
      has_projects: nil,
      has_wiki: nil,
      archived: nil,
      watchers_count: nil,
      open_issues_count: nil
    }

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert MaintainerProjects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert MaintainerProjects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{
        disabled: true,
        name: "some name",
        description: "some description",
        github_repo_id: 42,
        full_name: "some full_name",
        html_url: "some html_url",
        homepage: "some homepage",
        topics: ["option1", "option2"],
        visibility: "some visibility",
        is_template: true,
        has_issues: true,
        has_projects: true,
        has_wiki: true,
        archived: true,
        watchers_count: 42,
        open_issues_count: 42
      }

      assert {:ok, %Project{} = project} = MaintainerProjects.create_project(valid_attrs)
      assert project.disabled == true
      assert project.name == "some name"
      assert project.description == "some description"
      assert project.github_repo_id == 42
      assert project.full_name == "some full_name"
      assert project.html_url == "some html_url"
      assert project.homepage == "some homepage"
      assert project.topics == ["option1", "option2"]
      assert project.visibility == "some visibility"
      assert project.is_template == true
      assert project.has_issues == true
      assert project.has_projects == true
      assert project.has_wiki == true
      assert project.archived == true
      assert project.watchers_count == 42
      assert project.open_issues_count == 42
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MaintainerProjects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()

      update_attrs = %{
        disabled: false,
        name: "some updated name",
        description: "some updated description",
        github_repo_id: 43,
        full_name: "some updated full_name",
        html_url: "some updated html_url",
        homepage: "some updated homepage",
        topics: ["option1"],
        visibility: "some updated visibility",
        is_template: false,
        has_issues: false,
        has_projects: false,
        has_wiki: false,
        archived: false,
        watchers_count: 43,
        open_issues_count: 43
      }

      assert {:ok, %Project{} = project} =
               MaintainerProjects.update_project(project, update_attrs)

      assert project.disabled == false
      assert project.name == "some updated name"
      assert project.description == "some updated description"
      assert project.github_repo_id == 43
      assert project.full_name == "some updated full_name"
      assert project.html_url == "some updated html_url"
      assert project.homepage == "some updated homepage"
      assert project.topics == ["option1"]
      assert project.visibility == "some updated visibility"
      assert project.is_template == false
      assert project.has_issues == false
      assert project.has_projects == false
      assert project.has_wiki == false
      assert project.archived == false
      assert project.watchers_count == 43
      assert project.open_issues_count == 43
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()

      assert {:error, %Ecto.Changeset{}} =
               MaintainerProjects.update_project(project, @invalid_attrs)

      assert project == MaintainerProjects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = MaintainerProjects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> MaintainerProjects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = MaintainerProjects.change_project(project)
    end
  end
end
