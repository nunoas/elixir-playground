defmodule TodoList.CvsImporter do

  def import(file_name) do
    file_name
    |> File.stream!([:read], :line)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map(&String.replace(&1, "/", "-"))
    |> Stream.map( fn line ->
      line
      |> String.split(",")
      |> to_entry()
    end)
    |> TodoList.new()
  end

  @spec to_entry([...]) :: %{date: Date.t(), title: any}
  def to_entry([date,title]) do
    %{ date: Date.from_iso8601!(date), title: title }
  end
end
