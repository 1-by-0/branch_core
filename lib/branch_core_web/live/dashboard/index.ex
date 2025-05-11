defmodule BranchCoreWeb.DashboardLive.Index do
  use BranchCoreWeb, :live_view

  alias BranchCore.Accounts

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(identities: get_user_identities(socket.assigns.current_user.id))}
  end

  defp get_user_identities(user_id) do
    Accounts.list_identities(user_id)
  end
end
