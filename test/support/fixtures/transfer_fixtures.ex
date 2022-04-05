defmodule Rewarder.TransferFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewarder.Transfer` context.
  """

  @doc """
  Generate a balance.
  """
  def balance_fixture(attrs \\ %{}) do
    {:ok, balance} =
      attrs
      |> Enum.into(%{

      })
      |> Rewarder.Transfer.create_balance()

    balance
  end

  @doc """
  Generate a exchange.
  """
  def exchange_fixture(attrs \\ %{}) do
    {:ok, exchange} =
      attrs
      |> Enum.into(%{
        giver_id: 42,
        quantity: 42,
        taker_id: 42
      })
      |> Rewarder.Transfer.create_exchange()

    exchange
  end
end
