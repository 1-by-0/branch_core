defmodule BranchCore.Profile do
  @moduledoc """
  The Profile context.
  """

  import Ecto.Query, warn: false
  alias BranchCore.Repo

  alias BranchCore.Profile.UserSkill

  def profile_completed(user) do
    from(us in UserSkill, where: us.user_id == ^user.id)
    |> Repo.exists?()
  end

  @doc """
  Returns the list of user_skills for a user_id.

  ## Examples

      iex> list_user_skills(user_id)
      [%UserSkill{}, ...]

  """
  def list_user_skills(user_id) do
    from(us in UserSkill, where: us.user_id == ^user_id)
    |> Repo.all()
    |> Repo.preload(:skill)
  end

  @doc """
  Gets a single user_skill.

  Raises `Ecto.NoResultsError` if the User skill does not exist.

  ## Examples

      iex> get_user_skill!(123)
      %UserSkill{}

      iex> get_user_skill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_skill!(id), do: Repo.get!(UserSkill, id) |> Repo.preload(:skill)

  @doc """
  Creates a user_skill.

  ## Examples

      iex> create_user_skill(%{field: value})
      {:ok, %UserSkill{}}

      iex> create_user_skill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_skill(attrs \\ %{}) do
    %UserSkill{}
    |> UserSkill.changeset(attrs)
    |> Repo.insert()
    |> preload_skill()
  end

  @doc """
  Updates a user_skill.

  ## Examples

      iex> update_user_skill(user_skill, %{field: new_value})
      {:ok, %UserSkill{}}

      iex> update_user_skill(user_skill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_skill(%UserSkill{} = user_skill, attrs) do
    user_skill
    |> UserSkill.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_skill.

  ## Examples

      iex> delete_user_skill(user_skill)
      {:ok, %UserSkill{}}

      iex> delete_user_skill(user_skill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_skill(%UserSkill{} = user_skill) do
    Repo.delete(user_skill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_skill changes.

  ## Examples

      iex> change_user_skill(user_skill)
      %Ecto.Changeset{data: %UserSkill{}}

  """
  def change_user_skill(%UserSkill{} = user_skill, attrs \\ %{}) do
    UserSkill.changeset(user_skill, attrs)
  end

  defp preload_skill({:ok, user_skill}), do: {:ok, user_skill |> Repo.preload(:skill)}
  defp preload_skill(result), do: result
end
