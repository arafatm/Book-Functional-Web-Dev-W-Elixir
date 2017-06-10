defmodule IslandsEngine.Coordinate do

  # So we can use it as %Coordinate{} instead of %IslandsEngine.Coordinate
  alias __MODULE__ 

  @enforce_keys [:row, :col] # must come before defstruct
  defstruct [:row, :col]
end
