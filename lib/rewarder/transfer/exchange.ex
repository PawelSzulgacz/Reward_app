defmodule Rewarder.Transfer.Exchange do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exchanges" do
    field :giver_id, :integer
    field :taker_id, :integer
    field :quantity, :integer
    timestamps()
  end

  @doc false
  def changeset(exchange, attrs \\ %{}) do
    exchange
    |> cast(attrs, [:giver_id, :taker_id, :quantity])
    |> validate_required([])
  end
end
