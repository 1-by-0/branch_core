defmodule BranchCore.SyncSupervisors.Projects.CreateProcessor do
  alias BranchCore.SyncSupervisors.Projects.CreateSupervisor
  def process(repos, user) do
    Task.start(fn ->
      Enum.each(repos, fn repo ->
        CreateSupervisor.start_repo_creation(repo, user)
      end)
     end)
  end
end
