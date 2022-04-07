defmodule Rewarder.Repo.Migrations.CreatePrizeHistories do
  use Ecto.Migration

  def change do
    create table(:prize_histories) do
      add :reward_id, references(:prizes)
      add :user_id, :integer
      add :cost, :integer

      timestamps()
    end
  end
end
