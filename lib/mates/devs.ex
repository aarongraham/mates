defmodule Mates.Devs do
  @devs %{
    "aaron" => %{name: "aaron", image: "/images/aaron-card.jpg", position: nil},
    "abe" => %{name: "abe", image: "/images/abe-card.jpg", position: nil},
    "charlie" => %{name: "charlie", image: "/images/charlie-card.jpg", position: nil},
    "diana" => %{name: "diana", image: "/images/diana-card.jpg", position: nil},
    "eric" => %{name: "eric", image: "/images/eric-card.jpg", position: nil},
    "greg" => %{name: "greg", image: "/images/greg-card.jpg", position: nil},
    "harold" => %{name: "harold", image: "/images/harold-card.jpg", position: nil},
    "kelly" => %{name: "kelly", image: "/images/kelly-card.jpg", position: nil},
    "mark" => %{name: "mark", image: "/images/mark-card.jpg", position: nil},
    "max" => %{name: "max", image: "/images/max-card.png", position: nil}
  }

  def find_from_id(id), do: Map.get(@devs, String.downcase(id))

  def all_devs(),
    do:
      ~w{aaron abe diana eric greg harold kelly}
      |> Enum.map(&find_from_id/1)
end
