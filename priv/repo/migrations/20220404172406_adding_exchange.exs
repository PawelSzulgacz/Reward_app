defmodule Rewarder.Repo.Migrations.AddingExchange do
  use Ecto.Migration

  def change do
    create table(:exchanges) do
      add :giver_id, :integer
      add :taker_id, :integer
      add :quantity, :integer
      timestamps()
    end
  end
end
