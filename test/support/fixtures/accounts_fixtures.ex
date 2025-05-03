defmodule BranchCore.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BranchCore.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> BranchCore.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a identity.
  """
  def identity_fixture(attrs \\ %{}) do
    {:ok, identity} =
      attrs
      |> Enum.into(%{
        provider: "some provider",
        provider_email: "some provider_email",
        provider_id: "some provider_id",
        provider_meta: %{},
        provider_token: "some provider_token"
      })
      |> BranchCore.Accounts.create_identity()

    identity
  end
end
