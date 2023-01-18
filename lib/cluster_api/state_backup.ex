defmodule App.StateBackup do
  use GenServer
  require Logger

  def start_link( _args \\ []) do
    current_state = App.CacheStarter.get()
    GenServer.start_link(__MODULE__, current_state, [name: __MODULE__] )
  end

  def init(args) do
    Logger.info("[NODE] #{node()} começando o StateBackup")
    {:ok, args}
  end

  def backup() do
    GenServer.call(__MODULE__, :get)
  end


  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:backup, new_state}, _state) do
    Logger.info("[NODE] #{inspect(node())} recebendo o backup")
    {:noreply, new_state}
  end
end
