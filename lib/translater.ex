defmodule Arena.Bridge.Translater do
  use PathFinder.Gatekeeper

  @functions %{
    "LoginEvent": :login_event,
    "JoinEvent": :join_event,
    "MessageEvent": :message_event,
  }

  def inspect(next) do
    fn %{gifts: [direction, events]} = state ->
      state
      |> Map.put(:gifts, [direction, translate_upstream(direction, events)])
      |> next.()
      |> (&%{&1 | result: translate_downstream(hd(&1.gifts), &1.result)}).()
    end
  end

  def translate_upstream(direction, events) do
    Enum.map(events, fn event ->
      direction
      |> Kernel.to_string
      |> String.capitalize
      |> (&Module.concat Arena.Bridge, &1).()
      |> Kernel.apply(@functions[event["EventType"]], [event])
    end)
  end

  def translate_downstream(direction, spoils) do
    spoils
    |> Enum.reduce(%{}, fn {key, charms}, acc ->
      Map.put(acc, key, Enum.map(charms, fn charm ->
        direction
        |> Kernel.to_string
        |> String.capitalize
        |> (&Module.concat Arena.Bridge, &1).()
        |> Kernel.apply(charm.type, [charm])
      end))
    end)
  end
end
