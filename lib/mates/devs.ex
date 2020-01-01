defmodule Mates.Devs do
  @devs %{
    "aaron" => %{name: "aaron", image: "/images/aaron.png"},
    "abe" => %{name: "abe", image: "/images/abe.png"},
    "charlie" => %{name: "charlie", image: "/images/charlie.png"},
    "diana" => %{name: "diana", image: "/images/diana.png"},
    "eric" => %{name: "eric", image: "/images/eric.png"},
    "greg" => %{name: "greg", image: "/images/greg.png"},
    "harold" => %{name: "harold", image: "/images/harold.png"},
    "kelly" => %{name: "kelly", image: "/images/kelly.png"},
    "mark" => %{name: "mark", image: "/images/mark.png"}
    #    "max" => %{name: "max", image: "/images/max.png"}
  }

  def find_from_id(id), do: Map.get(@devs, String.downcase(id))
end
