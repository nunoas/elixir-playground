defmodule TodoServer2 do
  def start(callback_module) do
    initial_state = callback_module.new
    spawn(fn -> loop(initial_state, callback_module) end)
  end

  defp loop(current_state, callback_module) do
      receive do
        {:call, request, caller} ->
          {response, new_state} = callback_module.handle_call(current_state, request)
          send(caller, {:response, response})
          loop(new_state, callback_module)
        {:cast, request} ->
          new_state = callback_module.handle_cast(current_state, request)
          loop(new_state, callback_module)
      end
  end

  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})
    receive do
      {:response, response} -> response
      _ -> "Error"
    end
  end

  def cast(server_pid, request) do
    send(server_pid, {:cast, request})
    :ok
  end
end

defmodule TodoList3 do
  alias TodoServer2
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def handle_call(todo_list, {:entries, date}) do
    entries =
      todo_list.entries
      |> Stream.filter( fn {_, entry} -> entry.date == date end)
      |> Enum.map( fn {_, entry} -> entry end)
    {entries, todo_list}
  end

  def handle_cast(todo_list, {:add, entry}) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{
        todo_list |
        entries: new_entries,
        auto_id: todo_list.auto_id + 1
    }
  end

  def handle_cast(todo_list, {:update, id, updater_fn}) do
      case Map.fetch(todo_list.entries, id) do
        :error ->
          todo_list
        {:ok, old_entry} ->
          new_entry = updater_fn.(old_entry)
          new_entries = Map.put(todo_list.entries, id, new_entry)
          %TodoList{todo_list | entries: new_entries}
      end
  end

  def handle_cast(todo_list, {:delete, id}) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, id)}
  end

  def start do
    TodoServer2.start(TodoList3)
  end

  def add_entry(pid, entry) do
    TodoServer2.cast(pid, {:add, entry})
  end

  def update_entry(pid, id, func) do
    TodoServer2.cast(pid, {:update, id, func})
  end

  def entries(pid, date) do
    TodoServer2.call(pid, {:entries, date})
  end

  def delete(pid, id) do
    TodoServer2.cast(pid, {:delete, id})
  end
end
