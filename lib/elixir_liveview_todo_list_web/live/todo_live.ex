defmodule ElixirLiveviewTodoListWeb.TodoLive do
  # Aqui usamos O SEU módulo principal
  use ElixirLiveviewTodoListWeb, :live_view

  # mount/3 é o "construtor" do LiveView — chamado quando a página é carregada
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  # render/1 define o HTML que será exibido
  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto mt-10 p-6 bg-white rounded shadow text-center">
      <h1 class="text-3xl font-bold text-purple-700">Meu Todo List (Hello LiveView!)</h1>
      <p class="mt-4 text-gray-600">Fase 1: Prova de Vida Completa!</p>
    </div>
    """
  end
end