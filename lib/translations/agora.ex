defmodule Arena.Bridge.Agora do

  use Arena.Bridge.Harmony
  import Arena.Bridge.Mark

  def join_event(event) do
    %{
      type: :participate,
      agora: event["Channel"],
      participant: event["PlayerId"],
      mark: mark(event["Id"]),
    }
  end

  def participate(charm) do
    %{
      "$type" => "Arena.Presentation.JoinEvent, Assembly-CSharp",
      "EventType" => "JoinEvent",
      "PlayerId" => charm.participant,
      "Id" => eventId(charm.mark),
    }
  end

  def message_event(event) do
    %{
      type: :speak,
      agora: event["Channel"],
      participant: event["PlayerId"],
      words: event["Message"],
      mark: mark(event["Id"]),
    }
  end

  def speak(charm) do
    %{
      "$type" => "Arena.Presentation.MessageEvent, Assembly-CSharp",
      "EventType" => "MessageEvent",
      "PlayerId" => charm.participant,
      "Message" => charm.words,
      "Id" => eventId(charm.mark),
    }
  end

end
