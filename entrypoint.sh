#!/bin/sh

exec elixir --name cluster_api@$(hostname -i) --cookie cookie_bolado -S mix phx.server