defmodule App.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AppWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: App.PubSub},
      # Start the Endpoint (http/https)
      AppWeb.Endpoint,
      App.Cache,
      {Cluster.Supervisor, [
        [
          dns: [
            strategy: Cluster.Strategy.DNSPoll,
            config: [polling_interval: 5_000, query: "app", node_basename: "cluster_api"]
          ]
        ]

      ]
      },
      #{Task, fn -> ping_nodes() end}
      # Start a worker by calling: App.Worker.start_link(arg)
      # {App.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
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

  defp ping_nodes() do
    Process.sleep(1_000)
    Node.list()
    |> Enum.each(fn node ->
      IO.puts("[#{inspect(Node.self())} -> #{inspect(node)}] #{inspect(Node.ping(node))}")
    end)
    ping_nodes()
  end
end
