defmodule ElixirLiveviewTodoListWeb.PageController do
  use ElixirLiveviewTodoListWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
