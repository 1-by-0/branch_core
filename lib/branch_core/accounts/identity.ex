defmodule BranchCore.Accounts.Identity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "identities" do
    field :provider, :string
    field :provider_token, :string
    field :provider_email, :string
    field :provider_id, :string
    field :provider_meta, :map
    belongs_to :user, BranchCore.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(identity, attrs) do
    identity
    |> cast(attrs, [:provider, :provider_token, :provider_email, :provider_id, :provider_meta, :user_id])
    |> validate_required([:provider, :provider_token, :user_id])
  end
end
