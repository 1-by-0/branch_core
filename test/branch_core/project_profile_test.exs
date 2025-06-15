defmodule BranchCore.ProjectProfileTest do
  use BranchCore.DataCase

  alias BranchCore.ProjectProfile

  describe "project_skills" do
    alias BranchCore.ProjectProfile.ProjectSkill

    import BranchCore.ProjectProfileFixtures

    @invalid_attrs %{}

    test "list_project_skills/0 returns all project_skills" do
      project_skill = project_skill_fixture()
      assert ProjectProfile.list_project_skills() == [project_skill]
    end

    test "get_project_skill!/1 returns the project_skill with given id" do
      project_skill = project_skill_fixture()
      assert ProjectProfile.get_project_skill!(project_skill.id) == project_skill
    end

    test "create_project_skill/1 with valid data creates a project_skill" do
      valid_attrs = %{}

      assert {:ok, %ProjectSkill{} = project_skill} =
               ProjectProfile.create_project_skill(valid_attrs)
    end

    test "create_project_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProjectProfile.create_project_skill(@invalid_attrs)
    end

    test "update_project_skill/2 with valid data updates the project_skill" do
      project_skill = project_skill_fixture()
      update_attrs = %{}

      assert {:ok, %ProjectSkill{} = project_skill} =
               ProjectProfile.update_project_skill(project_skill, update_attrs)
    end

    test "update_project_skill/2 with invalid data returns error changeset" do
      project_skill = project_skill_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ProjectProfile.update_project_skill(project_skill, @invalid_attrs)

      assert project_skill == ProjectProfile.get_project_skill!(project_skill.id)
    end

    test "delete_project_skill/1 deletes the project_skill" do
      project_skill = project_skill_fixture()
      assert {:ok, %ProjectSkill{}} = ProjectProfile.delete_project_skill(project_skill)

      assert_raise Ecto.NoResultsError, fn ->
        ProjectProfile.get_project_skill!(project_skill.id)
      end
    end

    test "change_project_skill/1 returns a project_skill changeset" do
      project_skill = project_skill_fixture()
      assert %Ecto.Changeset{} = ProjectProfile.change_project_skill(project_skill)
    end
  end
end
