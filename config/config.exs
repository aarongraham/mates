# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :mates, MatesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DCvXTMQDD3ZBVgmeM2VfbJKd9q+ytmCTMEFLxSYz4qLctg535vM45akhH75JmQXM",
  render_errors: [view: MatesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mates.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "pjiGWWQ1pFwHsUAq3WrqT17cjuP9HKOcPmFAhHhoa9QeBqJ73r9bTwXFtwIUQVdl"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
