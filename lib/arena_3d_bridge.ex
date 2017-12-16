defmodule Arena3dBridge do
  use PathFinder
  use PathFinder.Footprints

  @node Application.get_env :arena_3d_bridge, :other_side

  gatekeeper Arena.Bridge.Switch
  gatekeeper Arena.Bridge.Translater

  footprints __MODULE__

  footprint :game_server,
    portal: {@node, Arena.Portal, :enter}

end
