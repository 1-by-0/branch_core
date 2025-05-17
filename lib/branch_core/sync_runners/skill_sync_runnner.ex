defmodule BranchCore.SyncRunners.SkillSyncRunnner do
  use GenServer
  require Logger

  @interval Application.compile_env(:branch_core, :skill_sync_interval)

  def start_link(_opts) do
    GenServer.start(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    Logger.info("LanguageSyncer started, syncing every #1000ms")
    schedule_skill_sync()
    {:ok, %{last_run_succeed: false, error_count: 0}}
  end

  @impl true
  def handle_info(:sync_skills, state) do
    new_state =
      case BranchCore.Synchronizers.SkillSynchronizer.sync_skills() do
        {:ok, _msg} ->
          %{state | last_run_succeed: true }
        {:error, _msg} ->
          %{state | last_run_succeed: false, error_count: state.error_count + 1}
      end
      schedule_skill_sync()
      {:noreply, new_state}
  end

  defp schedule_skill_sync() do
    Process.send_after(self(), :sync_skills, @interval)
  end
end
