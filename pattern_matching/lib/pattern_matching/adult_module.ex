defmodule PatternMatching.User.Guards do
  @defmodule """
  Define guard clauses for working with Users.
  """

  @adult_age 18

  defguard is_adult?(age) when age >= @adult_age
  defguard is_minor?(age) when age >= 0 and age < @adult_age
end
