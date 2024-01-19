defmodule Discuss.Schemas.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :description, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title, :description])
    # |> validate_required([:description], message: "Description is required")
    # |> validate_required([:title], message: "Title is required")
    |> validate_required([:title, :description])
  end
end
