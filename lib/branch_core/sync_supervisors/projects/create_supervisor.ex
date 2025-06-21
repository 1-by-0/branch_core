defmodule BranchCore.SyncSupervisors.Projects.CreateSupervisor do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_repo_creation(repo, user) do
    case DynamicSupervisor.start_child(__MODULE__, {BranchCore.SyncRunners.Projects.Creator, {repo, user}}) do
      {:ok, pid} -> IO.inspect({:ok, pid})
      error -> IO.inspect({:error, error})
    end
  end
end
