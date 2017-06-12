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
end
