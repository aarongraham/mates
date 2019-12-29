defmodule MatesWeb.Live.PageController do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(MatesWeb.PageView, "index.html", assigns)
  end

  def mount(session, socket) do
    {:ok, socket}
  end
end
