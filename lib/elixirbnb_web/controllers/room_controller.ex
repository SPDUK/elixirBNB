defmodule ElixirbnbWeb.RoomController do
  use ElixirbnbWeb, :controller

  alias Elixirbnb.Rentals
  alias Elixirbnb.Rentals.Room

  def index(conn, _params, current_user) do
    rooms =
      current_user
      |> Rentals.list_rooms()

    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params, _current_user) do
    changeset = Rentals.change_room(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}, current_user) do
    case Rentals.create_room(room_params, current_user) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: Routes.room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _current_user) do
    room = Rentals.get_room!(id)
    render(conn, "show.html", room: room)
  end

  def edit(conn, %{"id" => id}, _current_user) do
    room = Rentals.get_room!(id)
    changeset = Rentals.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}, _current_user) do
    room = Rentals.get_room!(id)

    case Rentals.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: Routes.room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _current_user) do
    room = Rentals.get_room!(id)
    {:ok, _room} = Rentals.delete_room(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: Routes.room_path(conn, :index))
  end

  @doc """
  Apply the current user to each route in the room_controller as a 3rd argument
  """
  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
