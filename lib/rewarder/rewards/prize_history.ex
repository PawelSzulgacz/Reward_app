defmodule Rewarder.Rewards.Prize_history do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prize_histories" do
    field :reward_id, :integer
    field :user_id, :integer
    timestamps()
  end

  @doc false
  def changeset(prize_history, attrs \\ %{}) do
    prize_history
    |> cast(attrs, [:reward_id, :user_id])
    |> validate_required([:reward_id, :user_id])
  end
end
