# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixirbnb,
  ecto_repos: [Elixirbnb.Repo]

# Configures the endpoint
config :elixirbnb, ElixirbnbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EsM15TPll2sUevNOkd4eqWL0lBQV2L+C5eZiFtJA93Js41vJtsUIJj0/a1K8AG2n",
  render_errors: [view: ElixirbnbWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Elixirbnb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Elixirbnb.Coherence.User,
  repo: Elixirbnb.Repo,
  module: Elixirbnb,
  web_module: ElixirbnbWeb,
  router: ElixirbnbWeb.Router,
  password_hashing_alg: Comeonin.Bcrypt,
  messages_backend: ElixirbnbWeb.Coherence.Messages,
  registration_permitted_attributes: [
    "email",
    "name",
    "password",
    "current_password",
    "password_confirmation"
  ],
  invitation_permitted_attributes: ["name", "email"],
  password_reset_permitted_attributes: [
    "reset_password_token",
    "password",
    "password_confirmation"
  ],
  session_permitted_attributes: ["remember", "email", "password"],
  opts: [:authenticatable]

# %% End Coherence Configuration %%
# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Elixirbnb.Coherence.User,
  repo: Elixirbnb.Repo,
  module: Elixirbnb,
  web_module: ElixirbnbWeb,
  router: ElixirbnbWeb.Router,
  password_hashing_alg: Comeonin.Bcrypt,
  messages_backend: ElixirbnbWeb.Coherence.Messages,
  registration_permitted_attributes: [
    "email",
    "name",
    "password",
    "current_password",
    "password_confirmation"
  ],
  invitation_permitted_attributes: ["name", "email"],
  password_reset_permitted_attributes: [
    "reset_password_token",
    "password",
    "password_confirmation"
  ],
  session_permitted_attributes: ["remember", "email", "password"],
  email_from_name: "Steve",
  email_from_email: "noreply@spdevuk.com",
  opts: [
    :authenticatable,
    :recoverable,
    :lockable,
    :trackable,
    :unlockable_with_token,
    :invitable,
    :registerable
  ]

config :coherence, ElixirbnbWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: System.get_env("SENDGRID_API_KEY")

# %% End Coherence Configuration %%
