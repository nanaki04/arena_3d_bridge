defmodule Arena.Bridge.Switch do
  use PathFinder.Gatekeeper

  @direction %{
    "LoginEvent" => :duelist,
    "VerifyDuelistProgress" => :duelist,
    "JoinEvent" => :agora,
    "MessageEvent" => :agora,
    "VerifyAgoraProgress" => :agora,
  }

  def inspect(next) do
    fn %{gifts: [events]} = state ->
      events
      |> Enum.sort_by(&(filter_direction @direction[&1["EventType"]] >= filter_direction @direction[&2["EventType"]]))
      |> Enum.chunk_by(&(filter_direction @direction[&1["EventType"]]))
      |> dispatch(state, next)
      |> Enum.map(&Task.await/1)
      |> Enum.reduce(
        state,
        &(%{state | result: Map.merge(&2.result, &1.result, fn _, v1, v2 -> v1 ++ v2 end)})
      )
    end
  end

  defp filter_direction(nil), do: :duel
  defp filter_direction(direction), do: direction

  defp dispatch(events, state, next) do
    Enum.map(events, &(Task.Supervisor.async Arena3dBridge.Task.Supervisor, fn () ->
      %{state | gifts: [filter_direction(@direction[hd(&1)["EventType"]]), &1]}
      |> next.()
    end))
  end

end
