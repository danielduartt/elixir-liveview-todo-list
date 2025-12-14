defmodule ElixirLiveviewTodoListWeb.TodoLive do
  use ElixirLiveviewTodoListWeb, :live_view

  # 1. MOUNT: Inicializa as variáveis
  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      # Aqui você poderia carregar do banco de dados no futuro
      nil
    end

    socket =
      socket
      |> assign(:new_task_title, "")
      |> assign(:tasks, []) # Começa vazio

    {:ok, socket}
  end

  # 2. RENDER: O HTML da página
  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full max-w-lg mx-auto mt-12 p-6 bg-white rounded-lg shadow-md">
      <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">
        Minha Lista de Tarefas
      </h1>

      <form phx-submit="save_task" phx-change="update_form" class="flex gap-2 mb-6">
        <input
          type="text"
          name="title"
          value={@new_task_title}
          placeholder="O que precisa ser feito?"
          class="flex-grow p-2 border rounded"
          autofocus
          autocomplete="off"
        />
        <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
          Adicionar
        </button>
      </form>

      <div class="mt-8">
        <ul id="task-list">
          <li :for={task <- @tasks} class="flex justify-between items-center p-3 border-b hover:bg-gray-50">
            <span class={if task.completed, do: "line-through text-gray-500", else: "text-gray-900"}>
              <%= task.title %>
            </span>
          </li>
        </ul>
        <p :if={@tasks == []} class="text-center text-gray-400 mt-4">
          Nenhuma tarefa por enquanto...
        </p>
      </div>
    </div>
    """
  end

  # 3. HANDLERS: Lógica

  # Evento de digitar (necessário para o formulário não travar)
  @impl true
  def handle_event("update_form", %{"title" => new_title}, socket) do
    {:noreply, assign(socket, new_task_title: new_title)}
  end

  # Evento de salvar (O código que você mandou agora!)
  @impl true
  def handle_event("save_task", %{"title" => title}, socket) do
    if String.trim(title) != "" do
      new_task = %{
        id: System.unique_integer([:positive]),
        title: title,
        completed: false
      }

      socket =
        socket
        |> update(:tasks, fn tasks -> tasks ++ [new_task] end)
        |> assign(:new_task_title, "")

      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end
end