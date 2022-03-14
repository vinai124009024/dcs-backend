defmodule Auth.Repo.Migrations.Mov2 do
  use Ecto.Migration

  def change do
    alter table(:movies) do
      add :reviews, {:array, :map}
    end
  end
end
