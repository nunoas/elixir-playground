#---
# Excerpted from "Thinking Elixir - PatternMatching", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/pattern-matching/ for course
# information.
#---
defmodule PatternMatching.Tuples do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """

  def day_from_date({_y,_m,day}), do: day

  def has_three_elements?({_y,_m,_d}), do: true
  def has_three_elements?(_other), do: false

  @spec major_us_holiday(any) :: <<_::40, _::_*16>>
  def major_us_holiday({_year, 12, _day}), do: "Christmas"
  def major_us_holiday({_year, 7, _day}), do: "4th of July"
  def major_us_holiday({_year, 1, _day}), do: "New Years"
  def major_us_holiday(_other), do: "Uh..."

  def greet_user({:ok, username}), do: "Hello #{username}!"
  def greet_user({:error, _reason}), do: "Cannot greet"

  def add_to_result({:ok, number}), do: {:ok, number + 10}
  def add_to_result(error), do: error

end
