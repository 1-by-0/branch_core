defmodule BranchCoreWeb.UserSkillLive.Index do
  use BranchCoreWeb, :live_view

  alias BranchCore.Profile

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     stream(socket, :user_skills, get_user_skills(socket.assigns.current_user))
     |> assign(:profile_completed, assign_profile_completed(socket.assigns.current_user))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info({BranchCoreWeb.UserSkillLive.FormComponent, {:saved, user_skill}}, socket) do
    {:noreply, stream_insert(socket, :user_skills, user_skill) |> set_profile_completed_to_true }
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Skill")
    |> assign(:user_skill, Profile.get_user_skill!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Add new skill")
    |> assign(:user_skill, %Profile.UserSkill{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Profile | Your Skills")
    |> assign(:user_skill, nil)
  end

  defp get_user_skills(user) do
    Profile.list_user_skills(user.id)
  end

  defp assign_profile_completed(user) do
    Profile.profile_completed(user)
  end

  defp set_profile_completed_to_true(socket) do
    if socket.assigns.profile_completed do
      socket
    else
      assign(socket, :profile_completed, true)
    end
  end
end
