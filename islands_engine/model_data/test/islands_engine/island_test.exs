ExUnit.start

defmodule IslandTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{ Coordinate, Island }

  test "has types" do
    assert [:atoll, :dot, :l_shape, :s_shape, :square] = Island.types
  end

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

  setup overlap do
    {:ok, square_c} = Coordinate.new(1,1)
    {:ok, square} = Island.new(:square, square_c)

    {:ok, dot_c} = Coordinate.new(1,2)
    {:ok, dot} = Island.new(:dot, dot_c)

    {:ok, l_shape_c} = Coordinate.new(5,6)
    {:ok, l_shape} = Island.new(:l_shape, l_shape_c)

    {:ok, square: square, dot: dot, l_shape: l_shape}
  end

  test "checks islands overlap", overlap do
    assert Island.overlaps?(overlap.square, overlap.dot)
  end

  test "checks islands don't overlap", overlap do
    refute Island.overlaps?(overlap.square, overlap.l_shape)
  end

  test "guess is a hit", overlap do
    assert {:hit, coords} = Island.guess(overlap.square, Enum.at(overlap.square.coordinates, 0))
    assert %IslandsEngine.Island{coordinates: coords} = coords
    assert MapSet.size(coords) > 0
  end

  test "guess is a miss", overlap do
    assert :miss = Island.guess(overlap.square, Coordinate.new(5,5))
  end

  test "is forested?", overlap do
    dot = overlap.dot
    {:hit, dot} = Island.guess(dot, Enum.at(dot.coordinates, 0))
    assert Island.forested?(dot)
  end

  test "is not forested?", overlap do
    :miss = Island.guess(overlap.dot, Coordinate.new(5,5))
    refute Island.forested?(overlap.dot)
  end
end
