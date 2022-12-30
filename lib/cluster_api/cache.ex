defmodule App.Cache do
  use GenServer

  def start_link( _args \\ []) do
    GenServer.start_link(__MODULE__, %{node_cached_started: node()}, [name: __MODULE__] )
  end

  def init(args) do
    {:ok, args}
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def save(key, value) do
    GenServer.cast(__MODULE__, {:store, key, value})
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:store, key, value}, state) do

    state = Map.put(state, key, value)

    {:noreply, state}
  end



end
