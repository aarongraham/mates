import Config

secret_key_base = System.get_env("SECRET_KEY_BASE")
canonical_host = System.get_env("CANONICAL_HOST")

{type, encoded, _atom} =
  System.get_env("SECRET_KEY") |> Base.decode64!() |> :public_key.pem_decode() |> hd()

config :mates, MatesWeb.Endpoint,
  url: [
    scheme: "https",
    host: canonical_host,
    port: 443
  ],
  http: [port: 80],
  https: [
    port: 443,
    cipher_suite: :strong,
    key: {type, encoded},
    certfile: "priv/cert/fullchain.pem"
  ],
  secret_key_base: secret_key_base,
  server: true

# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
#     config :mates, MatesWeb.Endpoint,
#       force_ssl: [hsts: true]
