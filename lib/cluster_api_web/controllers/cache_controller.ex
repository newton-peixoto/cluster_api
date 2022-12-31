defmodule AppWeb.CacheController do

  use AppWeb, :controller
  alias App.CacheStarter

  def get(conn, _params) do
   info =  %{
      "date" => DateTime.utc_now(),
      "current_node" => node()
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

end
