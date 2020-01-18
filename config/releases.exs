import Config

canonical_host = System.fetch_env!("CANONICAL_HOST")
secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
live_view_signing_salt = System.fetch_env!("LIVE_VIEW_SIGNING_SALT")

url =
  if canonical_host == "localhost" do
    [scheme: "http", host: "localhost", port: 4000]
  else
    [scheme: "https", host: canonical_host, port: 443]
  end

config :mates, MatesWeb.Endpoint,
  url: url,
  http: [port: 4000],
  secret_key_base: secret_key_base,
  live_view: [
    signing_salt: live_view_signing_salt
  ],
  server: true
