defmodule Auth.Repo.Migrations.MoviesEdit do
  use Ecto.Migration

  def change do
    alter table(:movies) do
      remove :updated_at
      remove :inserted_at
    end
  end
end
