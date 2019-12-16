#---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
#---
defmodule CodeFlow.Keywords do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Schemas.Item

  def rounded(value, opts \\ [decimals: 4]) do
    decimals = Keyword.get(opts, :decimals)
    Float.round(value, decimals)
  end

  def unit_price(%Item{} = item, opts \\ []) do
    value = item.price / item.quantity
    case Keyword.get(opts, :mode, :float) do
      :float ->
        value
      :money ->
        :erlang.float_to_binary(value, decimals: 2)
      _ -> {:error, :invalid_mode}
    end
  end

end
