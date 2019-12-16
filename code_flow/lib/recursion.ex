#---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
#---
defmodule CodeFlow.Recursion do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Fake.Customers
  #alias CodeFlow.Schemas.OrderItem
  alias CodeFlow.Schemas.Customer

  @doc """
  Sum a list of OrderItems to compute the order total.
  """
  def order_total(items) do
    order_total(items, 0)
  end
  
  #def order_total([%Order{} = order | tail], total) do
  def order_total([order | tail], total) do
    order_total(tail, total + order.item.price * order.quantity)
  end

  def order_total([], total), do: total

  @doc """
  Count the number of active customers. Note: Normally this would be done with a
  query to an SQL database. This is just to practice conditionally incrementing
  a counter and looping using recursion.
  """
 
  def count_active(customers_list), do: count_active(customers_list, 0)

  defp count_active([%Customer{active: true} = _customer | tail], count) do
    count_active(tail, count + 1)
  end
  
  defp count_active([%Customer{} = _customer | tail], count) do
    count_active(tail, count)
  end

  defp count_active([], count ), do: count

  @doc """
  Create the desired number of customers. Provide the number of customers to
  create. Something like this could be used in a testing setup.
  """
  def create_customers(number) do
    create_customer(number)
    "Created #{number} customers!"
  end

  defp create_customer(number) when number > 0 do
    Customers.create("Customer #{number}")
    create_customers(number - 1)
  end

  defp create_customer(_number), do: :ok

  @doc """
  Compute the value in the Fibonacci sequence for the number. If the number is
  "10", then the result is 10 plus the value of the 9th index of the fibonacci
  sequence.

  https://en.wikipedia.org/wiki/Fibonacci_number
  """
  def fibonacci(0), do: 0

  def fibonacci(1), do: 1

  def fibonacci(num) do
    fibonacci(num-2) + fibonacci(num-1)
  end

end
