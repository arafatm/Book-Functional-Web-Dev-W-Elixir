ExUnit.start

defmodule BoardTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{ Coordinate, Island, Board }

  test "creates an empty map" do
    assert %{} = Board.new()
  end

  test "true if all_islands_positioned?" do
    b = Board.new

    b = Enum.reduce(Island.types, b, fn(x, b) ->
      IO.puts inspect x
      IO.puts inspect b
      Map.put_new(b, x, true)
    end)

    IO.puts inspect b

    assert Board.all_islands_positioned?(b)
  end

  test "false if not all_islands_positioned?" do
    b = Board.new

    b = Map.put_new(b, :square, true)

    refute Board.all_islands_positioned?(b)
  end
end

