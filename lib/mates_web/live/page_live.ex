defmodule MatesWeb.Live.PageLive do
  use Phoenix.LiveView

  alias Mates.Devs

  def render(assigns) do
    Phoenix.View.render(MatesWeb.PageView, "index.html", assigns)
  end

  def mount(_session, socket) do
    devs = Devs.all_developers()

    {:ok,
     assign(socket,
       devs: devs |> Enum.sort(&(&1.name <= &2.name)),
       notice: nil,
       number_of_pairs: Devs.number_of_pairs(devs),
       shuffled: false,
       dashboard_pair: nil
     )}
  end

  def handle_event(
        "click_dev",
        %{"developer" => selected_dev, "shiftKey" => false},
        %{assigns: %{devs: devs}} = socket
      ) do
    {:noreply, assign(socket, :devs, Devs.inc_pair(selected_dev, devs))}
  end

  def handle_event(
        "click_dev",
        %{"developer" => selected_dev, "shiftKey" => true},
        %{assigns: %{devs: devs}} = socket
      ) do
    {:noreply, assign(socket, :devs, Devs.dec_pair(selected_dev, devs))}
  end

  def handle_event(
        "delete_dev",
        %{"developer" => selected_dev},
        %{assigns: %{devs: devs}} = socket
      ) do
    new_devs = Devs.remove_dev(selected_dev, devs)

    {:noreply,
     assign(socket,
       devs: new_devs,
       number_of_pairs: Devs.number_of_pairs(new_devs)
     )}
  end

  def handle_event("shuffle_pairs", _value, %{assigns: %{devs: devs, shuffled: true}} = socket) do
    {:noreply,
     assign(socket,
       devs: Devs.remove_positions(devs),
       number_of_pairs: Devs.number_of_pairs(devs),
       shuffled: false,
       notice: nil,
       dashboard_pair: nil
     )}
  end

  def handle_event("shuffle_pairs", _value, %{assigns: %{devs: devs}} = socket) do
    devs_with_positions =
      Devs.shuffle_maintaining_pairs(devs)
      |> Enum.sort(&(&1.name <= &2.name))

    number_of_pairs = Devs.number_of_pairs(devs)

    {:noreply,
     assign(socket,
       devs: devs_with_positions,
       number_of_pairs: number_of_pairs,
       shuffled: true,
       notice: nil,
       dashboard_pair: Enum.random(1..number_of_pairs)
     )}
  end
end
