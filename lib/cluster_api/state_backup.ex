defmodule App.StateBackup do
  use GenServer

  def start_link( _args \\ []) do
    IO.puts "Começando o genserver de backup"
    GenServer.start_link(__MODULE__, %{}, [name: __MODULE__] )
  end

  def init(args) do
    {:ok, args}
  end

  def backup() do
    GenServer.call(__MODULE__, :get)
  end


  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:backup, new_state}, state) do
    {:noreply, new_state}
  end


end
