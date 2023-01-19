defmodule App.Cache do
  use GenServer

  require Logger

  def start_link( _args \\ []) do
    GenServer.start_link(__MODULE__, %{}, [name: __MODULE__] )
  end

  @impl true
  def init(args) do
    Logger.info("[CACHE] #{node()} started")
    Phoenix.PubSub.subscribe(App.PubSub, "cache")
    Phoenix.PubSub.broadcast(App.PubSub, "cache", :inflate)
    {:ok, args}
  end
  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def save(key, value) do
    GenServer.cast(__MODULE__, {:store, key, value})
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:store, key, value}, state) do
    state = Map.put(state, key, value)
    Phoenix.PubSub.broadcast(App.PubSub, "cache", {:state, state})
    {:noreply, state}
  end

  @impl true
  def handle_info({:state, new_state}, state) do
    {:noreply, Map.merge(state, new_state)}
  end

  @impl true
  def handle_info(:inflate, state) do
    Phoenix.PubSub.broadcast(App.PubSub, "cache", {:state, state})
    {:noreply, state}
  end
end
