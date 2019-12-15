defmodule LineReaderTest do
  use ExUnit.Case
  doctest LineReader

  test "greets the world" do
    assert LineReader.hello() == :world
  end
end
