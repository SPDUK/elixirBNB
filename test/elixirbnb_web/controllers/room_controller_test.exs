defmodule ElixirbnbWeb.RoomControllerTest do
  use ElixirbnbWeb.ConnCase

  alias Elixirbnb.Rentals

  @create_attrs %{accommodate: 42, active: true, address: "some address", bath_room: 42, bed_room: 42, home_type: "some home_type", is_air: true, is_heating: true, is_internet: true, is_kitchen: true, is_tv: true, listing_name: "some listing_name", price: 42, room_type: "some room_type", summary: "some summary"}
  @update_attrs %{accommodate: 43, active: false, address: "some updated address", bath_room: 43, bed_room: 43, home_type: "some updated home_type", is_air: false, is_heating: false, is_internet: false, is_kitchen: false, is_tv: false, listing_name: "some updated listing_name", price: 43, room_type: "some updated room_type", summary: "some updated summary"}
  @invalid_attrs %{accommodate: nil, active: nil, address: nil, bath_room: nil, bed_room: nil, home_type: nil, is_air: nil, is_heating: nil, is_internet: nil, is_kitchen: nil, is_tv: nil, listing_name: nil, price: nil, room_type: nil, summary: nil}

  def fixture(:room) do
    {:ok, room} = Rentals.create_room(@create_attrs)
    room
  end

  describe "index" do
    test "lists all rooms", %{conn: conn} do
      conn = get(conn, Routes.room_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rooms"
    end
  end

  describe "new room" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.room_path(conn, :new))
      assert html_response(conn, 200) =~ "New Room"
    end
  end

  describe "create room" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.room_path(conn, :create), room: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.room_path(conn, :show, id)

      conn = get(conn, Routes.room_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Room"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.room_path(conn, :create), room: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Room"
    end
  end

  describe "edit room" do
    setup [:create_room]

    test "renders form for editing chosen room", %{conn: conn, room: room} do
      conn = get(conn, Routes.room_path(conn, :edit, room))
      assert html_response(conn, 200) =~ "Edit Room"
    end
  end

  describe "update room" do
    setup [:create_room]

    test "redirects when data is valid", %{conn: conn, room: room} do
      conn = put(conn, Routes.room_path(conn, :update, room), room: @update_attrs)
      assert redirected_to(conn) == Routes.room_path(conn, :show, room)

      conn = get(conn, Routes.room_path(conn, :show, room))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, room: room} do
      conn = put(conn, Routes.room_path(conn, :update, room), room: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Room"
    end
  end

  describe "delete room" do
    setup [:create_room]

    test "deletes chosen room", %{conn: conn, room: room} do
      conn = delete(conn, Routes.room_path(conn, :delete, room))
      assert redirected_to(conn) == Routes.room_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.room_path(conn, :show, room))
      end
    end
  end

  defp create_room(_) do
    room = fixture(:room)
    {:ok, room: room}
  end
end
