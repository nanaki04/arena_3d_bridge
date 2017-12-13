defmodule Arena.Bridge.Mark do

  def mark(eventId) do
    %{
      id: eventId["Id"],
      caster: eventId["Spawner"],
      initiation: eventId["SpawnTime"],
      mark: 0,
    }
  end

  def eventId(mark) do
    %{
      "Id" => mark.id,
      "Spawner" => mark.caster,
      "SpawnTime" => mark.initiation,
      "Progress" => mark.mark,
    }
  end

end
