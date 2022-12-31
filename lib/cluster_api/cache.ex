defmodule App.Cache do
  use GenServer

  def start_link(opts \\ []) do
    name = Keyword.get(opts, :name, __MODULE__)

    GenServer.start_link(__MODULE__, %{node_started: node() }, name: name)
  end

  @impl GenServer
  def init(state) do
    {:ok, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:store, key, value}, state) do
    state = Map.put(state, key, value)

    {:noreply, state}
  end
end
