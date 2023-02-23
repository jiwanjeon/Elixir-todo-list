defmodule TodoPracticeWeb.PageController do
  use TodoPracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
