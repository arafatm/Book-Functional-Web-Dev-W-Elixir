#---
# Excerpted from "Functional Web Development with Elixir, OTP, and Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/lhelph for more book information.
#---
defmodule IslandsEngine.Island do
  alias IslandsEngine.{Coordinate, Island}

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  @island_types [:atoll, :dot, :l_shape, :s_shape, :square]

  def new(type, %Coordinate{} = upper_left) do
     with  [_|_] = offsets <- offsets(type),
           %MapSet{} = coordinates <- add_coordinates(offsets, upper_left)
     do
       {:ok, %Island{coordinates: coordinates, hit_coordinates: MapSet.new()}}
     else
       error -> error
     end
  end

  def types(), do: @island_types

  def guess(island, coordinate) do
    case MapSet.member?(island.coordinates, coordinate) do
      true ->
        hit_coordinates = MapSet.put(island.hit_coordinates, coordinate)
        {:hit, %{island | hit_coordinates: hit_coordinates}}
      false -> :miss
    end
  end

  def forested?(island), do:
    MapSet.equal?(island.coordinates, island.hit_coordinates)

  def overlaps?(existing_island, new_island), do:
    not MapSet.disjoint?(existing_island.coordinates, new_island.coordinates)

  defp add_coordinates(offsets, upper_left) do
    Enum.reduce_while(offsets, MapSet.new(), fn offset, acc ->
      add_coordinate(acc, upper_left, offset)
    end)
  end

  defp add_coordinate(coordinates, %Coordinate{row: row, col: col},
       {row_offset, col_offset}) do
    case Coordinate.new(row + row_offset, col + col_offset) do
      {:ok, coordinate}             ->
        {:cont, MapSet.put(coordinates, coordinate)}
      {:error, :invalid_coordinate} ->
        {:halt, {:error, :invalid_coordinate}}
    end
  end

  defp offsets(:atoll),   do: [{0, 0}, {0, 1}, {1, 1}, {2, 0}, {2, 1}]
  defp offsets(:dot),     do: [{0, 0}]
  defp offsets(:l_shape), do: [{0, 0}, {1, 0}, {2, 0}, {2, 1}]
  defp offsets(:s_shape), do: [{0, 1}, {0, 2}, {1, 0}, {1, 1}]
  defp offsets(:square),  do: [{0, 0}, {0, 1}, {1, 0}, {1, 1}]
  defp offsets(_),        do: {:error, :invalid_island_type}
end
