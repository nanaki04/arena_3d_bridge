defmodule Arena3dBridge.Application do
  @moduledoc false

  use Application

  def start(_, _) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Task.Supervisor, [[name: Arena3dBridge.Task.Supervisor]], restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: Arena3dBridge.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
