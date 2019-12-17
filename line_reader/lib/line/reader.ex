defmodule Line.Reader do
  def get_line(filename, _line) when not is_binary(filename) do
    {:error, "Invalid Filename"}
  end

  def get_line(_filename, line) when not is_integer(line) or line < 1 do
    {:error, "Invalid line"}
  end

  def get_line(filename, line) do
    File.stream!(filename)
    |> Stream.with_index
    |> Stream.filter(fn {_value, index} -> index == line-1 end)
    |> Enum.at(0)
    |> get_line
  end

  defp get_line({value, _line_number}), do: {:ok, String.trim(value)}
  defp get_line(_), do: {:error, "Invalid Line"}

  def print_line(filename, line) do
    {_, value} = get_line(filename, line)
    IO.puts(value)
  end


end
