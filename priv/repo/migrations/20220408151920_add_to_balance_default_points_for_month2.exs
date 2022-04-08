defmodule Rewarder.Repo.Migrations.AddToBalanceDefaultPointsForMonth2 do
  use Ecto.Migration

  def change do
    alter table(:balances) do
      add :month_points, :integer, default: 50
    end
  end
end
