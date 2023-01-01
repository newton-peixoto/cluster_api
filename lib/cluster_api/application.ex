defmodule App.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AppWeb.Telemetry,
      {Phoenix.PubSub, name: App.PubSub},
      AppWeb.Endpoint,
      {Cluster.Supervisor, [topologies()]
      },
      App.HordeRegistry,
      App.HordeSupervisor,
      App.NodeObserver,
      App.CacheStarter,
      App.StateBackup
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AppWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp topologies() do
    [
      dns: [
        strategy: Cluster.Strategy.DNSPoll,
        config: [polling_interval: 5_000, query: "app", node_basename: "cluster_api"]
      ]
    ]
  end
end
