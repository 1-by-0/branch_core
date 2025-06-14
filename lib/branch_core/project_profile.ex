defmodule BranchCore.ProjectProfile do
  @moduledoc """
  The ProjectProfile context.
  """

  import Ecto.Query, warn: false
  alias BranchCore.Repo

  alias BranchCore.ProjectProfile.ProjectSkill

  @doc """
  Returns the list of project_skills.

  ## Examples

      iex> list_project_skills()
      [%ProjectSkill{}, ...]

  """
  def list_project_skills do
    Repo.all(ProjectSkill)
  end

  @doc """
  Gets a single project_skill.

  Raises `Ecto.NoResultsError` if the Project skill does not exist.

  ## Examples

      iex> get_project_skill!(123)
      %ProjectSkill{}

      iex> get_project_skill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_skill!(id), do: Repo.get!(ProjectSkill, id)

  @doc """
  Creates a project_skill.

  ## Examples

      iex> create_project_skill(%{field: value})
      {:ok, %ProjectSkill{}}

      iex> create_project_skill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_skill(attrs \\ %{}) do
    %ProjectSkill{}
    |> ProjectSkill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_skill.

  ## Examples

      iex> update_project_skill(project_skill, %{field: new_value})
      {:ok, %ProjectSkill{}}

      iex> update_project_skill(project_skill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_skill(%ProjectSkill{} = project_skill, attrs) do
    project_skill
    |> ProjectSkill.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project_skill.

  ## Examples

      iex> delete_project_skill(project_skill)
      {:ok, %ProjectSkill{}}

      iex> delete_project_skill(project_skill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_skill(%ProjectSkill{} = project_skill) do
    Repo.delete(project_skill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_skill changes.

  ## Examples

      iex> change_project_skill(project_skill)
      %Ecto.Changeset{data: %ProjectSkill{}}

  """
  def change_project_skill(%ProjectSkill{} = project_skill, attrs \\ %{}) do
    ProjectSkill.changeset(project_skill, attrs)
  end
end
