defmodule Test do

    #with test
    
    def with_test do
        data = %{width: 10}
        with {:ok, width} <- Map.fetch(data, :width), {:ok, height} <- Map.fetch(data, :height) do
            {:ok, width * height}
        else
            :error -> {:error, "Kaboom"}
        end
    end

    # tail recursion vs normal recursion

    def sum([num | rest], acc) do
        sum(rest, acc + num)
    end

    def sum([], acc), do: acc

    def sum2([num | rest]) do
        num + sum2(rest)
    end

    def sum2([]), do: 0

    #recursive While

    def build_text(number), do: build_text(0, number, "")

    defp build_text(total, number, text) when total < number do
        build_text(total+1, number, text <> "Processed number #{total}\n")
    end

    defp build_text(_total, _number, text), do: text


    #

    def update_data() do
        data = [
            %{name: "Customer 1", total: 0},
            %{name: "Customer 2", total: 100},
            %{name: "Customer 3", total: 200},
        ];

        #Enum.map(data, fn(val) -> %{val | total: val.total + 50} end)
        #Enum.map(data, fn(val) -> Map.put(val, :total, val.total + 50) end)
        #Enum.map(data, &(%{&1 | total: &1.total + 50}))
        Enum.map(data, &Map.put(&1, :total, &1.total + 50) )
    end

    def values_doubled(list) do
        Enum.map(list, &doubler(&1))
    end

    defp doubler(val) when is_number(val), do: val * 2
    defp doubler(val) when is_binary(val), do: val <> val
    
end