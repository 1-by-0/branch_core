defmodule BranchCore.SyncRunners.Projects.Creator do
  alias BranchCore.MaintainerProjects
  use GenServer

  def start_link({repo, user}) do
    GenServer.start_link(__MODULE__, {repo, user})
  end

  def child_spec(args) do
  %{
    id: __MODULE__,
    start: {__MODULE__, :start_link, [args]},
    restart: :temporary,
    type: :worker
  }
  end

  @impl true
  def init({repo, user}) do
    Process.flag(:trap_exit, true)
    {:ok,
    %{repo: repo,
      user: user,
      retries: 0},
    {:continue, :create_project}}
  end

  @impl true
  def handle_continue(:create_project, state) do
    attempt_create_project(state)
  end

  @impl true
  def terminate(_reason, _state) do
    # Perform cleanup here, e.g., logging
    IO.puts("GenServer is terminating gracefully")
    :ok
  end

  defp attempt_create_project(state) do
    attrs =
      Map.put(state.repo, :user_id, state.user.id)
      |> Map.put(:provider_repo_id, state.repo.id)
    case MaintainerProjects.create_project(attrs) do
      {:ok, _project} ->
        {:stop, :shutdown, state}
        # {:noreply, state}

      {:error, _changeset} ->
        retries = state.retries + 1
        if retries == 3 do
          {:stop, :normal, nil}
        else
          {:noreply, %{state | retries: retries}, {:continue, :create_project}}
        end
    end
  end
end
