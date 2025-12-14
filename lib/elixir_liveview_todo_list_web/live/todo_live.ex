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
    <div class="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 py-12 px-4 sm:px-6 lg:px-8">
      <div class="w-full max-w-2xl mx-auto">
        <%!-- Header --%>
        <div class="mb-8 text-center">
          <h1 class="text-4xl sm:text-5xl font-bold text-white mb-2">
            Minhas Tarefas
          </h1>
          <p class="text-gray-400 text-lg">Organize e acompanhe seu progresso</p>
        </div>

        <%!-- Card Principal --%>
        <div class="bg-white/10 backdrop-blur-md border border-white/20 rounded-2xl shadow-2xl overflow-hidden">
          <%!-- Formulário de Criação --%>
          <form phx-submit="save_task" phx-change="update_form" class="p-6 sm:p-8 border-b border-white/10">
            <div class="flex flex-col sm:flex-row gap-3">
              <input
                type="text"
                name="title"
                value={@new_task_title}
                placeholder="Adicionar uma nova tarefa..."
                class="flex-1 px-5 py-3 bg-white/10 border border-white/20 text-white placeholder-gray-400 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition"
                autofocus
                autocomplete="off"
              />
              <button 
                type="submit" 
                class="px-6 py-3 bg-gradient-to-r from-purple-500 to-pink-500 text-white font-semibold rounded-lg hover:from-purple-600 hover:to-pink-600 active:scale-95 transition-all duration-200 whitespace-nowrap shadow-lg"
              >
                Adicionar
              </button>
            </div>
          </form>

          <%!-- Lista de Tarefas --%>
          <div class="divide-y divide-white/10" id="task-list">
            <div :if={@tasks == []} class="p-12 text-center">
              <svg class="mx-auto h-12 w-12 text-gray-500 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <p class="text-gray-400 text-lg font-medium">Nenhuma tarefa ainda!</p>
              <p class="text-gray-500 mt-1">Comece adicionando uma tarefa acima</p>
            </div>

            <div :for={task <- @tasks} class="p-5 sm:p-6 hover:bg-white/5 transition-colors duration-150 group">
              <% task_form = to_form(Task.changeset(task, %{})) %>

              <div class="flex items-center gap-4">
                <.form for={task_form} phx-change="toggle_complete" phx-value-id={task.id} class="flex items-center gap-4 flex-1">
                  <div class="relative flex items-center">
                    <.input 
                      type="checkbox" 
                      field={task_form[:completed]} 
                      class="w-6 h-6 rounded-md bg-white/10 border border-white/20 text-purple-500 focus:ring-2 focus:ring-purple-500 focus:ring-offset-0 cursor-pointer transition"
                    />
                  </div>
                  
                  <span class={[
                    "flex-1 text-base transition-all duration-200",
                    if task.completed do
                      "line-through text-gray-500"
                    else
                      "text-white"
                    end
                  ]}>
                    <%= task.title %>
                  </span>
                </.form>

                <button
                  type="button"
                  phx-click="delete"
                  phx-value-id={task.id}
                  class="flex-shrink-0 p-2 text-gray-400 hover:text-red-400 opacity-0 group-hover:opacity-100 transition-all duration-200 rounded-lg hover:bg-red-500/10"
                  title="Deletar tarefa"
                >
                  <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
                  </svg>
                </button>
              </div>
            </div>
          </div>

          <%!-- Footer com Estatísticas --%>
          <% completed_count = Enum.count(@tasks, & &1.completed) %>
          <% total_count = Enum.count(@tasks) %>
          <div :if={total_count > 0} class="px-6 sm:px-8 py-4 bg-white/5 border-t border-white/10">
            <div class="flex justify-between items-center">
              <span class="text-gray-400">
                <span class="font-semibold text-white"><%= completed_count %></span> de <span class="font-semibold text-white"><%= total_count %></span> concluídas
              </span>
              <div class="w-24 bg-white/10 rounded-full h-2">
                <div 
                  class="bg-gradient-to-r from-purple-500 to-pink-500 h-2 rounded-full transition-all duration-500"
                  style={"width: #{if total_count > 0, do: (completed_count * 100 / total_count), else: 0}%"}
                />
              </div>
            </div>
          </div>
        </div>
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