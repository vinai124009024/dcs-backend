defmodule Auth.Repo.Migrations.Mov do
  use Ecto.Migration

  def change do

    drop table(:movies)

    create table(:movies, primary_key: false) do
      add :name, :string
      add :author, :string
      timestamps()
    end
  end
end
