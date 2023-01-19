defmodule AppWeb.CacheController do

  use AppWeb, :controller
  alias App.Cache

  def get(conn, _params) do
   info =  %{
      "date" => DateTime.utc_now(),
      "current_node" => node(),
      "node_list" => Node.list(),
      "latest" => :true,
      "Env" => System.get_env("MIX_ENV")
    }
    cache = Cache.get()
    response = Map.merge(info, cache)
    conn |> json(response)
  end

  def store(conn, params) do
    %{"value" => value, "key" => key} = params

    Cache.save(key, value)

     conn |> json(%{saved: true})
   end

   def ready(conn, _params) do
     try do
      conn |> json(%{error: false})
     catch
       _ -> conn |>  put_status(:internal_server_error) |> json(%{error: true})
     end
   end

end
