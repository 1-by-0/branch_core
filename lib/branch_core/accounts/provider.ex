defmodule BranchCore.Accounts.Provider do
  alias BranchCore.Accounts

  def oauth_authorization_url(provider),
    do: provider_module(provider) |> module_authorization_url()

  def exchange_access_token(provider, user, opts) do
    provider_module(provider)
    |> call_module_access_token_function(opts)
    |> create_identitity(provider, user)
  end

  def create_identitity({:ok, token}, provider, user) do
    Accounts.create_identitity_if_not_found(%{
      "user_id" => user.id,
      "provider_token" => token,
      "provider" => provider
    })
  end

  def create_identitity({:error, error}, _provider, _user) do
    {:error, error}
  end

  def get_user_repos(user, provider) do
    provider_module(provider)
    |> call_module_repos_list_function(
      get_user_identity_for_provider(provider, user)
    )
  end

  def get_user_identity_for_provider(provider, user) do
    Accounts.get_identity_for_user(user, provider)
  end

  def module_authorization_url(nil), do: "/404"
  def module_authorization_url(module), do: module.authorize_url()

  def call_module_access_token_function(nil, _), do: {:error, "Provider not configured"}
  def call_module_access_token_function(module, opts), do: module.get_access_token(opts)

  def call_module_repos_list_function(nil, _), do: {:error, "Provider not configured"}
  def call_module_repos_list_function(_module, nil), do: {:error, "Identity Not found"}
  def call_module_repos_list_function(module, identity), do: module.repos(identity.provider_token)

  def provider_module("github"), do: BranchCore.Accounts.Providers.Github
  def provider_module(_provider), do: nil
end
