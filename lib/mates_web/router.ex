defmodule MatesWeb.Router do
  use MatesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MatesWeb do
    pipe_through :browser

    live "/", Live.PageLive
    live "/scan", Live.ScanLive
  end
end
