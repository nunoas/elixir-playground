defmodule Test do
  def day_abbreviation("Monday"), do: "M"
  def day_abbreviation("Tuesday"), do: "T"
  def day_abbreviation(date), do: "Invalid date '#{date}'"
end
