defmodule CrudApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CrudAppWeb.Telemetry,
      CrudApp.Repo,
      {DNSCluster, query: Application.get_env(:crud_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CrudApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CrudApp.Finch},
      # Start Redix for Redis connection
      {Redix, name: :redix, host: Application.get_env(:crud_app, :redix)[:host], port: Application.get_env(:crud_app, :redix)[:port]},
      # Start Cachex for caching
      {Cachex, name: :cache},
      # Start to serve requests, typically the last entry
      CrudAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CrudApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CrudAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
