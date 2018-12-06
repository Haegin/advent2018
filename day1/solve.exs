defmodule Advent2018.Day1 do
  def run do
    IO.puts("Advent 2018, Day 1")
    part1()
    part2()
  end

  def part1 do
    IO.puts("Part 1")
    case read_input() do
      {:ok, frequency_changes} ->
        frequency_changes |> Enum.reduce(0, &add_strings/2)
      x -> x
    end |> IO.puts
  end

  def part2 do
    IO.puts("Part 2")
    case read_input() do
      {:ok, frequency_changes} ->
        frequency_changes
        |> Stream.cycle
        |> Stream.transform(fn -> {0, MapSet.new()} end, &tune/2, fn {freq, memory} -> IO.puts(freq) end)
        |> Stream.run
      x -> x
    end
  end

  defp tune(change, {freq, memory}) do
    next_freq = change.(freq)
    if MapSet.member?(memory, next_freq) do
      {:halt, { next_freq, MapSet.put(memory, next_freq) }}
    else
      {[next_freq], {next_freq, MapSet.put(memory, next_freq)}}
    end
  end

  defp read_input do
    case File.read("input1") do
      {:ok, contents} ->
        {:ok, contents |> String.split |> Enum.map(&change_to_func/1)}
      {:error, err} ->
        {:error, "Error occurred #{inspect err}"}
    end
  end

  defp change_to_func(change) do
    case change do
      "+" <> num ->
        fn freq -> freq + String.to_integer(num) end
      "-" <> num ->
        fn freq -> freq - String.to_integer(num) end
    end
  end

  defp add_strings(val, acc) do
    val.(acc)
  end
end

Advent2018.Day1.run()
