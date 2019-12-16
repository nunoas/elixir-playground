defmodule ElixirInAction do
  @moduledoc """
  Documentation for ElixirInAction.
  """

  @doc """
  """
  def hello do
    :world
  end

  def large_lines!(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.filter(&(String.length(&1) > 80))
  end

  def lines_lenght!(path) do
    File.stream!(path, [:read], :line)
    |> Stream.map(&String.length(&1))
    |> Enum.to_list()
  end

  def longest_line_lenght!(path) do
    File.stream!(path, [:read], :line)
    |> Stream.map(&String.length(&1))
    |> Enum.max()
  end

  def words_per_line!(path) do
    File.stream!(path, [:read], :line)
    |> Stream.map( fn line ->
      line
      |> String.split()
      |> Enum.count()
    end)
    |> Enum.to_list()
  end
end
