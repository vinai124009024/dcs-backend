defmodule Auth.Repo.Migrations.Movies do
  use Ecto.Migration

  def change do

    create table(:movies, primary_key: false) do
      add :name, :string
      add :author, :string
      add :edited_at, :naive_datetime
      timestamps()
    end

  end
end
