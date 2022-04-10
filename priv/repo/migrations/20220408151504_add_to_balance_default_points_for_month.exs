defmodule Rewarder.Repo.Migrations.AddToBalanceDefaultPointsForMonth do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :month_points, :integer, default: 50
    end
  end
end
