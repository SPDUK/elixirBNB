defmodule Elixirbnb.Coherence.User do
  @moduledoc false
  use Ecto.Schema
  use Coherence.Schema
  alias Elixirbnb.Rentals.Room

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:phone_number, :string)
    field(:description, :string)
    coherence_schema()

    has_many(:rooms, Room)

    timestamps()
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name email phone_number description)a ++ coherence_fields())
    |> validate_required([:name, :email])
    |> validate_length(:name, min: 1, max: 100)
    |> validate_length(:email, min: 1, max: 200)
    |> validate_length(:phone_number, min: 1, max: 20)
    |> validate_length(:description, min: 1, max: 200)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_coherence(params)
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t(), atom) :: Ecto.Changeset.t()
  def changeset(model, params, :password) do
    model
    |> cast(
      params,
      ~w(password password_confirmation reset_password_token reset_password_sent_at)a
    )
    |> validate_coherence_password_reset(params)
  end

  def changeset(model, params, :registration) do
    changeset = changeset(model, params)

    if Config.get(:confirm_email_updates) && Map.get(params, "email", false) && model.id do
      changeset
      |> put_change(:unconfirmed_email, get_change(changeset, :email))
      |> delete_change(:email)
    else
      changeset
    end
  end
end
