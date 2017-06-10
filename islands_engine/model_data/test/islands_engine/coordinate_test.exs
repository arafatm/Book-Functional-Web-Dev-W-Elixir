ExUnit.start

defmodule CoordinateTest do
  use ExUnit.Case, async: true

  test "testing" do
    c = IslandsEngine.Coordinate.new(1,1)
    IO.puts inspect(c)
    assert c = {:ok, _}
  end
end
