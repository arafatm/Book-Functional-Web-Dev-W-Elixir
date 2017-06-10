#---
# Excerpted from "Functional Web Development with Elixir, OTP, and Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/lhelph for more book information.
#---
defmodule IslandsEngine.Island do

  alias IslandsEngine.Coordinate

  def start_link() do
    Agent.start_link(fn -> [] end)
  end

  def replace_coordinates(island, new_coordinates) when is_list new_coordinates do
    Agent.update(island, fn _state -> new_coordinates end)
  end

  def forested?(island) do
    island
    |> Agent.get(fn state -> state end)
    |> Enum.all?(fn coord -> Coordinate.hit?(coord) end)
  end

  def to_string(island) do
    "[" <> coordinate_strings(island) <> "]"
  end

  defp coordinate_strings(island) do
    island
    |> Agent.get(fn state -> state end)
    |> Enum.map(fn coord -> Coordinate.to_string(coord) end)
    |> Enum.join(", ")
  end
end
