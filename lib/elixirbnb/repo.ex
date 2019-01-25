defmodule Elixirbnb.Repo do
  use Ecto.Repo,
    otp_app: :elixirbnb,
    adapter: Ecto.Adapters.Postgres
end
