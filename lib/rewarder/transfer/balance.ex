defmodule Rewarder.Transfer.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    belongs_to :user, Rewarder.Accounts.User
    field :to_give, :integer, default: 50
    field :gathered, :integer, default: 0

  end

  @doc false
  def changeset(balance, attrs \\ %{}) do
    balance
    |> cast(attrs, [:user_id])
    |> validate_required([])
  end
end
