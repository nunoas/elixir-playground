defmodule TodoListGen do
  use GenServer

  defstruct auto_id: 1, entries: %{}

  def init(_) do
    {:ok, Todo.List.new}
  end

  def handle_call({:entries, date}, _, todo_list) do
    entries =
      todo_list.entries
      |> Stream.filter( fn {_, entry} -> entry.date == date end)
      |> Enum.map( fn {_, entry} -> entry end)
    {:reply, entries, todo_list}
  end

  def handle_cast({:add, entry}, todo_list) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)
    {
      :noreply,
      %TodoList{ todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
    }
  end

  def handle_cast({:update, id, updater_fn}, todo_list) do
      case Map.fetch(todo_list.entries, id) do
        :error ->
          {:noreply, todo_list}
        {:ok, old_entry} ->
          new_entry = updater_fn.(old_entry)
          new_entries = Map.put(todo_list.entries, id, new_entry)
          {:noreply, %TodoList{todo_list | entries: new_entries}}
      end
  end

  def handle_cast({:delete, id}, todo_list) do
    {
      :noreply,
      %TodoList{todo_list | entries: Map.delete(todo_list.entries, id)}
    }
  end

  def start do
    GenServer.start(TodoListGen, nil)
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
