defmodule IslandsEngine.Coordinate do

  # So we can use it as %Coordinate{} instead of %IslandsEngine.Coordinate
  alias __MODULE__ 

  @enforce_keys [:row, :col] # must come before defstruct
  defstruct [:row, :col]

  # row, col are 10 wide
  @board_range 1..10

  # Add a new coordinate if range is valid
  def new(row, col)  when row in(@board_range) and col in(@board_range), do:
  {:ok, %Coordinate{row: row, col: col}}

  # Catch invalid range for row/col
  def new(_row, _col), do: {:error, :invalid_coordinate}

end
