defmodule Auth.Repo.Migrations.MoviesId do
  use Ecto.Migration

  def change do
    alter table(:movies) do
      add :id, :binary_id, primary_key: true
    end
  end
end
