defmodule Rewarder.Repo.Migrations.CreatePrizes do
  use Ecto.Migration

  def change do
    create table(:prizes) do
      add :description, :string
      add :cost, :integer
      add :active, :boolean, default: true
    end
  end
end
