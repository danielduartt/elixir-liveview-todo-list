defmodule ElixirLiveviewTodoListWeb.TodoLive do
  use ElixirLiveviewTodoListWeb, :live_view

  # Importamos o Repo e o Schema Task para usar aqui
  alias ElixirLiveviewTodoList.Repo
  alias ElixirLiveviewTodoList.Todo.Task

  # 1. MOUNT: Carrega tarefas do Banco de Dados
  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      # Busca todas as tarefas reais no banco
      tasks = Repo.all(Task)
      {:ok, assign(socket, tasks: tasks, new_task_title: "")}
    else
      # Primeira renderização (HTML estático)
      {:ok, assign(socket, tasks: [], new_task_title: "")}
    end
  end

  # 2. RENDER: O HTML da página
  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full max-w-lg mx-auto mt-12 p-6 bg-white rounded-lg shadow-md">
      <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">
        Minha Lista de Tarefas
      </h1>

      <%!-- Formulário de Criação --%>
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

      <%!-- Lista de Tarefas --%>
      <div class="mt-8">
        <ul id="task-list">
          <li :for={task <- @tasks} class="flex justify-between items-center p-3 border-b">
            <%!-- 
              Transformamos a tarefa em um formulário para poder usar o checkbox. 
              O 'to_form' prepara os dados para o componente de input.
            --%>
            <% task_form = to_form(Task.changeset(task, %{})) %>

            <.form for={task_form} phx-change="toggle_complete" phx-value-id={task.id} class="flex-grow">
              <div class="flex items-center space-x-4">
                <.input 
                  type="checkbox" 
                  field={task_form[:completed]} 
                  class="flex-shrink-0 w-5 h-5 text-blue-600 rounded focus:ring-blue-500" 
                />
                
                <span class={if task.completed, do: "line-through text-gray-400", else: "text-gray-900"}>
                  <%= task.title %>
                </span>
              </div>
            </.form>

            <.button
              type="button"
              phx-click="delete"
              phx-value-id={task.id}
              class="!p-1 !bg-red-500 hover:!bg-red-700 ml-2"
            >
              &times;
            </.button>
          </li>
        </ul>
        <p :if={@tasks == []} class="text-center text-gray-400 mt-4">
          Nenhuma tarefa por enquanto...
        </p>
      </div>
    </div>
    """
  end

  # 3. HANDLERS: Lógica de Negócio

  # --- ESTA FUNÇÃO ESTAVA FALTANDO ---
  # Atualiza o campo de input enquanto digita
  @impl true
  def handle_event("update_form", %{"title" => new_title}, socket) do
    {:noreply, assign(socket, new_task_title: new_title)}
  end

  # Atualiza o status de completado (Checkbox)
  @impl true
  def handle_event("toggle_complete", %{"id" => id, "task" => task_params}, socket) do
    # 1. Busca a tarefa
    task = Repo.get!(Task, id)

    # 2. Atualiza usando o changeset (converte "true"/"false" para boolean automaticamente)
    {:ok, _updated_task} =
      task
      |> Task.changeset(task_params)
      |> Repo.update()

    # 3. Recarrega a lista
    tasks = Repo.all(Task)
    {:noreply, assign(socket, tasks: tasks)}
  end

  # Salva no Banco de Dados (INSERT)
  @impl true
  def handle_event("save_task", %{"title" => title}, socket) do
    title = String.trim(title)

    if title != "" do
      # Cria a changeset e insere no banco
      %Task{}
      |> Task.changeset(%{title: title})
      |> Repo.insert()

      # Recarrega a lista do banco para atualizar a tela
      tasks = Repo.all(Task)
      {:noreply, assign(socket, tasks: tasks, new_task_title: "")}
    else
      {:noreply, socket}
    end
  end

  # Deleta do Banco de Dados (DELETE)
  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    # 1. Busca a tarefa pelo ID
    task = Repo.get(Task, id)

    # 2. Deleta se ela existir
    if task, do: Repo.delete(task)

    # 3. Recarrega a lista atualizada
    tasks = Repo.all(Task)
    {:noreply, assign(socket, tasks: tasks)}
  end
end