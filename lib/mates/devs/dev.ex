defmodule Mates.Dev do
  defstruct [
    :name,
    :image,
    :position
  ]

  defp all(),
    do: %{
      "aaron" => %__MODULE__{name: "aaron", image: "/images/aaron-card.jpg"},
      "abe" => %__MODULE__{name: "abe", image: "/images/abe-card.jpg"},
      "charlie" => %__MODULE__{name: "charlie", image: "/images/charlie-card.jpg"},
      "diana" => %__MODULE__{name: "diana", image: "/images/diana-card.jpg"},
      "eric" => %__MODULE__{name: "eric", image: "/images/eric-card.jpg"},
      "greg" => %__MODULE__{name: "greg", image: "/images/greg-card.jpg"},
      "harold" => %__MODULE__{name: "harold", image: "/images/harold-card.jpg"},
      "kelly" => %__MODULE__{name: "kelly", image: "/images/kelly-card.jpg"},
      "mark" => %__MODULE__{name: "mark", image: "/images/mark-card.jpg"},
      "max" => %__MODULE__{name: "max", image: "/images/max-card.png"}
    }

  def find_from_id(id), do: Map.get(all(), String.downcase(id))
end
