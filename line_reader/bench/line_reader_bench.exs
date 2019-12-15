defmodule LineReaderBend do
  use Benchfella
  alias LineReader

  #bench "Benchmark of get_line" do
  #  LineReader.get_line("./lib/test.txt", 3951360)
  #end

  bench "Benchmark of get_line2" do
    LineReader.get_line("./lib/test.txt", 3951360)
  end
end
