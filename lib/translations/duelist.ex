defmodule Arena.Bridge.Duelist do

  use Arena.Bridge.Harmony
  import Arena.Bridge.Mark

  def login_event(event) do
    %{
      type: :login,
      name: event["PlayerId"],
      password: event["Password"],
      mark: mark(event["Id"]),
    }
  end

  def login_ok(charm) do
    %{
      "$type" => "Arena.Presentation.LoginOkEvent, Assembly-CSharp",
      "EventType" => "LoginOkEvent",
      "PlayerId" => charm.name,
      "Id" => eventId(charm.mark),
    }
  end

  def login_failed(charm) do
    %{
      "$type" => "Arena.Presentation.LoginFailedEvent, Assembly-CSharp",
      "EventType" => "LoginFailedEvent",
      "Id" => eventId(charm.mark),
    }
  end

end
