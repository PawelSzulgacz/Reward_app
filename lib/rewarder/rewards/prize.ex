defmodule Rewarder.Rewards.Prize do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prizes" do
    field :description, :string
    field :cost, :integer
    field :active, :boolean, default: true
  end

  @doc false
  def changeset(prize, attrs \\ %{}) do
    prize
    |> cast(attrs, [:description, :cost, :active])
    |> validate_required([:description, :cost, :active])
  end
end
