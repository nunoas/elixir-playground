defmodule PipePlay do

  def inspecting do
    " InCREASEd ProdUCtivitY is HEar? "
    |> String.trim()
    |> IO.inspect()
    |> String.capitalize()
    |> IO.inspect()
    |> String.replace("hear","here")
    |> IO.inspect()
    |> String.replace("?","!")
  end

  def perform do
    1
    |> add(3)
    |> IO.inspect()
    |> add(10)
    |> IO.inspect()
    |> subtract(5)
    |> IO.inspect()
    |> add(2)
  end

  def add(value1, value2) do
    value1 + value2
  end

  def subtract(value1, value2) do
    value1 - value2
  end

end
