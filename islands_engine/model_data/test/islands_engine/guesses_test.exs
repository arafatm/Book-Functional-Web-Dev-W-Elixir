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

  test "can guess a hit" do
    guesses = Guesses.new()

    {:ok, coord1} = Coordinate.new(8,3)
    guesses = Guesses.add(guesses, :hit, coord1)

    {:ok, coord2} = Coordinate.new(7,9)
    guesses = Guesses.add(guesses, :hit, coord2)

    assert MapSet.size(guesses.hits) == 2
  end

  test "can guess a miss" do
    guesses = Guesses.new()

    {:ok, coord1} = Coordinate.new(8,3)
    guesses = Guesses.add(guesses, :miss, coord1)

    {:ok, coord2} = Coordinate.new(7,9)
    guesses = Guesses.add(guesses, :miss, coord2)

    # TODO: Can't figure out how to pattern match
    # %IslandsEngine.Guesses{hits: #MapSet<[]>, misses: #MapSet<[%IslandsEngine.Coordinate{col: 3, row: 8}, %IslandsEngine.Coordinate{col: 9, row: 7}]>}
    assert MapSet.size(guesses.misses) == 2


  end
end
