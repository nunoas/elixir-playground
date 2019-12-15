defmodule LineReader do
  # Try #2 -> Enum.at

  def get_line(filename, _line) when not is_binary(filename) do
    {:error, "Invalid Filename"}
  end

  def get_line(_filename, line) when not is_integer(line) or line < 1 do
    {:error, "Invalid line"}
  end

  def get_line(filename, line) do
    File.stream!(filename)
    |> Enum.at(line-1)
    |> String.trim
  end

  # Try #2 -> filter to optmize the stream

  def get_line2(filename, line) do
    File.stream!(filename)
    |> Stream.with_index
    |> Stream.filter(fn {_value, index} -> index == line-1 end)
    |> Enum.at(0)
    |> print_line
  end

  defp print_line({value, _line_number}), do: String.trim(value)
  defp print_line(_), do: {:error, "Invalid Line"}

  # Try #2 -> filter to optmize the stream

  def get_line3(filename, line) do
    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Enum.at(line-1)
    |> print_line
  end


end
