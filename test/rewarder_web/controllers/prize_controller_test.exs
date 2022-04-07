defmodule RewarderWeb.PrizeControllerTest do
  use RewarderWeb.ConnCase

  import Rewarder.RewardsFixtures

  @create_attrs %{cost: 42, description: "some description"}
  @update_attrs %{cost: 43, description: "some updated description"}
  @invalid_attrs %{cost: nil, description: nil}

  describe "index" do
    test "lists all prizes", %{conn: conn} do
      conn = get(conn, Routes.prize_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Prizes"
    end
  end

  describe "new prize" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.prize_path(conn, :new))
      assert html_response(conn, 200) =~ "New Prize"
    end
  end

  describe "create prize" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.prize_path(conn, :create), prize: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.prize_path(conn, :show, id)

      conn = get(conn, Routes.prize_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Prize"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.prize_path(conn, :create), prize: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Prize"
    end
  end

  describe "edit prize" do
    setup [:create_prize]

    test "renders form for editing chosen prize", %{conn: conn, prize: prize} do
      conn = get(conn, Routes.prize_path(conn, :edit, prize))
      assert html_response(conn, 200) =~ "Edit Prize"
    end
  end

  describe "update prize" do
    setup [:create_prize]

    test "redirects when data is valid", %{conn: conn, prize: prize} do
      conn = put(conn, Routes.prize_path(conn, :update, prize), prize: @update_attrs)
      assert redirected_to(conn) == Routes.prize_path(conn, :show, prize)

      conn = get(conn, Routes.prize_path(conn, :show, prize))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, prize: prize} do
      conn = put(conn, Routes.prize_path(conn, :update, prize), prize: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Prize"
    end
  end

  describe "delete prize" do
    setup [:create_prize]

    test "deletes chosen prize", %{conn: conn, prize: prize} do
      conn = delete(conn, Routes.prize_path(conn, :delete, prize))
      assert redirected_to(conn) == Routes.prize_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.prize_path(conn, :show, prize))
      end
    end
  end

  defp create_prize(_) do
    prize = prize_fixture()
    %{prize: prize}
  end
end
