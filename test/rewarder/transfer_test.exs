defmodule Rewarder.TransferTest do
  use Rewarder.DataCase

  alias Rewarder.Transfer

  describe "balances" do
    alias Rewarder.Transfer.Balance

    import Rewarder.TransferFixtures

    @invalid_attrs %{}

    test "list_balances/0 returns all balances" do
      balance = balance_fixture()
      assert Transfer.list_balances() == [balance]
    end

    test "get_balance!/1 returns the balance with given id" do
      balance = balance_fixture()
      assert Transfer.get_balance!(balance.id) == balance
    end

    test "create_balance/1 with valid data creates a balance" do
      valid_attrs = %{}

      assert {:ok, %Balance{} = balance} = Transfer.create_balance(valid_attrs)
    end

    test "create_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transfer.create_balance(@invalid_attrs)
    end

    test "update_balance/2 with valid data updates the balance" do
      balance = balance_fixture()
      update_attrs = %{}

      assert {:ok, %Balance{} = balance} = Transfer.update_balance(balance, update_attrs)
    end

    test "update_balance/2 with invalid data returns error changeset" do
      balance = balance_fixture()
      assert {:error, %Ecto.Changeset{}} = Transfer.update_balance(balance, @invalid_attrs)
      assert balance == Transfer.get_balance!(balance.id)
    end

    test "delete_balance/1 deletes the balance" do
      balance = balance_fixture()
      assert {:ok, %Balance{}} = Transfer.delete_balance(balance)
      assert_raise Ecto.NoResultsError, fn -> Transfer.get_balance!(balance.id) end
    end

    test "change_balance/1 returns a balance changeset" do
      balance = balance_fixture()
      assert %Ecto.Changeset{} = Transfer.change_balance(balance)
    end
  end

  describe "exchanges" do
    alias Rewarder.Transfer.Exchange

    import Rewarder.TransferFixtures

    @invalid_attrs %{giver_id: nil, quantity: nil, taker_id: nil}

    test "list_exchanges/0 returns all exchanges" do
      exchange = exchange_fixture()
      assert Transfer.list_exchanges() == [exchange]
    end

    test "get_exchange!/1 returns the exchange with given id" do
      exchange = exchange_fixture()
      assert Transfer.get_exchange!(exchange.id) == exchange
    end

    test "create_exchange/1 with valid data creates a exchange" do
      valid_attrs = %{giver_id: 42, quantity: 42, taker_id: 42}

      assert {:ok, %Exchange{} = exchange} = Transfer.create_exchange(valid_attrs)
      assert exchange.giver_id == 42
      assert exchange.quantity == 42
      assert exchange.taker_id == 42
    end

    test "create_exchange/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transfer.create_exchange(@invalid_attrs)
    end

    test "update_exchange/2 with valid data updates the exchange" do
      exchange = exchange_fixture()
      update_attrs = %{giver_id: 43, quantity: 43, taker_id: 43}

      assert {:ok, %Exchange{} = exchange} = Transfer.update_exchange(exchange, update_attrs)
      assert exchange.giver_id == 43
      assert exchange.quantity == 43
      assert exchange.taker_id == 43
    end

    test "update_exchange/2 with invalid data returns error changeset" do
      exchange = exchange_fixture()
      assert {:error, %Ecto.Changeset{}} = Transfer.update_exchange(exchange, @invalid_attrs)
      assert exchange == Transfer.get_exchange!(exchange.id)
    end

    test "delete_exchange/1 deletes the exchange" do
      exchange = exchange_fixture()
      assert {:ok, %Exchange{}} = Transfer.delete_exchange(exchange)
      assert_raise Ecto.NoResultsError, fn -> Transfer.get_exchange!(exchange.id) end
    end

    test "change_exchange/1 returns a exchange changeset" do
      exchange = exchange_fixture()
      assert %Ecto.Changeset{} = Transfer.change_exchange(exchange)
    end
  end
end
