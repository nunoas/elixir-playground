defmodule Todo.Server do
  use GenServer

  defstruct auto_id: 1, entries: %{}

  def init(_) do
    {:ok, Todo.List.new}
  end

  def handle_call({:entries, date}, _, todo_list) do
    entries = Todo.List.entries(todo_list,date)
    {:reply, entries, todo_list}
  end

  def handle_cast({:add, entry}, todo_list) do
    {
      :noreply,
      Todo.List.add_entry(todo_list, entry)
    }
  end

  def handle_cast({:update, id, updater_fn}, todo_list) do
    {
      :noreply,
      Todo.List.update_entry(todo_list, id, updater_fn)
    }
  end

  def handle_cast({:delete, id}, todo_list) do
    {
      :noreply,
      Todo.List.delete(todo_list, id)
    }
  end

  def start do
    GenServer.start(Todo.Server, nil)
  end

  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add, entry})
  end

  def update_entry(pid, id, func) do
    GenServer.cast(pid, {:update, id, func})
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  def delete(pid, id) do
    GenServer.cast(pid, {:delete, id})
  end
end
