defmodule BranchCore.MaintainerProjects do
  @moduledoc """
  The MaintainerProjects context.
  """

  import Ecto.Query, warn: false
  alias BranchCore.Repo

  alias BranchCore.MaintainerProjects.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Returns the list of projects for a user.

  ## Examples

      iex> list_projects(user)
      [%Project{}, ...]

  """
  def list_projects(user) do
    from(p in Project, where: p.user_id == ^user.id)
    |> Repo.all()
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  alias BranchCore.MaintainerProjects.ProjectIssue

  @doc """
  Returns the list of project_issues.

  ## Examples

      iex> list_project_issues()
      [%ProjectIssue{}, ...]

  """
  def list_project_issues do
    Repo.all(ProjectIssue)
  end

  @doc """
  Gets a single project_issue.

  Raises `Ecto.NoResultsError` if the Project issue does not exist.

  ## Examples

      iex> get_project_issue!(123)
      %ProjectIssue{}

      iex> get_project_issue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_issue!(id), do: Repo.get!(ProjectIssue, id)

  @doc """
  Creates a project_issue.

  ## Examples

      iex> create_project_issue(%{field: value})
      {:ok, %ProjectIssue{}}

      iex> create_project_issue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_issue(attrs \\ %{}) do
    %ProjectIssue{}
    |> ProjectIssue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_issue.

  ## Examples

      iex> update_project_issue(project_issue, %{field: new_value})
      {:ok, %ProjectIssue{}}

      iex> update_project_issue(project_issue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_issue(%ProjectIssue{} = project_issue, attrs) do
    project_issue
    |> ProjectIssue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project_issue.

  ## Examples

      iex> delete_project_issue(project_issue)
      {:ok, %ProjectIssue{}}

      iex> delete_project_issue(project_issue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_issue(%ProjectIssue{} = project_issue) do
    Repo.delete(project_issue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_issue changes.

  ## Examples

      iex> change_project_issue(project_issue)
      %Ecto.Changeset{data: %ProjectIssue{}}

  """
  def change_project_issue(%ProjectIssue{} = project_issue, attrs \\ %{}) do
    ProjectIssue.changeset(project_issue, attrs)
  end
end
