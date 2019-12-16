#---
# Excerpted from "Thinking Elixir - PatternMatching", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/pattern-matching/ for course
# information.
#---
defmodule PatternMatching.GuardClauses do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias PatternMatching.User
  import PatternMatching.User.Guards

  def return_numbers(value) when is_number(value), do: value
  def return_numbers(_value), do: :error

  def return_lists(value) when is_list(value), do: value
  def return_lists(_value), do: :error

  def return_any_size_tuples(value) when is_tuple(value), do: value
  def return_any_size_tuples(_value), do: :error

  def return_maps(value) when is_map(value), do: value
  def return_maps(_value), do: :error

  def run_function(f) when is_function(f), do: f.()
  def run_function(_value), do: :error

  def classify_user(%User{age: age} = _user) when is_nil(age), do: {:error, "Age missing"}
  #def classify_user(%User{age: nil} = _user), do: {:error, "Age missing"}
  def classify_user(%User{age: age} = _user) when age < 0, do: {:error, "Age cannot be negative"}
  def classify_user(%User{age: age} = _user) when is_minor?(age), do: {:ok, :minor}
  def classify_user(%User{age: age} = _user) when is_adult?(age), do: {:ok, :adult}
  def classify_user(_value), do: {:error, "Not a user"}

  def award_child_points(%User{age: user_age} = user, age, points) when user_age <= age do
    %User{user | points: user.points + points}
  end

  def award_child_points(%User{age: user_age} = user, age, _points) when user_age > age do
    user
  end

end
