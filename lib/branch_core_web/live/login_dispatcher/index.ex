defmodule BranchCoreWeb.LoginDispatcher.Index do
  use BranchCoreWeb, :live_view

  alias BranchCore.Profile

  def mount(_params, _session, socket) do
    {:ok, socket, layout: false, temporary_assigns: []}
  end

  def handle_params(_params, _uri, socket) do
    user = socket.assigns.current_user

    {:noreply, push_navigate(socket, to: navigate_to_deired_landing_page(user))}
  end

  def navigate_to_deired_landing_page(user) do
    if Profile.profile_completed(user) do
      ~p"/dashboard"
    else
      ~p"/profiles/skills/edit"
    end
  end
end
