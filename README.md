# 📋 Todo List com Elixir e Phoenix LiveView

<div align="center">

![Elixir](https://img.shields.io/badge/Elixir-v1.19.4-purple)
![Phoenix](https://img.shields.io/badge/Phoenix-v1.8.3-orange)
![LiveView](https://img.shields.io/badge/LiveView-v1.1.19-blue)
![SQLite](https://img.shields.io/badge/SQLite-v0.22.0-lightblue)
![Tailwind CSS](https://img.shields.io/badge/Tailwind%20CSS-v4.1-cyan)

Uma aplicação web moderna e reativa para gerenciamento de tarefas, construída com **Elixir**, **Phoenix LiveView** e **SQLite**, utilizando um design profissional com **Tailwind CSS**.

[Sobre](#sobre) • [Tecnologias](#-tecnologias) • [Demonstração](#-demonstração) • [Como Rodar](#-como-rodar) • [Estrutura do Projeto](#-estrutura-do-projeto) • [Funcionalidades](#-funcionalidades) • [Histórico de Commits](#-histórico-de-commits)

</div>

---

## 📝 Sobre

**Aluno:** Daniel Nunes Duartes

Este projeto é uma implementação completa de um aplicativo Todo List desenvolvido como atividade acadêmica. Ele demonstra a construção incremental de uma aplicação web full-stack utilizando **Phoenix LiveView**, um framework revolucionário que permite construir aplicações web reativas e em tempo real sem a necessidade de JavaScript adicional.

O projeto segue a arquitetura proposta no tutorial [Como Criar um App Todo List com Elixir e LiveView do Zero](https://www.notion.so/Como-Criar-um-App-Todo-List-com-Elixir-e-LiveView-do-Zero-2a8cce97509380eba53fc82bbeb08435?pvs=21), passando por várias fases de desenvolvimento: setup inicial, lógica em memória, persistência com Ecto, refinamentos e estilização moderna.

---

## 🎬 Demonstração

Assista a um vídeo demonstrativo da aplicação em funcionamento:

📹 **[Video de Demonstração](./video/)** - Confira o sistema em ação, incluindo a interface moderna, adicionar tarefas, marcar como concluído e deletar tarefas.

---

## 🛠 Tecnologias

| Tecnologia | Versão | Descrição |
|-----------|--------|-----------|
| **Elixir** | 1.19.4 | Linguagem funcional com foco em concorrência e tolerância a falhas |
| **Erlang/OTP** | 27.0+ | Runtime robusta que alimenta o Elixir |
| **Phoenix** | 1.8.3 | Framework web moderno para Elixir |
| **Phoenix LiveView** | 1.1.19 | Biblioteca para criar interfaces web reativas em tempo real |
| **Ecto** | 3.13 | Biblioteca de mapeamento objeto-relacional (ORM) |
| **SQLite** | 0.22.0 | Banco de dados leve e embutido |
| **Tailwind CSS** | 4.1 | Framework CSS utilitário para design moderno |
| **Node.js** | 16.0+ | Runtime JavaScript para ferramentas de build |

---

## ✨ Funcionalidades

- ✅ **Criar Tarefas** - Adicione novas tarefas com um clique
- ✅ **Marcar como Concluída** - Alterne o status de conclusão das tarefas
- ✅ **Deletar Tarefas** - Remova tarefas que não são mais necessárias
- ✅ **Persistência em Banco de Dados** - Todas as tarefas são salvas em SQLite
- ✅ **Interface Reativa** - Atualizações em tempo real via WebSockets
- ✅ **Design Responsivo** - Interface moderna com Tailwind CSS
- ✅ **Estatísticas** - Acompanhe o progresso com barra visual de conclusão
- ✅ **UX Refinada** - Animações suaves, efeitos hover e feedback visual

---

## 🚀 Como Rodar

### Pré-requisitos

Antes de começar, certifique-se de ter os seguintes softwares instalados em sua máquina:

- **Elixir 1.14+** e **Erlang/OTP 24+**
  - Baixar em: https://elixir-lang.org/install.html
  - Guia de instalação no Windows: https://elixir-lang.org/install.html#windows
  
- **Node.js 16+** (para ferramentas de build)
  - Baixar em: https://nodejs.org/

- **Git** (para controle de versão)
  - Baixar em: https://git-scm.com/

**Verificar instalação:**
```bash
elixir --version
erlang --version
node --version
git --version
```

### Passo 1: Clonar o Repositório

```bash
git clone https://github.com/danielduartt/elixir-liveview-todo-list.git
cd elixir-liveview-todo-list
```

### Passo 2: Instalar Dependências

```bash
# Instala todas as dependências do projeto
mix deps.get

# Compila as dependências e o projeto
mix compile
```

### Passo 3: Preparar o Banco de Dados

```bash
# Cria o banco de dados SQLite
mix ecto.create

# Executa as migrations (alterações no banco)
mix ecto.migrate
```

### Passo 4: Iniciar o Servidor

```bash
# Inicia o servidor Phoenix em modo desenvolvimento
mix phx.server
```

Você deverá ver uma saída similar a:
```
[info] Running ElixirLiveviewTodoListWeb.Endpoint with Bandit 1.9.0 at 127.0.0.1:4000 (http)
[info] Access ElixirLiveviewTodoListWeb.Endpoint at http://localhost:4000
```

### Passo 5: Acessar a Aplicação

Abra seu navegador e acesse:
```
http://localhost:4000
```

---

## 📁 Estrutura do Projeto

```
elixir-liveview-todo-list/
├── assets/                          # Arquivos de frontend (CSS, JS)
│   ├── css/
│   │   └── app.css                 # Estilos principais (Tailwind)
│   └── js/
│       └── app.js                  # JavaScript da aplicação
│
├── config/                          # Configurações da aplicação
│   ├── config.exs                  # Config compartilhada
│   ├── dev.exs                     # Config desenvolvimento
│   ├── prod.exs                    # Config produção
│   └── test.exs                    # Config testes
│
├── lib/
│   ├── elixir_liveview_todo_list/
│   │   ├── application.ex          # Supervisor principal
│   │   ├── repo.ex                 # Conexão com banco de dados
│   │   └── todo/
│   │       └── task.ex             # Schema Ecto para tarefas
│   │
│   └── elixir_liveview_todo_list_web/
│       ├── endpoint.ex             # Endpoint Phoenix
│       ├── router.ex               # Rotas da aplicação
│       ├── live/
│       │   └── todo_live.ex        # LiveView principal (CRUD)
│       └── components/
│           ├── layouts/
│           │   ├── app.html.heex   # Layout base
│           │   └── root.html.heex  # HTML root
│           └── core_components.ex  # Componentes reutilizáveis
│
├── priv/
│   └── repo/
│       └── migrations/             # Migrations do Ecto
│           └── *_create_tasks.exs  # Criar tabela de tarefas
│
├── test/                           # Testes automatizados
├── mix.exs                         # Dependências e config do Mix
├── mix.lock                        # Lock das versões (gerado automaticamente)
├── README.md                       # Este arquivo
└── .gitignore                      # Arquivos ignorados pelo Git
```

### Arquivos Principais

#### `lib/elixir_liveview_todo_list/todo/task.ex`
Define o schema **Task** que representa uma tarefa no banco de dados:
- `title` (string): Título da tarefa
- `completed` (boolean): Status de conclusão
- `inserted_at` (datetime): Data de criação
- `updated_at` (datetime): Data de atualização

#### `lib/elixir_liveview_todo_list_web/live/todo_live.ex`
O coração da aplicação. É um **LiveView** que:
- Renderiza a interface HTML
- Gerencia o estado das tarefas
- Responde a eventos do usuário (criar, atualizar, deletar)
- Comunica com o banco via **Repo** do Ecto

---

## 🔄 Histórico de Commits

O repositório segue um histórico de commits incremental que reflete as fases de desenvolvimento:

```
Fase 0: Setup - Inicializa o repositório e .gitignore
Fase 0: Gera o esqueleto do Phoenix com LiveView (sem Ecto)
Fase 1: Prova de Vida - Substitui a rota raiz por TodoLive
Fase 2: Lógica em Memória - Implementa adição de tarefas (Abordagem Simples)
Fase 3: Persistência - Configura Ecto, Repo, Migrations e Task Schema
Fase 3: Refatora TodoLive para usar Ecto, Repo e to_form()
Fase 5: Implementa exclusão de tarefas (delete)
Fase 6: Implementa conclusão de tarefas (toggle_complete)
Estilização Moderna - Design profissional com Tailwind gradient, glassmorphism e animações
```

Para visualizar o histórico completo:
```bash
git log --oneline
```

---

## 🧪 Testes (Opcional)

Para rodar os testes automatizados:
```bash
mix test
```

---

## 📚 Recursos Úteis

- **Documentação Official do Phoenix:** https://hexdocs.pm/phoenix/
- **Guia do Phoenix LiveView:** https://hexdocs.pm/phoenix_live_view/
- **Documentação do Ecto:** https://hexdocs.pm/ecto/
- **Tailwind CSS Docs:** https://tailwindcss.com/docs
- **Elixir School:** https://elixirschool.com/pt/
- **Forum Elixir:** https://elixirforum.com/

---

## 📝 Licença

Este projeto é fornecido como material educacional e está disponível sob a licença MIT.

---

## 🤝 Contribuições

Este é um projeto acadêmico. Para sugestões ou melhorias, abra uma issue ou um pull request.

---

