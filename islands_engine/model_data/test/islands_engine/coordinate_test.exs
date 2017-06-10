ExUnit.start

defmodule CoordinateTest do
  use ExUnit.Case, async: true
  alias IslandsEngine.Coordinate

  setup do
    {:ok, [i: 99, c: Coordinate.new(2,5)]}
  end

  test "can create a new coordinate", cx do
    assert cx.c == {:ok, %IslandsEngine.Coordinate{col: 5, row: 2}}
  end

  test "validates coordinate" do
    assert Coordinate.new(0, 0) == {:error, :invalid_coordinate}
  end
end
