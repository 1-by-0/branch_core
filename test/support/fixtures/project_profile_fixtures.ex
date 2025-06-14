defmodule BranchCore.ProjectProfileFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BranchCore.ProjectProfile` context.
  """

  @doc """
  Generate a project_skill.
  """
  def project_skill_fixture(attrs \\ %{}) do
    {:ok, project_skill} =
      attrs
      |> Enum.into(%{

      })
      |> BranchCore.ProjectProfile.create_project_skill()

    project_skill
  end
end
