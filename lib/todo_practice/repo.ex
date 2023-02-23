defmodule TodoPractice.Repo do
  use Ecto.Repo,
    otp_app: :todo_practice,
    adapter: Ecto.Adapters.Postgres
end
