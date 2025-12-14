defmodule ElixirLiveviewTodoList.Repo do
  use Ecto.Repo,
    otp_app: :elixir_liveview_todo_list,
    adapter: Ecto.Adapters.SQLite3
end