defmodule BranchCoreWeb.Identities.Index do
  use BranchCoreWeb, :live_view

  alias BranchCore.Accounts

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user

    {:ok,
     assign_has_identities_and_identities(socket, get_has_identities(user), get_identities(user))}
  end

  defp assign_has_identities_and_identities(socket, false, _identities) do
    socket
    |> assign(:has_identities, false)
    |> assign(:has_github, false)
    |> assign(:has_gitlab, false)
    |> assign(:has_bitbucket, false)
    |> stream(:identities, [])
  end

  defp assign_has_identities_and_identities(socket, true, identities) do
    socket
    |> assign(:has_identities, true)
    |> assign(:has_github, has_github(identities))
    |> assign(:has_gitlab, has_gitlab(identities))
    |> assign(:has_bitbucket, has_bitbucket(identities))
    |> stream(:identities, identities)
  end

  defp get_identities(user) do
    Accounts.list_identities(user.id)
  end

  defp has_github(identities) do
    has_provider(identities, "github")
  end

  defp has_gitlab(identities) do
    has_provider(identities, "gitlab")
  end

  defp has_bitbucket(identities) do
    has_provider(identities, "bitbucket")
  end

  defp has_provider(identities, provider) do
    Enum.any?(identities, fn i -> i.provider == provider end)
  end

  defp get_has_identities(user) do
    Accounts.has_identities?(user.id)
  end
end
