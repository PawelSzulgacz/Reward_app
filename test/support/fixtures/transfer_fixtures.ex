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
end
