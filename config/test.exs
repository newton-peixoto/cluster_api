import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cluster_api, AppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "TnlH/tScgYCRjHoOYc6kWjMehsh6cw6NO/9FotRZ9cdH/PnaPZ/PbrRzTflI3PeF",
  server: false

# In test we don't send emails.
config :cluster_api, App.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
