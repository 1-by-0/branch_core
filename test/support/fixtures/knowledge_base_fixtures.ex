defmodule BranchCore.KnowledgeBaseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BranchCore.KnowledgeBase` context.
  """

  @doc """
  Generate a unique skill name.
  """
  def unique_skill_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a skill.
  """
  def skill_fixture(attrs \\ %{}) do
    {:ok, skill} =
      attrs
      |> Enum.into(%{
        color: "some color",
        name: unique_skill_name(),
        type: "some type"
      })
      |> BranchCore.KnowledgeBase.create_skill()

    skill
  end
end
