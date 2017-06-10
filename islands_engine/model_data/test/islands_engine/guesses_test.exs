ExUnit.start

defmodule GuessesTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{ Coordinate, Guesses }

  setup do
    {:ok, coord1} = Coordinate.new(1,1)
    {:ok, coord2} = Coordinate.new(2,2)
    {:ok, [guesses:  Guesses.new,
           coord1: coord1,
           coord2: coord2
    ]}
  end

  test "can hit", ctx do
    guesses = ctx.guesses
    guesses = update_in(guesses.hits, &MapSet.put(&1, ctx.coord1))
    guesses = update_in(guesses.hits, &MapSet.put(&1, ctx.coord2))

    c = guesses.hits |> Enum.fetch(0)
    assert MapSet.size(guesses.hits) == 2
    assert elem(c, 1) == ctx.coord1
  end

  test "can miss", ctx do
    guesses = ctx.guesses
    guesses = update_in(guesses.misses, &MapSet.put(&1, ctx.coord1))
    assert MapSet.size(guesses.misses) == 1
  end

  test "cannot duplicate a hit", ctx do
    guesses = ctx.guesses
    guesses = update_in(guesses.hits, &MapSet.put(&1, ctx.coord1))
    guesses = update_in(guesses.hits, &MapSet.put(&1, ctx.coord1))

    assert MapSet.size(guesses.hits) == 1
  end

  test "cannot duplicate a miss", ctx do
    guesses = ctx.guesses
    guesses = update_in(guesses.misses, &MapSet.put(&1, ctx.coord1))
    guesses = update_in(guesses.misses, &MapSet.put(&1, ctx.coord1))

    assert MapSet.size(guesses.misses) == 1
  end
end
