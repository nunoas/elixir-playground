defmodule TodoServer do
  def start do
    spawn(fn -> loop(TodoList2.new) end)
  end

  defp loop(todo_list) do
    new_todo_list =
      receive do
        {:dump} ->
          IO.inspect(todo_list)
          todo_list
        message -> process_message(todo_list, message)
      end

    loop(new_todo_list)
  end

  def add_entry(todo_server, new_entry) do
    send(todo_server, {:add_entry, new_entry})
  end

  def entries(todo_server, date) do
    send(todo_server, {:entries, self(), date})

    receive do
      {:todo_entries, entries} -> entries
    after
      5000 -> {:error, :timeout}
    end
  end

  def update_entry(todo_server, id, updater_fn) do
    send(todo_server, {:update_entry, id, updater_fn})
  end

  def delete(todo_server, id) do
    send(todo_server, {:delete_entry, id})
  end

  defp process_message(todo_list, {:add_entry, new_entry}) do
    TodoList2.add_entry(todo_list, new_entry)
  end

  defp process_message(todo_list, {:entries, caller, date}) do
    entries = TodoList2.entries(todo_list, date)
    send(caller, {:todo_entries, entries})
    todo_list
  end

  defp process_message(todo_list, {:update_entry, id, updater_fn}) do
    TodoList2.update_entry(todo_list, id, updater_fn)
  end

  defp process_message(todo_list, {:delete_entry, id}) do
    TodoList2.delete(todo_list, id)
  end

end

defmodule TodoList2 do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{
        todo_list |
        entries: new_entries,
        auto_id: todo_list.auto_id + 1
    }
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter( fn {_, entry} -> entry.date == date end)
    |> Enum.map( fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, id, updater_fn) do
      case Map.fetch(todo_list.entries, id) do
        :error ->
          todo_list
        {:ok, old_entry} ->
          new_entry = updater_fn.(old_entry)
          new_entries = Map.put(todo_list.entries, id, new_entry)
          %TodoList{todo_list | entries: new_entries}
      end
  end

  def delete(todo_list, id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, id)}
  end
end
