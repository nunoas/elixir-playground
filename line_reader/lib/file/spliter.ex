defmodule File.Spliter do
  @lines 10_000

  def split_file(filename) do
    File.exists?("chuncks") || File.mkdir("chuncks")
    filename
    |> File.stream!(read_ahead: @lines)
    |> Stream.map(&"#{&1}")
    |> Stream.chunk_every(@lines)  # break up into chunks
    |> Enum.reduce(0, fn chunk, acc ->
      spawn( fn ->
        file = File.open!("./chuncks/chunk_#{acc}", [:write])
        IO.write(file, chunk)
        IO.puts("Chunk #{acc} completed")
      end)
      acc + 1
    end)
  end
end
#Benchwarmer.benchmark( fn -> File.Spliter.split_file("bigfile") end)
