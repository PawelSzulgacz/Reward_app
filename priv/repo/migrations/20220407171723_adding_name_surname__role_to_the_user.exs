defmodule Rewarder.Repo.Migrations.AddingNameSurnameRoleToTheUser do
  use Ecto.Migration

  def change do
    alter table(:prize_histories) do
      add :name, :string
      add :surname, :string
      add :role, :string
    end
  end
end
