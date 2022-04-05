defmodule Rewarder.Repo.Migrations.TableWithTransfers do
  use Ecto.Migration

  def change do
    create table(:transfer) do
      add :giver_id, references(:balances)
      add :taker_id, references(:balances)
      add :quantity, :integer
      timestamps()
    end
  end
end
