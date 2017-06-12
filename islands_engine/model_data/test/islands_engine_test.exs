defmodule IslandsEngineTest do
  use ExUnit.Case
  doctest IslandsEngine

  test "integrate" do

    assert alias IslandsEngine.{Board, Coordinate, Island}

    board = Board.new()

    assert {:ok, square_coordinate} = Coordinate.new(1, 1)

    assert {:ok, square} = Island.new(:square, square_coordinate)

    board = Board.position_island(board, :square, square)

    assert {:ok, dot_coordinate} = Coordinate.new(2, 2)
    assert {:ok, dot} = Island.new(:dot, dot_coordinate)
    assert {:error, :overlapping_island} = Board.position_island(board, :dot, dot)
    assert {:ok, new_dot_coordinate} = Coordinate.new(3, 3)
    assert {:ok, dot} = Island.new(:dot, new_dot_coordinate)
    board = Board.position_island(board, :dot, dot)
    assert {:ok, guess_coordinate} = Coordinate.new(10, 10)
    assert {:miss, :none, :no_win, board} = Board.guess(board, guess_coordinate)
    assert {:ok, hit_coordinate} = Coordinate.new(1, 1)
    assert {:hit, :none, :no_win, board} = Board.guess(board, hit_coordinate)
    square = %{square | hit_coordinates: square.coordinates}
    board = Board.position_island(board, :square, square)
    assert {:ok, win_coordinate} = Coordinate.new(3, 3)
    assert {:hit, :dot, :win, board} = Board.guess(board, win_coordinate)
    IO.inspect {:hit, :dot, :win, board}

    #  {:hit, :dot, :win,
    #   %{dot: %IslandsEngine.Island{
    #       coordinates: #MapSet<[
    #         %IslandsEngine.Coordinate{col: 3, row: 3}
    #       ]>,
    #       hit_coordinates: #MapSet<[
    #         %IslandsEngine.Coordinate{col: 3, row: 3}
    #       ]>},
    #     square: %IslandsEngine.Island{
    #       coordinates: #MapSet<[
    #         %IslandsEngine.Coordinate{col: 1, row: 1},
    #         %IslandsEngine.Coordinate{col: 1, row: 2},
    #         %IslandsEngine.Coordinate{col: 2, row: 1},
    #         %IslandsEngine.Coordinate{col: 2, row: 2}
    #       ]>,
    #       hit_coordinates: #MapSet<[
    #         %IslandsEngine.Coordinate{col: 1, row: 1},
    #         %IslandsEngine.Coordinate{col: 1, row: 2},
    #         %IslandsEngine.Coordinate{col: 2, row: 1},
    #         %IslandsEngine.Coordinate{col: 2, row: 2}
    #       ]>
    #      }
    #    }
    #  }
  end
end
