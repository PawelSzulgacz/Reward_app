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
end
