defmodule BranchCore.ProfileFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BranchCore.Profile` context.
  """

  @doc """
  Generate a user_skill.
  """
  def user_skill_fixture(attrs \\ %{}) do
    {:ok, user_skill} =
      attrs
      |> Enum.into(%{
        level: "some level"
      })
      |> BranchCore.Profile.create_user_skill()

    user_skill
  end
end
