defmodule BranchCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BranchCoreWeb.Telemetry,
      BranchCore.Repo,
      {DNSCluster, query: Application.get_env(:branch_core, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BranchCore.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BranchCore.Finch},
      # Start a worker by calling: BranchCore.Worker.start_link(arg)
      # {BranchCore.Worker, arg},
      # Start to serve requests, typically the last entry
      BranchCoreWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BranchCore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BranchCoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
