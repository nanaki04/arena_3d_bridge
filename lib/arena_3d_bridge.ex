defmodule Arena3dBridge do
  use PathFinder
  use PathFinder.Footprints

  @node :self

  gatekeeper Arena.Bridge.Translater
  footprints __MODULE__

  footprint :game_server, [
    portal: {@node, Portal, :enter}
  ]

end
