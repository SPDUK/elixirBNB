defmodule Elixirbnb.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :home_type, :string
      add :room_type, :string
      add :accommodate, :integer
      add :bed_room, :integer
      add :bath_room, :integer
      add :listing_name, :string
      add :summary, :text
      add :address, :string
      add :is_tv, :boolean, default: false, null: false
      add :is_kitchen, :boolean, default: false, null: false
      add :is_air, :boolean, default: false, null: false
      add :is_heating, :boolean, default: false, null: false
      add :is_internet, :boolean, default: false, null: false
      add :price, :integer
      add :active, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:rooms, [:user_id])
  end
end
