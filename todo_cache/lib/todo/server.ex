defmodule Todo.Server do
  use GenServer

  defstruct auto_id: 1, entries: %{}

  def init(name) do
    {:ok, {name, Todo.Database.get(name) || Todo.List.new}}
    #send(self(), {:real_init, name})
    #register(self, :some_alias)
    #{:ok, nil}
  end

  #def handle_info({:real_init, name}, _state) do
  #  {:noreply, {name, Todo.Database.get(name) || Todo.List.new} }
  #end

  def handle_call({:entries, date}, _, {name, todo_list}) do
    entries = Todo.List.entries(todo_list,date)
    {:reply, entries, {name, todo_list}}
  end

  def handle_cast({:add, entry}, {name, todo_list}) do
    new_state = Todo.List.add_entry(todo_list, entry)
    Todo.Database.store(name, new_state)
    {:noreply, {name, new_state}}
  end

  def handle_cast({:update, id, updater_fn}, {name, todo_list}) do
    new_state = Todo.List.update_entry(todo_list, id, updater_fn)
    Todo.Database.store(name, new_state)
    {:noreply, {name, new_state}}
  end

  def handle_cast({:delete, id}, {name, todo_list}) do
    new_state = Todo.List.delete(todo_list, id)
    Todo.Database.store(name, new_state)
    {:noreply, {name, new_state}}
  end

  def start(todo_list_name) do
    GenServer.start(Todo.Server, todo_list_name)
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
