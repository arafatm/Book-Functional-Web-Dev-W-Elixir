ExUnit.start

defmodule IslandTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{ Coordinate, Island }

  test "can create :atoll" do
    isl = Island.new(:atoll, elem(Coordinate.new(4,6), 1))
    assert {:ok, %Island{coordinates: coordinates, hit_coordinates: _}} = isl
    assert MapSet.size(coordinates) > 0
  end

  test "can create :dot" do
    isl = Island.new(:dot, elem(Coordinate.new(4,6), 1))
    assert {:ok, %Island{coordinates: coordinates, hit_coordinates: _}} = isl
    assert MapSet.size(coordinates) > 0
  end

  test "can create :l_shape" do
    isl = Island.new(:l_shape, elem(Coordinate.new(4,6), 1))
    assert {:ok, %Island{coordinates: coordinates, hit_coordinates: _}} = isl
    assert MapSet.size(coordinates) > 0
  end

  test "can create :s_shape" do
    isl = Island.new(:s_shape, elem(Coordinate.new(4,6), 1))
    assert {:ok, %Island{coordinates: coordinates, hit_coordinates: _}} = isl
    assert MapSet.size(coordinates) > 0
  end

  test "can create :square" do
    isl = Island.new(:square, elem(Coordinate.new(4,6), 1))
    assert {:ok, %Island{coordinates: coordinates, hit_coordinates: _}} = isl
    assert MapSet.size(coordinates) > 0
  end

  test "errors on invalid coordinates" do
    isl = Island.new(:square, elem(Coordinate.new(10,10), 1))
    assert {:error, :invalid_coordinate} = isl
  end

  test "errors on invalid shape" do
    isl = Island.new(:unknown, elem(Coordinate.new(4,6), 1))
    assert {:error, :invalid_island_type} = isl
  end

#  test "has hit_coordinates" do
#    isl = Island.new
#    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
#    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(2,4), 1)))
#    assert MapSet.size(isl.hit_coordinates) == 2
#  end
#
#  test "cannot duplicate a coordinate" do
#    isl = Island.new
#    isl = update_in(isl.coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
#    isl = update_in(isl.coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
#    assert MapSet.size(isl.coordinates) == 1
#  end
#
#  test "cannot duplicate a hit_coordinate" do
#    isl = Island.new
#    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
#    isl = update_in(isl.hit_coordinates, &MapSet.put(&1, elem(Coordinate.new(1,1), 1)))
#    assert MapSet.size(isl.hit_coordinates) == 1
#  end
end
