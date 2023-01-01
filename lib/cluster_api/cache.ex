defmodule App.Cache do
  use GenServer

  def start_link(opts \\ []) do
    name = Keyword.get(opts, :name, __MODULE__)
    IO.puts "Being started at #{node()}"
    GenServer.start_link(__MODULE__, %{node_started: node()}, name: name)
  end

  @impl GenServer
  def init(state) do
    Process.flag(:trap_exit, true)
    {:ok, state, {:continue, :load_state}}
  end

  def handle_continue(:load_state, state) do
    {:noreply, Map.merge(App.StateBackup.backup, state)}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:store, key, value}, state) do
    state = Map.put(state, key, value)

    {:noreply, state}
  end

  @impl true
  def terminate(_reason, state) do
    for node <- Node.list do
      IO.puts("Enviando backup para #{inspect(node)}")
      send({App.StateBackup, node}, {:backup, state})
    end
  end
end
