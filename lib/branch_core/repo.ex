defmodule BranchCore.Repo do
  use Ecto.Repo,
    otp_app: :branch_core,
    adapter: Ecto.Adapters.Postgres
end
