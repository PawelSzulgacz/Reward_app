defmodule Rewarder.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances) do
      add :user_id, references(:users)
      add :to_give, :integer, default: 50
      add :gathered, :integer, default: 0
    end
  end
end
