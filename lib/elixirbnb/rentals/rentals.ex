defmodule Elixirbnb.Rentals do
  @moduledoc """
  The Rentals context.
  """

  import Ecto.Query, warn: false
  alias Elixirbnb.Repo
  alias Elixirbnb.Coherence.User
  alias Elixirbnb.Rentals.Room

  @doc """
  Returns the list of rooms for the current user.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms(%User{} = user) do
    user_rooms_query(Room, user)
    |> Repo.all()
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}, %User{} = user) do
    %Room{}
    |> Room.changeset(attrs)
    |> put_user(user)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end

  defp user_rooms_query(rooms, %User{id: user_id}) do
    from(r in rooms, where: r.user_id == ^user_id)
  end

  defp put_user(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :user, user)
  end

  defp preload_user(room) do
    Repo.preload(room, :user)
  end
end
