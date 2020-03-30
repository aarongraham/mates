defmodule Mates.AgentDev do
  use Agent

  def start_link(devs) do
    Agent.start_link(
      fn -> devs end,
      name: __MODULE__
    )
  end

  def pop_next_dev() do
    Agent.get_and_update(__MODULE__, &List.pop_at(&1, 0))
  end
end
