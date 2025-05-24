defmodule BranchCore.ProfileTest do
  use BranchCore.DataCase

  alias BranchCore.Profile

  describe "user_skills" do
    alias BranchCore.Profile.UserSkill

    import BranchCore.ProfileFixtures

    @invalid_attrs %{level: nil}

    test "list_user_skills/0 returns all user_skills" do
      user_skill = user_skill_fixture()
      assert Profile.list_user_skills() == [user_skill]
    end

    test "get_user_skill!/1 returns the user_skill with given id" do
      user_skill = user_skill_fixture()
      assert Profile.get_user_skill!(user_skill.id) == user_skill
    end

    test "create_user_skill/1 with valid data creates a user_skill" do
      valid_attrs = %{level: "some level"}

      assert {:ok, %UserSkill{} = user_skill} = Profile.create_user_skill(valid_attrs)
      assert user_skill.level == "some level"
    end

    test "create_user_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profile.create_user_skill(@invalid_attrs)
    end

    test "update_user_skill/2 with valid data updates the user_skill" do
      user_skill = user_skill_fixture()
      update_attrs = %{level: "some updated level"}

      assert {:ok, %UserSkill{} = user_skill} =
               Profile.update_user_skill(user_skill, update_attrs)

      assert user_skill.level == "some updated level"
    end

    test "update_user_skill/2 with invalid data returns error changeset" do
      user_skill = user_skill_fixture()
      assert {:error, %Ecto.Changeset{}} = Profile.update_user_skill(user_skill, @invalid_attrs)
      assert user_skill == Profile.get_user_skill!(user_skill.id)
    end

    test "delete_user_skill/1 deletes the user_skill" do
      user_skill = user_skill_fixture()
      assert {:ok, %UserSkill{}} = Profile.delete_user_skill(user_skill)
      assert_raise Ecto.NoResultsError, fn -> Profile.get_user_skill!(user_skill.id) end
    end

    test "change_user_skill/1 returns a user_skill changeset" do
      user_skill = user_skill_fixture()
      assert %Ecto.Changeset{} = Profile.change_user_skill(user_skill)
    end
  end
end
