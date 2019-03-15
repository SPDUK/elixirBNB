defmodule Elixirbnb.RentalsTest do
  use Elixirbnb.DataCase

  alias Elixirbnb.Rentals

  describe "rooms" do
    alias Elixirbnb.Rentals.Room

    @valid_attrs %{accommodate: 42, active: true, address: "some address", bath_room: 42, bed_room: 42, home_type: "some home_type", is_air: true, is_heating: true, is_internet: true, is_kitchen: true, is_tv: true, listing_name: "some listing_name", price: 42, room_type: "some room_type", summary: "some summary"}
    @update_attrs %{accommodate: 43, active: false, address: "some updated address", bath_room: 43, bed_room: 43, home_type: "some updated home_type", is_air: false, is_heating: false, is_internet: false, is_kitchen: false, is_tv: false, listing_name: "some updated listing_name", price: 43, room_type: "some updated room_type", summary: "some updated summary"}
    @invalid_attrs %{accommodate: nil, active: nil, address: nil, bath_room: nil, bed_room: nil, home_type: nil, is_air: nil, is_heating: nil, is_internet: nil, is_kitchen: nil, is_tv: nil, listing_name: nil, price: nil, room_type: nil, summary: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rentals.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Rentals.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Rentals.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Rentals.create_room(@valid_attrs)
      assert room.accommodate == 42
      assert room.active == true
      assert room.address == "some address"
      assert room.bath_room == 42
      assert room.bed_room == 42
      assert room.home_type == "some home_type"
      assert room.is_air == true
      assert room.is_heating == true
      assert room.is_internet == true
      assert room.is_kitchen == true
      assert room.is_tv == true
      assert room.listing_name == "some listing_name"
      assert room.price == 42
      assert room.room_type == "some room_type"
      assert room.summary == "some summary"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rentals.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Rentals.update_room(room, @update_attrs)
      assert room.accommodate == 43
      assert room.active == false
      assert room.address == "some updated address"
      assert room.bath_room == 43
      assert room.bed_room == 43
      assert room.home_type == "some updated home_type"
      assert room.is_air == false
      assert room.is_heating == false
      assert room.is_internet == false
      assert room.is_kitchen == false
      assert room.is_tv == false
      assert room.listing_name == "some updated listing_name"
      assert room.price == 43
      assert room.room_type == "some updated room_type"
      assert room.summary == "some updated summary"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Rentals.update_room(room, @invalid_attrs)
      assert room == Rentals.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Rentals.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Rentals.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Rentals.change_room(room)
    end
  end
end
