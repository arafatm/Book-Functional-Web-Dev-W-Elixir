ExUnit.start

defmodule IslandTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{ Coordinate, Island }

  test "has coordinates" do
    isl = Island.new
    isl = update_in(isl.coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
    isl = update_in(isl.coordinates, &MapSet.put(&1, elem(Coordinate.new(2,4), 1)))
    assert MapSet.size(isl.coordinates) == 2
  end

  test "has hit_coordinates" do
    isl = Island.new
    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(2,4), 1)))
    assert MapSet.size(isl.hit_coordinates) == 2
  end

  test "cannot duplicate a coordinate" do
    isl = Island.new
    isl = update_in(isl.coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
    isl = update_in(isl.coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
    assert MapSet.size(isl.coordinates) == 1
  end

  test "cannot duplicate a hit_coordinate" do
    isl = Island.new
    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
    assert MapSet.size(isl.hit_coordinates) == 1
  end
end
