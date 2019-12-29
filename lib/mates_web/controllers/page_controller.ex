defmodule MatesWeb.PageController do
  use MatesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
