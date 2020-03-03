defmodule RpgTest do
  use ExUnit.Case
  doctest Rpg

  test "greets the world" do
    assert Rpg.hello() == :world
  end
end
