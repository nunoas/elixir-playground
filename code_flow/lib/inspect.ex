defmodule InspectTest do

  def run do
    "   InCREASEd ProdUCtivitY is HEar?  "
    |> IO.inspect(label: "Original")
    |> String.trim()
    |> IO.inspect(label: "Trimmed")
    |> String.capitalize()
    |> IO.inspect(label: "Capitalized")
    |> String.replace("hear", "here")
    |> IO.inspect(label: "Replaced 'hear'")
    |> String.replace("?", "!")
    |> IO.inspect(label: "Replaced '?'")
  end

end