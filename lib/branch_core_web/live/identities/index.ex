defmodule BranchCoreWeb.Identities.Index do
  use BranchCoreWeb, :live_view

  alias BranchCore.Accounts

  def mount(_params, _session, socket) do
    {:ok, check_and_assign_identities(socket, socket.assigns.current_user)}
  end

  defp check_and_assign_identities(socket, user) do
    if get_has_identities(user) do
      assign_has_identities_and_identities(socket, true, get_identities(user))
    else
      assign_has_identities_and_identities(socket, false, [])
    end
  end

  defp assign_has_identities_and_identities(socket, has_identity, identities) do
    socket
    |> assign(:has_identities, has_identity)
    |> stream(:identities, identities)
  end

  defp get_identities(user) do
    Accounts.list_identities(user.id)
  end

  defp get_has_identities(user) do
    Accounts.has_identities?(user.id)
  end
end
