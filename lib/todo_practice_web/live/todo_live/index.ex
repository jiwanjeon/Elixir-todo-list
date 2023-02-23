defmodule TodoPracticeWeb.TodoLive.Index do
  use TodoPracticeWeb, :live_view

  alias TodoPractice.Todos
  alias TodoPractice.Todos.Todo

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:filter, "없음")
     |> assign(:todos, list_todos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Todo")
    |> assign(:todo, Todos.get_todo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Todo")
    |> assign(:todo, %Todo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Todos")
    |> assign(:todo, nil)
  end

  def handle_event("filter_all", _value, socket) do
    {:noreply,
     socket
     |> assign(:filter, "모두")
     |> assign(:todos, list_todos())}
  end

  def handle_event("filter_high", _value, socket) do
    {:noreply,
     socket
     |> assign(:filter, "High")
     |> assign(:todos, TodoPractice.Todos.where_priority("High"))}
  end

  def handle_event("filter_middle", _value, socket) do
    {:noreply,
     socket
     |> assign(:filter, "Middle")
     |> assign(:todos, TodoPractice.Todos.where_priority("Middle"))}
  end

  def handle_event("filter_low", _value, socket) do
    {:noreply,
     socket
     |> assign(:filter, "Low")
     |> assign(:todos, TodoPractice.Todos.where_priority("Low"))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    {:ok, _} = Todos.delete_todo(todo)

    {:noreply, assign(socket, :todos, list_todos())}
  end

  defp list_todos do
    Todos.list_todos()
  end
end
