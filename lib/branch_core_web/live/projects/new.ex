defmodule BranchCoreWeb.ProjectLive.New do
  use BranchCoreWeb, :live_view

  alias BranchCore.SyncSupervisors.Projects.CreateProcessor
  alias BranchCore.Accounts.Provider

  def mount(%{"provider" => provider}, _session, socket) do
    {:ok,
    socket
    |> fetch_repositories_for_provider(provider)
    |> assign(:selected_repos, [])}
  end

  def handle_event("select_repo", %{"id" => repo_id}, socket) do
    repo = Enum.find(socket.assigns.repos, &("#{&1.id}" == repo_id))
    selected = [repo | socket.assigns.selected_repos]
    all = Enum.reject(socket.assigns.repos, &("#{&1.id}" == repo_id))

    {:noreply,
     socket
     |> assign(:selected_repos, selected)
     |> assign(:repos, all)}
  end

  def handle_event("deselect_repo", %{"id" => repo_id}, socket) do
    repo = Enum.find(socket.assigns.selected_repos, &("#{&1.id}" == repo_id))
    all = [repo | socket.assigns.repos]
    selected = Enum.reject(socket.assigns.selected_repos, &("#{&1.id}" == repo_id))

    {:noreply,
     socket
     |> assign(:selected_repos, selected)
     |> assign(:repos, all)}
  end

  def handle_event("add_for_contribution", _, socket) do
    CreateProcessor.process(socket.assigns.selected_repos, socket.assigns.current_user)
    {:noreply, push_navigate(socket, to: ~p"/projects")}
  end

  defp fetch_repositories_for_provider(socket, provider) do
    case Provider.get_user_repos(socket.assigns.current_user, provider) do
      {:ok, repos} -> assign(socket, :repos, repos)
      {:error, _} -> assign(socket, :error, true)
    end
  end
end
