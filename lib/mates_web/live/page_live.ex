defmodule MatesWeb.Live.PageLive do
  use Phoenix.LiveView

  alias Mates.Devs
  alias Mates.Dev

  def render(assigns) do
    Phoenix.View.render(MatesWeb.PageView, "index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, devs: MapSet.new(), notice: nil, number_of_pairs: 0, shuffled: false)}
  end

  def handle_event("all_devs", _value, socket) do
    {:noreply, assign(socket, :devs, MapSet.new(Devs.all_developers()))}
  end

  def handle_event("scanned", value, socket) do
    case Dev.find_from_id(value) do
      nil -> {:noreply, socket}
      dev -> {:noreply, assign(socket, :devs, MapSet.put(socket.assigns.devs, dev))}
    end
  end

  def handle_event("shuffle_pairs", _value, %{assigns: %{devs: %{map: map}}} = socket)
      when map_size(map) < 3 do
    {:noreply, socket |> assign(:notice, "Need to scan at least 3 devs")}
  end

  def handle_event("shuffle_pairs", _value, %{assigns: %{devs: devs}} = socket) do
    devs_with_positions = Devs.shuffle(devs) |> MapSet.new()

    number_of_pairs = (MapSet.size(devs) / 2) |> Float.ceil() |> Kernel.trunc()

    {:noreply,
     assign(socket,
       devs: devs_with_positions,
       number_of_pairs: number_of_pairs,
       shuffled: true,
       notice: nil
     )}
  end

  def handle_event("reset_pairs", _value, %{assigns: %{devs: devs}} = socket) do
    reset_devs =
      devs
      |> Enum.map(fn dev -> Map.put(dev, :position, nil) end)
      |> MapSet.new()

    {:noreply,
     assign(socket,
       devs: reset_devs,
       number_of_pairs: 0,
       shuffled: false,
       notice: nil
     )}
  end
end
