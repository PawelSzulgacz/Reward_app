defmodule Rewarder.RewardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewarder.Rewards` context.
  """

  @doc """
  Generate a prize.
  """
  def prize_fixture(attrs \\ %{}) do
    {:ok, prize} =
      attrs
      |> Enum.into(%{
        cost: 42,
        description: "some description"
      })
      |> Rewarder.Rewards.create_prize()

    prize
  end

  @doc """
  Generate a prize_history.
  """
  def prize_history_fixture(attrs \\ %{}) do
    {:ok, prize_history} =
      attrs
      |> Enum.into(%{
        cost: 42,
        description: "some description",
        user_id: 42
      })
      |> Rewarder.Rewards.create_prize_history()

    prize_history
  end
end
