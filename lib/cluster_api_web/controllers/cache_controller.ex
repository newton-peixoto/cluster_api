defmodule AppWeb.CacheController do

  use AppWeb, :controller
  alias App.CacheStarter

  def get(conn, _params) do
   info =  %{
      "date" => DateTime.utc_now(),
      "current_node" => node(),
      "node_list" => Node.list(),
      "Env" => System.get_env("MIX_ENV")
    }
    cache = CacheStarter.get()
    response = Map.merge(info, cache)
    conn |> json(response)
  end

  def store(conn, params) do
    %{"value" => value, "key" => key} = params

    CacheStarter.save(key, value)

     conn |> json(%{saved: true})
   end

   def ready(conn, _params) do
     try do
      conn |> json(%{error: false, pid: inspect App.CacheStarter.whereis()})
     catch
       _ -> conn |>  put_status(:internal_server_error) |> json(%{error: true})
     end
   end

end
