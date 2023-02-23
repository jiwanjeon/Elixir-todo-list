+./0defmodule TodoPractice.Repo.Migrations.Creat['0[0[0
;':?;/
;
eTodos do
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
-9[p[\\\]]
