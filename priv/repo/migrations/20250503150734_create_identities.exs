defmodule BranchCore.Repo.Migrations.CreateIdentities do
  use Ecto.Migration

  def change do
    create table(:identities) do
      add :provider, :string, null: false
      add :provider_token, :string
      add :provider_email, :string
      add :provider_id, :string
      add :provider_meta, :map
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:identities, [:user_id])
  end
end
