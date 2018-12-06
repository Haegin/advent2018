defmodule Advent2018.Day2 do
  def run do
    IO.puts("Advent 2018, Day 2")
    IO.puts("Part 1")
    part1()
    IO.puts("Part 2")
    part2()
  end

  def part1 do
    case read_input() do
      {:ok, input} ->
        Enum.count(input, fn x -> has_n_letters(x, 2) end)
        *
        Enum.count(input, fn x -> has_n_letters(x, 3) end)
        |> IO.puts
      x -> x
    end
  end

  def part2 do
    case read_input() do
      {:ok, input} ->
        input |>
      x -> x
    end
  end

  defp read_input do
    case File.read("input") do
      {:ok, contents} ->
        {:ok, contents |> String.split}
      {:error, err} ->
        {:error, "Error occurred #{inspect err}"}
    end
  end

  def has_n_letters(string, n) do
    string
    |> String.graphemes
    |> Enum.sort
    |> Enum.reduce(%{}, fn char, acc ->
      Map.get_and_update(acc, char, fn val -> {val, (val || 0) + 1} end) |> elem(1)
    end)
    |> Map.values
    |> Enum.any?(fn val -> val === n end)
  end

  def differences(first, second) do
    Enum.zip(String.graphemes(first), String.graphemes(second))
    |> Enum.count(fn {a, b} -> a != b end)
  end
end

ExUnit.start()

defmodule Advent2018.Day2Test do
  use ExUnit.Case, async: true

  test "has_n_letters" do
    assert Advent2018.Day2.has_n_letters("aa", 2)
    assert Advent2018.Day2.has_n_letters("aa", 2)
    refute Advent2018.Day2.has_n_letters("ab", 2)
    refute Advent2018.Day2.has_n_letters("aaa", 2)
    assert Advent2018.Day2.has_n_letters("babe", 2)
    assert Advent2018.Day2.has_n_letters("babelbot", 3)
  end

  test "differences" do
    assert Advent2018.Day2.differences("aa", "aa") == 0
    assert Advent2018.Day2.differences("ab", "aa") == 1
    assert Advent2018.Day2.differences("aeiou", "uoiea") == 4
  end
end

Advent2018.Day2.run()
