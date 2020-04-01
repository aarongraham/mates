defmodule Mates.Devs do
  alias Mates.Dev

  def all_developers(),
    do:
      ~w{aaron abe ben diana kelly paul}
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

  def shuffle_maintaining_pairs(devs, shuffle_fn \\ &Enum.shuffle/1) do
    number_of_pairs = number_of_pairs(devs)

    grouped_pairs = devs |> Enum.group_by(& &1.pair)

    people_in_pairs = Map.delete(grouped_pairs, 0)

    devs_in_no_pair =
      grouped_pairs
      |> Map.get(0, [])
      |> shuffle_fn.()

    organised_devs =
      devs_in_no_pair
      |> Enum.reduce(people_in_pairs, fn dev, people_in_pairs ->
        Enum.reduce_while(1..number_of_pairs, people_in_pairs, fn
          pair_number, people_in_pairs ->
            case Map.get(people_in_pairs, pair_number) do
              [_dev_one, _dev_two] ->
                {:cont, people_in_pairs}

              [_dev_one | []] ->
                {:halt, Map.update!(people_in_pairs, pair_number, fn x -> x ++ [dev] end)}

              _ ->
                {:halt, Map.put(people_in_pairs, pair_number, [dev])}
            end
        end)
      end)

    1..number_of_pairs
    |> Enum.map(fn number -> Map.get(organised_devs, number) end)
    |> List.flatten()
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
