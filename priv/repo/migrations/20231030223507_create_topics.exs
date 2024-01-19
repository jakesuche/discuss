defmodule Discuss.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
