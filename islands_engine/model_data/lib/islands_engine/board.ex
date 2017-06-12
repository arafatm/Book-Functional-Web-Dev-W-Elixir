defmodule IslandsEngine.Board do
  alias IslandsEngine.Island

  def new(), do: %{}

  def all_islands_positioned?(board), do:
    Enum.all?(Island.types, &(Map.has_key?(board, &1)))

  # Enumerate over islands in board and check for overlap
  defp overlaps_existing_island?(board, new_key, new_island) do
    Enum.any?(board, fn {key, island} ->
      key != new_key and Island.overlaps?(island, new_island)
    end)
  end

  defp check_all_islands(board, coordinate) do
    Enum.find_value(board, :miss, fn {key, island} ->
      case Island.guess(island, coordinate) do
        {:hit, island} -> {key, island}
        :miss          -> false
      end
    end)
  end

end
