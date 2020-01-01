defmodule MatesWeb.Live.PageLive do
  use Phoenix.LiveView

  alias Mates.Devs

  def render(assigns) do
    Phoenix.View.render(MatesWeb.PageView, "index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, devs: MapSet.new(), notice: nil)}
  end

  def handle_event("all_devs", value, socket) do
    {:noreply, assign(socket, :devs, MapSet.new(Devs.all()))}
  end

  def handle_event("scanned", value, socket) do
    case Devs.find_from_id(value) do
      nil -> {:noreply, socket}
      dev -> {:noreply, assign(socket, :devs, MapSet.put(socket.assigns.devs, dev))}
    end
  end

  def handle_event("shuffle_pairs", value, %{assigns: %{devs: %{map: map}}} = socket)
      when map_size(map) < 2 do
    {:noreply, socket |> assign(:notice, "Need to scan at least 2 devs")}
  end

  def handle_event("shuffle_pairs", value, %{assigns: %{devs: devs}} = socket) do
    devs_with_positions =
      MapSet.to_list(devs)
      |> Enum.shuffle()
      |> Enum.with_index()
      |> Enum.map(fn {dev, index} -> Map.put(dev, :position, index) end)
      |> MapSet.new()

    {:noreply, assign(socket, devs: devs_with_positions, notice: nil)}
  end
end
