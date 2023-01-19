defmodule App.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AppWeb.Telemetry,
      {Phoenix.PubSub, name: App.PubSub},
      AppWeb.Endpoint,
      {Cluster.Supervisor, [Application.get_env(:libcluster, :topologies)]
      },
      App.Cache
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
end
