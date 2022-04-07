defmodule Rewarder.Repo.Migrations.AddingNameSurnameRoleToTheUser2 do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
      add :surname, :string
      add :role, :string
    end
  end
end
