ExUnit.start

defmodule BoardTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{ Board }

  test "creates an empty map" do
    assert %{} = Board.new()
  end
end

