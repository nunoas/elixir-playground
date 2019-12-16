defmodule Testing do

  def do_work(true) do
    {:ok, "I did some work!"}
  end

  def do_work(false) do
    {:ok, "I refuse to work."}
  end

  def do_work(other), do: {:error, "I don't know what to do with #{inspect other}"}

end
