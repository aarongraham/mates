defmodule Mates.Devs do
  alias Mates.Dev
  alias Mates.AgentDev

  def all_developers(),
    do:
      ~w{aaron abe diana eric greg harold kelly}
      |> Enum.map(&Dev.find_from_id/1)

  def number_of_pairs(devs) do
    (length(devs) / 2) |> Float.ceil() |> Kernel.trunc()
  end

  def shuffle(devs) do
    devs
    |> Enum.shuffle()
    |> Enum.with_index()
    |> Enum.map(fn {dev, index} -> Map.put(dev, :position, index) end)
  end

  def remove_dev(name, devs) do
    devs
    |> Enum.reject(&(&1.name == name))
  end

  def remove_positions(devs) do
    devs
    |> Enum.map(fn dev -> Map.put(dev, :position, 0) end)
  end

  def shuffle_maintaining_pairs(devs) do
    # I know, this is awful

    number_of_pairs = number_of_pairs(devs)

    pairs = devs |> Enum.group_by(& &1.pair)

    pairs
    |> Map.get(0)
    |> Enum.shuffle()
    |> AgentDev.start_link()

    1..number_of_pairs
    |> Enum.map(&Map.get(pairs, &1, []))
    |> Enum.map(fn
      [dev_one, dev_two] -> [dev_one, dev_two]
      [dev_one | []] -> [dev_one, AgentDev.pop_next_dev()]
      _ -> [AgentDev.pop_next_dev(), AgentDev.pop_next_dev()]
    end)
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
    |> Enum.with_index()
    |> Enum.map(fn {dev, index} -> Map.put(dev, :position, index) end)
  end

  def inc_pair(selected_developer, devs, increment_by \\ 1) do
    number_of_pairs = number_of_pairs(devs)

    devs
    |> Enum.map(&add_dev_to_a_pair(&1, selected_developer, increment_by, number_of_pairs))
  end

  def dec_pair(selected_developer, devs, decrement_by \\ -1) do
    inc_pair(selected_developer, devs, decrement_by)
  end

  defp add_dev_to_a_pair(%{name: selected_dev} = dev, selected_dev, increment_by, number_of_pairs) do
    new_pair_number = Integer.mod(dev.pair + increment_by, number_of_pairs + 1)

    %{dev | pair: new_pair_number}
  end

  defp add_dev_to_a_pair(dev, _, _, _), do: dev
end
