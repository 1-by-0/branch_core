defmodule BranchCore.Repo.Migrations.ModifyHomepageAndGithubRepoIdInProjects do
  use Ecto.Migration

  def change do
    rename table(:projects), :github_repo_id, to: :provider_repo_id
    rename table(:projects), :homepage, to: :homepage_url
  end
end
