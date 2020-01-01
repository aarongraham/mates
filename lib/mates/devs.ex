defmodule Mates.Devs do
  @devs %{
    "aaron" => %{name: "aaron", image: "/images/aaron.png", position: nil},
    "abe" => %{name: "abe", image: "/images/abe.png", position: nil},
    "charlie" => %{name: "charlie", image: "/images/charlie.png", position: nil},
    "diana" => %{name: "diana", image: "/images/diana.png", position: nil},
    "eric" => %{name: "eric", image: "/images/eric.png", position: nil},
    "greg" => %{name: "greg", image: "/images/greg.png", position: nil},
    "harold" => %{name: "harold", image: "/images/harold.png", position: nil},
    "kelly" => %{name: "kelly", image: "/images/kelly.png", position: nil},
    "mark" => %{name: "mark", image: "/images/mark.png", position: nil}
    #    "max" => %{name: "max", image: "/images/max.png"}
  }

  def find_from_id(id), do: Map.get(@devs, String.downcase(id))
  def all(), do: Map.keys(@devs) |> Enum.map(&find_from_id/1)
end
