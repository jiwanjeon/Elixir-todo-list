defmodule TodoPractice.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :complete, :boolean, default: false, null: false
      add :priority, :string

      timestamps()
    end
  end
end
