defmodule BranchCore.KnowledgeBaseTest do
  use BranchCore.DataCase

  alias BranchCore.KnowledgeBase

  describe "skills" do
    alias BranchCore.KnowledgeBase.Skill

    import BranchCore.KnowledgeBaseFixtures

    @invalid_attrs %{name: nil, type: nil, color: nil}

    test "list_skills/0 returns all skills" do
      skill = skill_fixture()
      assert KnowledgeBase.list_skills() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert KnowledgeBase.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      valid_attrs = %{name: "some name", type: "some type", color: "some color"}

      assert {:ok, %Skill{} = skill} = KnowledgeBase.create_skill(valid_attrs)
      assert skill.name == "some name"
      assert skill.type == "some type"
      assert skill.color == "some color"
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = KnowledgeBase.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      update_attrs = %{name: "some updated name", type: "some updated type", color: "some updated color"}

      assert {:ok, %Skill{} = skill} = KnowledgeBase.update_skill(skill, update_attrs)
      assert skill.name == "some updated name"
      assert skill.type == "some updated type"
      assert skill.color == "some updated color"
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = KnowledgeBase.update_skill(skill, @invalid_attrs)
      assert skill == KnowledgeBase.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = KnowledgeBase.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> KnowledgeBase.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = KnowledgeBase.change_skill(skill)
    end
  end
end
