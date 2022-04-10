defmodule Rewarder.Transfer.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    belongs_to :user, Rewarder.Accounts.User
    field :to_give, :integer
    field :gathered, :integer
    field :month_points, :integer
  end

  @doc false
  def changeset(balance, attrs \\ %{}) do
    balance
    |> cast(attrs, [:to_give, :gathered, :month_points])
    |> validate_required([:user_id])
  end
end
