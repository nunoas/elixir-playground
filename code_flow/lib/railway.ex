#---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
#---
defmodule CodeFlow.Railway do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Schemas.User

  @doc """
  Works well when the functions are designed to pass the output of one
  step as the input of the next function.
  """
  def award_points(%User{} = user, points) do
    user
    |> is_active()
    |> is_16()
    |> is_backlisted(["Tom", "Tim", "Tammy"])
    |> increment(points)
  end

  def is_active(%User{active: true}  = user ), do: user
  def is_active(_), do: {:error, "Not an active User"}

  def is_16(%User{age: age} = _user) when is_nil(age), do: {:error, "User age is missing"}
  def is_16(%User{age: age} = _user) when not is_number(age), do: {:error, "User age is invalid"}
  def is_16(%User{age: age} = user) when age >= 16, do: user
  def is_16(%User{age: age} = _user) when age < 16, do: {:error, "User age is below the cuttoff"}
  def is_16(error), do: error


  def is_backlisted(%User{name: name} = user, blacklist) do
    if Enum.member?(blacklist, name) do
      {:error, "User #{inspect(name)} is blacklisted"}
    else
      user
    end
  end
  def is_backlisted(error, _blacklist), do: error

  def increment(%User{points: user_points} = user, points) do
    new_points = user_points + points
    {:ok, %User{user | points: new_points}}
  end
  def increment(error, _points), do: error

end
