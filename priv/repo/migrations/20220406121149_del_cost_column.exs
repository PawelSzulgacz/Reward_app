defmodule Rewarder.Repo.Migrations.DelCostColumn do
  use Ecto.Migration

  def change do
    alter table(:prize_histories) do
      remove :cost
    end
  end
end
