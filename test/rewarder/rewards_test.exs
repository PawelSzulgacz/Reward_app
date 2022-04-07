defmodule Rewarder.RewardsTest do
  use Rewarder.DataCase

  alias Rewarder.Rewards

  describe "prizes" do
    alias Rewarder.Rewards.Prize

    import Rewarder.RewardsFixtures

    @invalid_attrs %{cost: nil, description: nil}

    test "list_prizes/0 returns all prizes" do
      prize = prize_fixture()
      assert Rewards.list_prizes() == [prize]
    end

    test "get_prize!/1 returns the prize with given id" do
      prize = prize_fixture()
      assert Rewards.get_prize!(prize.id) == prize
    end

    test "create_prize/1 with valid data creates a prize" do
      valid_attrs = %{cost: 42, description: "some description"}

      assert {:ok, %Prize{} = prize} = Rewards.create_prize(valid_attrs)
      assert prize.cost == 42
      assert prize.description == "some description"
    end

    test "create_prize/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rewards.create_prize(@invalid_attrs)
    end

    test "update_prize/2 with valid data updates the prize" do
      prize = prize_fixture()
      update_attrs = %{cost: 43, description: "some updated description"}

      assert {:ok, %Prize{} = prize} = Rewards.update_prize(prize, update_attrs)
      assert prize.cost == 43
      assert prize.description == "some updated description"
    end

    test "update_prize/2 with invalid data returns error changeset" do
      prize = prize_fixture()
      assert {:error, %Ecto.Changeset{}} = Rewards.update_prize(prize, @invalid_attrs)
      assert prize == Rewards.get_prize!(prize.id)
    end

    test "delete_prize/1 deletes the prize" do
      prize = prize_fixture()
      assert {:ok, %Prize{}} = Rewards.delete_prize(prize)
      assert_raise Ecto.NoResultsError, fn -> Rewards.get_prize!(prize.id) end
    end

    test "change_prize/1 returns a prize changeset" do
      prize = prize_fixture()
      assert %Ecto.Changeset{} = Rewards.change_prize(prize)
    end
  end

  describe "prize_histories" do
    alias Rewarder.Rewards.Prize_history

    import Rewarder.RewardsFixtures

    @invalid_attrs %{cost: nil, description: nil, user_id: nil}

    test "list_prize_histories/0 returns all prize_histories" do
      prize_history = prize_history_fixture()
      assert Rewards.list_prize_histories() == [prize_history]
    end

    test "get_prize_history!/1 returns the prize_history with given id" do
      prize_history = prize_history_fixture()
      assert Rewards.get_prize_history!(prize_history.id) == prize_history
    end

    test "create_prize_history/1 with valid data creates a prize_history" do
      valid_attrs = %{cost: 42, description: "some description", user_id: 42}

      assert {:ok, %Prize_history{} = prize_history} = Rewards.create_prize_history(valid_attrs)
      assert prize_history.cost == 42
      assert prize_history.description == "some description"
      assert prize_history.user_id == 42
    end

    test "create_prize_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rewards.create_prize_history(@invalid_attrs)
    end

    test "update_prize_history/2 with valid data updates the prize_history" do
      prize_history = prize_history_fixture()
      update_attrs = %{cost: 43, description: "some updated description", user_id: 43}

      assert {:ok, %Prize_history{} = prize_history} = Rewards.update_prize_history(prize_history, update_attrs)
      assert prize_history.cost == 43
      assert prize_history.description == "some updated description"
      assert prize_history.user_id == 43
    end

    test "update_prize_history/2 with invalid data returns error changeset" do
      prize_history = prize_history_fixture()
      assert {:error, %Ecto.Changeset{}} = Rewards.update_prize_history(prize_history, @invalid_attrs)
      assert prize_history == Rewards.get_prize_history!(prize_history.id)
    end

    test "delete_prize_history/1 deletes the prize_history" do
      prize_history = prize_history_fixture()
      assert {:ok, %Prize_history{}} = Rewards.delete_prize_history(prize_history)
      assert_raise Ecto.NoResultsError, fn -> Rewards.get_prize_history!(prize_history.id) end
    end

    test "change_prize_history/1 returns a prize_history changeset" do
      prize_history = prize_history_fixture()
      assert %Ecto.Changeset{} = Rewards.change_prize_history(prize_history)
    end
  end
end
