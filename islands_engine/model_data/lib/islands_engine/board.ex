defmodule IslandsEngine.Board do
  alias IslandsEngine.Island

  def new(), do: %{}

  # Enumerate over islands in board and check for overlap
  defp overlaps_existing_island?(board, new_key, new_island) do
    Enum.any?(board, fn {key, island} ->
      key != new_key and Island.overlaps?(island, new_island)
    end)
  end
end
