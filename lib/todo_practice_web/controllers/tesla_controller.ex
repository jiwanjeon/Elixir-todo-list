defmodule TodoPracticeWeb.TeslaController do
  use TodoPracticeWeb, :controller

  alias TodoPractice.Todos

  # JSON 형태로 모든 TODO Lists를 반환하는 함수입니다.
  def get(conn, _user_input) do
    all_todos = Todos.list_todos()

    json(
      conn,
      Enum.map(all_todos, fn todo ->
        %{
          "title" => "#{todo.title}",
          "complete" => "#{todo.complete}",
          "priority" => "#{todo.priority}"
        }
      end)
    )
  end

  # Todo를 생성할 수 있는 함수입니다.
  def create(
        conn,
        user_input
      ) do
    with {:ok, title} <- map_get(user_input, "title", "You have to input a title"),
         {:ok, completed} <- map_get(user_input, "completed", "You have to input a completed"),
         {:ok, priority} <- map_get(user_input, "priority", "You have to input a priority"),
         {:ok, created_todo} <-
           Todos.create_todo(%{"title" => title, "completed" => completed, "priority" => priority}) do
      IO.puts("성공했습니다 #{created_todo.id}")
      json(conn, %{"result" => "Successfully Make Todo Task"})
    else
      {:error, reason} when is_bitstring(reason) ->
        IO.puts("에러가 발생하였습니다 #{reason}")
        json(conn, %{"result" => "에러가 발생하였습니다 #{reason}"})

      _ ->
        IO.puts("생성 중 에러가 발생하였습니다")
        json(conn, %{"result" => "생성 중 에러가 발생하였습니다"})
    end
  end

  # Todo list 정보를 수정할 수 있는 함수입니다.
  def update(
        conn,
        %{"id" => id} = user_input
      ) do
    original_todo = Todos.get_todo!(id)

    check_user_input_validation =
      Enum.any?(user_input, fn x ->
        x.title == "title" || x.complete == "complete" || x.priority == "priority"
      end)

    case check_user_input_validation do
      true ->
        Todos.update_todo(original_todo, user_input)
        json(conn, %{"result" => "Successfully Update Todo Task"})

      false ->
        json(conn, "Failed to Update Todo Task. You have to check your input value")
    end
    # Todos.update_todo(original_todo, user_input)
    # json(conn, %{"result" => "Successfully Update Todo Task"})
  end

  # Todo list를 지울 수 있는 함수 입니다.
  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    Todos.delete_todo(todo)
    json(conn, %{"result" => "Successfully Delete Todo Task"})
  end

  def map_get(map, key, error_value) do
    case Map.get(map, key) do
      nil -> {:error, error_value}
      value -> {:ok, value}
    end
  end
end
