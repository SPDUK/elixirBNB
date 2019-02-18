defmodule Elixirbnb.Repo.Migrations.AddExtraFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :phone_number, :string
      add :description, :text
    end
  end
end
