defmodule MatesWeb.Live.PageController do
  use Phoenix.LiveView

  alias Mates.Devs

  def render(assigns) do
    Phoenix.View.render(MatesWeb.PageView, "index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok,
     assign(
       socket,
       :devs,
       MapSet.new([
         %{name: "aaron", image: "/images/aaron.png"},
         %{name: "abe", image: "/images/abe.png"},
         %{name: "charlie", image: "/images/charlie.png"},
         %{name: "diana", image: "/images/diana.png"},
         %{name: "eric", image: "/images/eric.png"},
         %{name: "greg", image: "/images/greg.png"},
         %{name: "harold", image: "/images/harold.png"},
         %{name: "kelly", image: "/images/kelly.png"},
         %{name: "mark", image: "/images/mark.png"}
       ])
     )}
  end

  def handle_event("scanned", value, socket) do
    case Devs.find_from_id(value) do
      nil -> {:noreply, socket}
      dev -> {:noreply, assign(socket, :devs, MapSet.put(socket.assigns.devs, dev))}
    end
  end
end
