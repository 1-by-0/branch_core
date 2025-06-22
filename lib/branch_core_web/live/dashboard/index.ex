defmodule BranchCoreWeb.DashboardLive.Index do
  use BranchCoreWeb, :live_view

  alias BranchCore.Profile
  alias BranchCore.ProjectProfile

  # alias BranchCore.Accounts

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_user_skills()
     |> assign_matching_repositories()}
  end

  # defp get_user_identities(user_id) do
  #   Accounts.list_identities(user_id)
  # end

  defp assign_user_skills(socket) do
    assign(socket, :user_skills, Profile.list_user_skills(socket.assigns.current_user.id))
  end

  defp assign_matching_repositories(socket) do
    assign(
      socket,
      :matching_projects,
      ProjectProfile.list_profiles_for_skills_dashboard(socket.assigns.user_skills)
    )
  end
end
