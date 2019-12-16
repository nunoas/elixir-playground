defmodule Todo.Database do
  use GenServer

  @workers 20

  def init(db_folder) do
    File.exists?(db_folder) || File.mkdir!(db_folder)
    worker_list =
      for n <- 0..@workers-1 do
        {:ok, pid} = Todo.DatabaseWorker.start("#{db_folder}/persist#{n}/")
        pid
      end
    #IO.inspect(worker_list)
    {:ok, worker_list}
  end

  def handle_cast(_, worker_list) do
    {:noreply, worker_list}
  end

  def handle_call({:get, key}, _, worker_list) do
    {:reply, Enum.at(worker_list, key), worker_list}
  end

  @spec start(any) :: :ignore | {:error, any} | {:ok, pid}
  def start(db_folder) do
    GenServer.start(__MODULE__, db_folder, name: :database_server )
  end

  def store(key, data) do
    Todo.DatabaseWorker.store(get_worker(key), key, data)
  end

  def get(key) do
    Todo.DatabaseWorker.get(get_worker(key), key)
  end

  def get_worker(key) do
    index = :erlang.phash(key, @workers)
    IO.puts "Worker with index #{index}"
    GenServer.call(:database_server, {:get, index-1})
  end
end
