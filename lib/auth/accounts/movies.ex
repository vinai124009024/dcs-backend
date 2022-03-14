defmodule Auth.Accounts.Movie do
  use Ecto.Schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "movies" do
    field :name, :string
    field :author, :string
    field :reviews, {:array, :map}
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
     |> Ecto.Changeset.cast(params, [:name, :author, :reviews])
     |> Ecto.Changeset.validate_required([:name])
     |> Ecto.Changeset.validate_required([:author])
  end

end
