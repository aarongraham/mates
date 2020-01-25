defmodule Mates.Devs do
  alias Mates.Dev

  def all_developers(),
    do:
      ~w{aaron abe diana eric greg harold kelly}
      |> Enum.map(&Dev.find_from_id/1)

  def shuffle(devs) do
    devs
    |> Enum.shuffle()
    |> Enum.with_index()
    |> Enum.map(fn {dev, index} -> Map.put(dev, :position, index) end)
  end
end
