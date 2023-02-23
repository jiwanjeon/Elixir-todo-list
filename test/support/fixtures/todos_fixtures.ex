defmodule TodoPractice.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoPractice.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        complete: true,
        priority: "some priority",
        title: "some title"
      })
      |> TodoPractice.Todos.create_todo()

    todo
  end
end
