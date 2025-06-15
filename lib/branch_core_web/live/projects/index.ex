defmodule BranchCoreWeb.ProjectLive.Index do
  use BranchCoreWeb, :live_view

  alias BranchCore.MaintainerProjects

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:projects, get_projects(socket.assigns.current_user))
     |> assign(:show_modal, false)}
  end

  def handle_event("show_modal", _unsigned_params, socket) do
    {:noreply, assign(socket, :show_modal, true)}
  end

  def handle_event("close_modal", _unsigned_params, socket) do
    {:noreply, assign(socket, :show_modal, false)}
  end

  defp get_projects(user) do
    MaintainerProjects.list_projects(user)
  end

  defp status_tag(label) do
    assigns = %{label: label}

    ~H"""
    <span class="inline-block px-2 py-1 rounded-full text-xs font-medium">
      {@label}
    </span>
    """
  end
end
