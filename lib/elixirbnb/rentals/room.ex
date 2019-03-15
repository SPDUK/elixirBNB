defmodule Elixirbnb.Rentals.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Elixirbnb.Coherence.User

  schema "rooms" do
    field :accommodate, :integer
    field :active, :boolean, default: false
    field :address, :string
    field :bath_room, :integer
    field :bed_room, :integer
    field :home_type, :string
    field :is_air, :boolean, default: false
    field :is_heating, :boolean, default: false
    field :is_internet, :boolean, default: false
    field :is_kitchen, :boolean, default: false
    field :is_tv, :boolean, default: false
    field :listing_name, :string
    field :price, :integer
    field :room_type, :string
    field :summary, :string
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [
      :home_type,
      :room_type,
      :accommodate,
      :bed_room,
      :bath_room,
      :listing_name,
      :summary,
      :address,
      :is_tv,
      :is_kitchen,
      :is_air,
      :is_heating,
      :is_internet,
      :price,
      :active
    ])
    |> validate_required([
      :home_type,
      :room_type,
      :accommodate,
      :bed_room,
      :bath_room,
      :listing_name,
      :summary,
      :address
    ])
    |> validate_length(:listing_name, min: 1, max: 50)
    |> validate_length(:summary, min: 1, max: 500)
  end
end
