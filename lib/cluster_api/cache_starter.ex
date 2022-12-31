defmodule App.CacheStarter do
  @moduledoc """
  Module in charge of starting and monitoring  the `Cache`
  process, restarting it when necessary.
  """

  require Logger

  alias App.{Cache, HordeRegistry, HordeSupervisor}

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :temporary,
      shutdown: 500
    }
  end

  def start_link(opts) do
    name =
      opts
      |> Keyword.get(:name, Cache)
      |> via_tuple()

    opts = Keyword.put(opts, :name, name)

    child_spec = %{
      id: Cache,
      start: {Cache, :start_link, [opts]}
    }

    HordeSupervisor.start_child(child_spec)

    :ignore
  end

  def get() do
    whereis() |> GenServer.call( :get)
  end

  def save(key, value) do
    whereis() |> GenServer.cast({:store, key, value})
  end

  def whereis(name \\ Cache) do
    name
    |> via_tuple()
    |> GenServer.whereis()
  end

  defp via_tuple(name) do
    {:via, Horde.Registry, {HordeRegistry, name}}
  end
end
