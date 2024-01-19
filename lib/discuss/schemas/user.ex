defmodule Discuss.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :provider, :token, :name])
    |> validate_required([:email, :provider, :token, :name])
  end
end

# mix phx.gen.schema Schemas.User user
