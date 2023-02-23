defmodule TodoPractice.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :complete, :boolean, default: false
    field :priority, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :complete, :priority])
    |> validate_required([:title, :complete, :priority])
  end
end
