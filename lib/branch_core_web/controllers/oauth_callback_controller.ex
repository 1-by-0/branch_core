defmodule BranchCoreWeb.OauthCallbackController do
  alias BranchCore.Accounts.Provider
  use BranchCoreWeb, :controller

  # alias BranchCore.Accounts.Providers.Github

  def new(conn, %{"provider" => provider, "code" => code, "state" => state}) do
    case Provider.exchange_access_token(provider, conn.assigns.current_user,
           code: code,
           state: state
         ) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Liked #{provider} Successfully")
        |> redirect(to: ~p"/profile/identities")

      {:error, _} ->
        conn
        |> put_flash(:error, "Couldn't link Github")
        |> redirect(to: ~p"/profile/identities")
    end
  end
end
